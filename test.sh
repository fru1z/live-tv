#!/bin/bash
archivo="ronmDeportes-1.m3u"
archivo_salida="formateado_test3333_$archivo"
while IFS= read -r linea; do
  if [[ "$linea" == \#EXTINF* ]]; then
    tvg_id=$(echo "$linea" | grep -oE '"tvg-id=[^"]+"' | cut -d'=' -f2 | tr -d "\"")
    if [ -n "$tvg_id" ]; then
      linea="$linea, $tvg_id"
    fi
  fi
  echo "$linea" >> "$archivo_salida"
done < "$archivo"

sed -i -E 's/ *tvg-id="[^"]*"//g' $archivo
sed -i -E 's/  / /g' $archivo
sed -i -E 's/\"tvg-id=/tvg-id=\"/g' $archivo


