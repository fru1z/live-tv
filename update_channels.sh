eval "$(ssh-agent -s)" > /dev/null
ssh-add -k /home/fru1z/.ssh/github.pem > /dev/null 
cd /mnt/disk2/live-tv &&
curl https://raw.githubusercontent.com/ronmanu/List/refs/heads/main/Lista.m3u | sed 's/acestream:\/\//http:\/\/192.168.5.50:6870\/ace\/manifest.m3u8\?id\=/g' > acestream-1-1.m3u | sed 's/192.168.5.50:6870/192.168.5.50:6875/g' > acestream-2-2.m3u;
curl https://raw.githubusercontent.com/ronmanu/List/refs/heads/main/peliculas.m3u | sed 's/acestream:\/\//http:\/\/192.168.5.50:6870\/ace\/manifest.m3u8\?id\=/g' > pelis.m3u 
curl https://raw.githubusercontent.com/hazofaifo/channels/main/channel.m3u | sed 's/192.168.1.50:6878/192.168.5.50:6870/g' > acestream-1.m3u && cat acestream-1.m3u | sed 's/192.168.5.50:6870/192.168.5.50:6875/g' > acestream-2.m3u;
if [[ "$(git status | grep -o clean)" != clean ]];then 
     git add .;
     git commit -m "Update channels";
     git push;
fi
