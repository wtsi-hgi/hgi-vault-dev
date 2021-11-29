import os
from pathlib import Path
import stat

import click

from src import fix_permissions
from . import __version__


@click.command()
@click.option(
    "--walk_root", required=False, type=click.Path(exists=True), help="Root dir to Walk"
)
@click.version_option(version=__version__)
def walk(walk_root):
    click.secho("walk_root:" + walk_root, fg="green")

    # Paths we're interested in
    ROOT = Path(walk_root)
    click.secho("ROOT:" + ROOT.as_posix(), fg="green")

    fix_permissions.Walker(ROOT)


def main():
    """src Python project."""
    click.secho("..src..", fg="green")
    click.echo(__version__)

    # Mask for permissions for others (not in group).
    os.umask(stat.S_IRWXO)

    walk()
