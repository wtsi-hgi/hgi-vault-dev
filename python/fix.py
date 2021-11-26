"""
this script was copeid from original repo 
https://gitlab.internal.sanger.ac.uk/hgi/fix-hgi-users/-/blob/master/fix.py

This script is used to prepare the files in:

  /lustre/scratch114/teams/hgi

For the trialling/dogfooding of HGI's data retention policy tools[1] It
does the following:

1. Gives all directories ug+wx permissions; this is required to allow
   group users to delete other group user's files (and would normally be
   done by mpistat[2])

2. Gives all files ug+rw and g=u permissions; this is also required to
   allow group users to delete other group user's files (and again would
   normally be done by mpistat)

3. Our data retention policy tools will automatically delete files based
   on their age (defined by their mtime). The files in this directory
   are almost all very old and thus the tools will start deleting
   without notification. This script thus modifies the mtime of every
   file in the following ways:

   * Files in users/ will be specifically targeted first, to limit the
     scope of the trial. Their mtimes will be linearly mapped into a
     range over a three week period starting 85 days before the trial's
     start date. This will cause our data retention policy tools to send
     appropriate notifications and stagger the deletions over those
     three weeks.

   * Files outside of users/ are shifted, relatively, 500 days into the
     future from the trial start date. This preserves their relative
     mtimes, as a set, while shifting them out of the scope of our data
     retention policy tools by a known duration.

[1]: https://github.com/wtsi-hgi/hgi-vault
[2]: https://github.com/wtsi-hgi/mpistat
"""

import os
import stat
from datetime import datetime, timedelta
from pathlib import Path


# Paths we're interested in
ROOT = Path("/lustre/scratch114/teams/hgi")
HGI_USERS = ROOT / "users"


# Oldest and newest mtimes for files in users/
# (determined via pre-processing)
HGI_USERS_OLDEST = datetime.utcfromtimestamp(1600729200)

HGI_USERS_NEWEST = datetime.utcfromtimestamp(1602543600) 
_RANGE = HGI_USERS_NEWEST - HGI_USERS_OLDEST

# Trial minimum and maximum range for files in users/
_TRIAL_START  = datetime(2021, 8, 27)
_TRIAL_LENGTH = timedelta(days=21)  # i.e., 3 week window
HGI_USERS_TRIAL_START  = _TRIAL_START - timedelta(days=85)
HGI_USERS_TRIAL_FINISH = HGI_USERS_TRIAL_START + _TRIAL_LENGTH


def is_under(path:Path, parent:Path) -> bool:
    try:
        _ = path.relative_to(parent)
        return True
    except ValueError:
        return False


def change_mtime(path:Path, mtime:datetime):
    os.utime(path, (path.stat().st_atime, int(mtime.timestamp())))


def scale_mtime(mtime:datetime) -> datetime:
    # Scale mtime from between OLDEST:NEWEST into between TRIAL_START:TRIAL_FINISH
    scale = (mtime - HGI_USERS_OLDEST) / _RANGE
    return HGI_USERS_TRIAL_START + (scale * _TRIAL_LENGTH)


def shift_mtime(mtime:datetime) -> datetime:
    # Shift the mtime, relative to the oldest file, 500 days into the
    # future from the trial start date
    delta = mtime - HGI_USERS_OLDEST
    return _TRIAL_START + delta + timedelta(days=500)


class Walker:
    def __init__(self, root:Path) -> None:
        self._walk(root.resolve())

    def _walk(self, directory:Path) -> None:
        for path in directory.iterdir():
            if not path.is_symlink():
                if path.is_dir():
                    self.act_on_directory(path)
                    self._walk(path)

                elif path.is_file():
                    self.act_on_file(path)

    def act_on_file(self, path:Path) -> None:
        file_stat = path.stat()

        # File gets ug+rw and g=u
        mode = file_stat.st_mode
        mode |= stat.S_IRUSR | stat.S_IWUSR
        mode |= (mode & stat.S_IRWXU) >> 3
        path.chmod(mode)

        # Update mtime appropriately
        mtime = datetime.utcfromtimestamp(file_stat.st_mtime)
        mtime = scale_mtime(mtime) if is_under(path, HGI_USERS) else shift_mtime(mtime)
        change_mtime(path, mtime)

        print(f"File\t{path}\tug+rw,g=u; mtime {mtime}")

    def act_on_directory(self, directory:Path) -> None:
        # Directory gets ug+wx
        mode = directory.stat().st_mode
        mode |= stat.S_IWUSR | stat.S_IXUSR | stat.S_IWGRP | stat.S_IXGRP
        directory.chmod(mode)

        print(f"Directory\t{directory}\tug+wx")


if __name__ == "__main__":
    os.umask(stat.S_IRWXO)
    Walker(ROOT)
