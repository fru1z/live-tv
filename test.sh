#!/bin/bash
archivo="ronmtest-1.m3u"
archivo_salida="formateado_$archivo"
while IFS= read -r linea; do
  if [[ "$linea" == \#EXTINF* ]]; then
    tvg_id=$(echo "$linea" | grep -oE '"tvg-id=[^"]+"' | cut -d'=' -f2)
    if [ -n "$tvg_id" ]; then
      linea="$linea, $tvg_id"
    fi
  fi
  echo "$linea" >> "$archivo_salida"
done < "$archivo"


