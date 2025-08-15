#!/bin/bash
archivo="ronmDeportes-1.m3u"
archivo_tmp="tmp_$archivo"
archivo_salida="formateado_test222222_$archivo"

# 1️⃣ Procesar línea a línea para mover tvg-id al final del nombre
> "$archivo_tmp"
while IFS= read -r linea; do
  if [[ "$linea" == \#EXTINF* ]]; then
    tvg_id=$(echo "$linea" | grep -oE 'tvg-id="[^"]+"' | cut -d'=' -f2 | tr -d '"')
    if [ -n "$tvg_id" ]; then
      linea="$linea, $tvg_id"
    fi
  fi
  echo "$linea" >> "$archivo_tmp"
done < "$archivo"

sed -i -E 's/ *tvg-id="[^"]*"//g' $archivo_tmp
sed -i -E 's/  / /g' $archivo_tmp
sed -i -E 's/\"tvg-id=/tvg-id=\"/g' $archivo_tmp

{
    echo "#EXTM3U"
    awk '
    BEGIN { FS=","; OFS="," }
    {
        if ($0 ~ /^#EXTINF/) {
            extinf=$0
            getline url
            match(extinf, /group-title="([^"]+)"/, m)
            grupo = (m[1] != "" ? m[1] : "ZZZ_SinGrupo")
            print grupo "|" extinf "|" url
        }
    }
    ' "$archivo_tmp" | sort -t"|" -k1,1 -k2,2 | awk -F"|" '{ print $2 "\n" $3 }'
} > "$archivo_salida"

rm "$archivo_tmp"

echo "Archivo formateado y ordenado guardado en: $archivo_salida"
