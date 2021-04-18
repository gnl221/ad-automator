#!/bin/bash

for file in *; do
   if [ "${file: -4}" == ".mp3" ]; then
        echo "$file"
        ffmpeg -i "$file" -af "asetrate=44100*0.9595,aresample=44100" "${file%.mp3}_AD.mp3"
    fi
done

for file in *; do
   if [ "${file: -4}" == ".mkv" ] && [ "${file: -6}" != "AD.mkv" ]; then
        VAR=${file: 20:6}
        echo "$VAR"
        echo "$file"
        ffmpeg -i "$file" -i ${VAR}*_AD.mp3 -map 0 -map 1 -c copy "${file%.mkv}_AD.mkv"
    fi
done
