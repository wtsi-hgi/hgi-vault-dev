This folder contains fix.py, which was designed to enable us to start sandman on /lustre/scratch114/teams/hgi without deleting everything immediately.

That location no longer exists, and the machansim of putting mtimes in to the future is discouraged by ISG.

With the newer version of sandman that considers ctime, we only have to change permissions or create and then delete hardlinks to the files to stop them being deleted immediately, though all unused files would then be warned about in one go for each user.

So probably fix.py shouldn't be used, but maybe a variant on it that updated ctime on all files to today would be useful.
