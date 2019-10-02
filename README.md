# THREDDS Test Data

This repository contains scripts for managing the test datasets needed to run the full netCDF-Java and THREDDS Data Server (TDS) unit and integration tests.
Previously, this repository used `git lfs`.
However, the data are just too big at this point to take that approach.
We may revisit `git lfs` in the future, but for now, we've moved on.
If you previously cloned this repository, you will need to remove your local copy and create a fresh clone.
The data are hosted on a one-way, anonymous rsync server.

![caution](http://www.textfiles.com/underconstruction/HeartlandPrairie1139notusingconstructionbar.gif)

The size of the test data is not "a fine boi" - it is _large_.
Syncing will take approximately 100 GB of disk space.

![chonk](https://i.imgur.com/sNqNi9E.png)

## Working with this repository

All you need to fetch and manage (i.e. keep up-to-date) the test data is `rsync`.
`rsync` is available "out of the box" on all (?) Unix, Linux, and MacOS systems.
If you are on windows, you will first need to install a copy of `rsync` (see [here](#rsync-on-windows) for details).

Although you can download and use a static copy of the `rsync` script appropriate for your system (windows or \*nix), we recommend using `git` to clone this repository.
If you fetch this repository with `git`, then you will be able to keep your sync scripts up-to-date if changes are made, and everybody wins.

Once you clone the repository, simply run the appropriate script:

On Unix, Linux, and MacOS systems (using `bash`):
  ~~~bash
  bash synch_test_data.sh
  ~~~

On Windows (using powershell):

  ~~~powershell
  powershell.exe sync_test_data.ps1
  ~~~

The initial sync will take some time.
Incremental updates can be obtained by re-running the script, and will take much less time.
The netcdf-java and TDS tests create several intermediate files; these should be cleaned up between runs, which can be done by re-running the script.

## Adding/Moving/Modifying data

If there are changes that need to be made to the test data suite, please open an issue on this repository and we'll discuss.
Because the rsync server is one-way, someone at the Unidata Program Center will need to make the changes manually on the rsync server.

## rsync on windows

To use rsync on windows, we recommend using [DeltaCopy](http://www.aboutmyip.com/AboutMyXApp/DeltaCopy.jsp).
From the DeltaCopy site:
> In technical terms, DeltaCopy is a "Windows Friendly" wrapper around the Rsync program, currently maintained by [Wayne Davison](http://samba.anu.edu.au/rsync/).
> "rsync" is primarily designed for Unix/Linux/BSD systems.
> Although ports are available for Windows, they typically require downloading Cygwin libraries and manual configuration.

While you can use rsync on Windows via Cygwin or any of the Linux distributions suppored by the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10), using DeltaCopy will allow you to use rsync directly from Windows powershell.
To use DeltaCopy with the powershell script included in this repository:
1. Download DeltaCopy.
   We recommend the "non-installer" version, which can be obtained [here](http://www.aboutmyip.com/AboutMyXApp/DeltaCopyDownloadRaw.jsp)(note: this link will trigger a download).
1. Uncompress the contents of `DeltaCopyRaw.zip` and place the folder anywhere in your home directory (just note the location).
1. Make sure the folder is on your Users path by editing the `Path` environment variable.
   See [here](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/) for details (note: this post shows editing the System `Path` variable, but you can edit the user `Path` variable through the same interface).
