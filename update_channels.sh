cd /mnt/disk2/live-tv &&
curl https://raw.githubusercontent.com/hazofaifo/channels/main/channel.m3u | sed 's/192.168.1.50:6878/192.168.5.50:6870/g' > acestream-1.m3u && cat acestream-1.m3u | sed 's/192.168.5.50:6870/192.168.5.50:6875/g' > acestream-2.m3u;
if [[ "$(git status | grep -o clean)" != clean ]];then 
     git add .;
     git commit -m "Update channels";
     git push;
fi