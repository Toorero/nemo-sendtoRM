#!/bin/bash

: ${DIR_FILE:=".rmdir"}
: ${TITLE:="rM API"}
: ${MAX_LEVEL:=5}
declare rmdir
SELECTED_FILE_PATHS=("$@")

# fix for nemo action
cd "$(dirname "$SELECTED_FILE_PATHS[0]")"

# simulate rmapi mkdir -p $1
rmapi_mkdir_p() {
	local traversed=""
	local IFS="/"
	for i in ${1#/}
	do
		traversed="$traversed/$i"
		rmapi mkdir "$traversed"
	done
}

if [ -f "$DIR_FILE" ]
then
    rmdir=$(cat "$DIR_FILE")
else
    # check if relative path creation is possible and confirmed by user
    cwd="." # current directory in which we search for the DIR_FILE file
    
    pipe="$(mktemp -t -u rmprogress.XXXX)"
    mkfifo "$pipe" || { zenity --error --title "$TITLE" --text "Konnte Pipe nicht erstellen" && exit; }
    zenity --progress --auto-close --title "$TITLE" < "$pipe" &
    
    for (( i=1; i<=$MAX_LEVEL; i++ ))
    do
        cwd="$cwd/.."
        echo $(( $i/$MAX_LEVEL * 100 )) > "$pipe"
        echo "# Suche nach \"$DIR_FILE\" Datei" > "$pipe"

        if [ -f "$cwd/$DIR_FILE" ]
        then
            echo 100 > "$pipe"
            pwd_diff="${PWD#$(realpath $cwd)}"
            export rmdir="$(cat "$cwd/$DIR_FILE")$pwd_diff"
            ! zenity --question --title "$TITLE" --ellipsize --text "Keine \"$DIR_FILE\" Datei im aktuellen Verzeichnis gefunden.\n\nRelativ ermittelten Pfad \"$rmdir\" verwenden?" && unset rmdir
            break
        fi
    done
	rm "$pipe"
    
    # get custom user input path
    if ! [ -v rmdir ]
    then
        ! rmdir="$(zenity --forms --add-entry "Ordner auf reMarkable:" --title "$TITLE" --text "Gib den Ordner auf dem reMarkable an")" && exit

        # and maybe save it
        zenity --question --text="Auswahl für den aktuellen Ordner speichern?" && echo "$rmdir" > "$DIR_FILE"
    fi
fi

# upload files
rmapi_mkdir_p "$rmdir"

IFS=$'\n'
for file in "${SELECTED_FILE_PATHS[@]}"
do
    echo "Hochladen von $file"
    rmapi put "$file" "$rmdir"
    echo
done 2>&1 | zenity --text-info --title "$TITLE"
