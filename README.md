# Nemo send to reMarkable #

This is a basic script that guides you to upload your current selected files in [nemo](https://github.com/linuxmint/nemo) or [nautilus](https://gitlab.gnome.org/GNOME/nautilus) to the [reMarkable tablet](https://remarkable.com/) using the fabulous [rMAPI](https://github.com/juruen/rmapi) as backend.

If you want to remember the remote folder, for the current folder you can check the checkbox and this folder will be remembered and you won't be asked the next time you upload a file from the folder **or any other direct subfolder**.

You can manually set the path for a folder by placing an `.rmdir` file containing the remote folder name into it.
 
---

### Installation ##

1. Install [rMAPI](https://github.com/juruen/rmapi)
2. Install [zenity](https://gitlab.gnome.org/GNOME/zenity)
3. Make sure to export the location of the rmapi binary and zenity to your `PATH`-variable:
   `whereis rmapi` should yield a path to the binary

### As A Nemo Action (recommended) ###

4. Simply copy the files `send-to-rM.*` into `~/.local/share/nemo/actions` 

### As Nemo/Nautilus Script ###

4. Simply copy the file `send-to-rM.sh` into `~/.local/share/nemo/scripts` (or `~/.local/share/nautilus/scripts`) 
You can name the file as you see fit.



