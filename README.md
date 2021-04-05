# nemo-sendtoRM

This is a basic script that guides you to upload your current selected files in the [nemo](https://github.com/linuxmint/nemo) to the [reMarkable tablet](https://remarkable.com/) using the fabioulus [rMAPI](https://github.com/juruen/rmapi) as the backend.

If you wan't to remember the remote folder for the current folder you can check the checkbox and this folder will be remembered and you won't be asked the next time you upload a file from the folder or any other direct subfolder.

# Installation

1. [Install rMAPI](https://github.com/juruen/rmapi) if you havn't done that already.
2. Ensure that you have exported the location of the rmapi binary to your PATH-variable (`whereis rmapi` should yield a path to the binary) or exchange `rmapi` on line 30 in the script to the absolute path to the binary.
3. Copy the "put on remarkable" file into `~/.local/share/nemo/scripts/`
4. Enjoy!
