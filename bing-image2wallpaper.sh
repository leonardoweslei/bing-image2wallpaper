#!/bin/bash
function atoi()
{
	x=${1%%[!0-9]*};
	return $x;
}
function background()
{
	if [ $# -eq 0 ] ; then
		echo -e "Use\n\tbackground get\n ou \n\tbackground remove\n ou \n\tbackground set <url>";
		return 0;
	fi
	if [ "$1" == "set" ] ; then
		if [ ! -e "$2" ] || [ $# -eq 1 ] ; then
			echo -e "Use\n\tbackground get\n ou \n\tbackground remove\n ou \n\tbackground set <url>";
			return 0;
		fi
		if [ "$DESKTOP_SESSION" == "ubuntu-2d" ] || [ "$DESKTOP_SESSION" == "ubuntu" ] || [ "$DESKTOP_SESSION" == "gnome-shell" ] || [ "$DESKTOP_SESSION" == "gnome-classic" ] || [ "$DESKTOP_SESSION" == "gnome-fallback" ] || [ "$DESKTOP_SESSION" == "gnome-classic" ] ; then
			gsettings set org.gnome.desktop.background picture-uri "file://"$2;
			return 1;
		elif [ "$DESKTOP_SESSION" == "kde-plasma" ]; then
			kwriteconfig --file plasma-desktop-appletsrc --group Containments --group 1 --group Wallpaper --group image --key wallpaper $2;
			kquitapp plasma-desktop;
			sleep 2;
			plasma-desktop &
			return 1;
		elif [ "$DESKTOP_SESSION" == "xfce" ] || [ "$DESKTOP_SESSION" == "xubuntu" ] ; then
			xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s $2;
			return 1;
		elif [ "$DESKTOP_SESSION" == "mate" ]; then
			mateconftool-2 --type string --set /desktop/mate/background/picture_filename $2;
			return 1;
		elif [ "$DESKTOP_SESSION" == "fluxbox" ]; then
			fbsetbg -f $2;
			return 1;
		elif [ "$DESKTOP_SESSION" == "Lubuntu" ] || [ "$DESKTOP_SESSION" == "LXDE" ]; then
			pcmanfm --wallpaper-mode=stretch --set-wallpaper=$2;
			return 1;
		elif [ "$(which gconftool-2)" != "" ] ; then
			gconftool-2 --type string --set /desktop/gnome/background/picture_filename $2;
			return 1;
		elif [ "$(which gconftool)" != "" ] ; then
			gconftool --type string --set /desktop/gnome/background/picture_filename $2;
			return 1;
		fi
	elif [ "$1" == "get" ] ; then
		if [ "$DESKTOP_SESSION" == "ubuntu-2d" ] || [ "$DESKTOP_SESSION" == "ubuntu" ] || [ "$DESKTOP_SESSION" == "gnome-shell" ] || [ "$DESKTOP_SESSION" == "gnome-classic" ] || [ "$DESKTOP_SESSION" == "gnome-fallback" ] || [ "$DESKTOP_SESSION" == "gnome-classic" ] ; then
			echo $(echo $(gsettings get org.gnome.desktop.background picture-uri)| sed 's/file:\/\///g'| sed "s/'//g");
			return 1;
		elif [ "$DESKTOP_SESSION" == "kde-plasma" ]; then
			echo $(kreadconfig --file plasma-desktop-appletsrc --group Containments --group 1 --group Wallpaper --group image --key wallpaper);
			return 1;
		elif [ "$DESKTOP_SESSION" == "xfce" ] || [ "$DESKTOP_SESSION" == "xubuntu" ] ; then
			echo $(xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path);
			return 1;
		elif [ "$DESKTOP_SESSION" == "mate" ]; then
			echo $(mateconftool-2 --get /desktop/mate/background/picture_filename);
			return 1;
		elif [ "$DESKTOP_SESSION" == "fluxbox" ]; then
			echo $(cat ~/.fluxbox/lastwallpaper | grep full | cut -d '|' -f2);
			return 1;
		elif [ "$DESKTOP_SESSION" == "Lubuntu" ]; then
			echo $(cat ~/.config/pcmanfm/lubuntu/pcmanfm.conf | egrep 'wallpaper=(.*)'| sed 's/wallpaper=//g');
			return 1;
		elif [ "$DESKTOP_SESSION" == "LXDE" ]; then
			echo $(cat ~/.config/pcmanfm/LXDE/pcmanfm.conf | egrep 'wallpaper=(.*)'| sed 's/wallpaper=//g');
			return 1;
		elif [ "$(which gconftool-2)" != "" ] ; then
			echo $(gconftool-2 --get /desktop/gnome/background/picture_filename);
			return 1;
		elif [ "$(which gconftool)" != "" ] ; then
			echo $(gconftool --get /desktop/gnome/background/picture_filename);
			return 1;
		fi
	elif [ "$1" == "remove" ] ; then
		if [ "$DESKTOP_SESSION" == "ubuntu-2d" ] || [ "$DESKTOP_SESSION" == "ubuntu" ] || [ "$DESKTOP_SESSION" == "gnome-shell" ] || [ "$DESKTOP_SESSION" == "gnome-classic" ] || [ "$DESKTOP_SESSION" == "gnome-fallback" ] || [ "$DESKTOP_SESSION" == "gnome-classic" ] ; then
			gsettings reset org.gnome.desktop.background picture-uri;
			return 1;
		elif [ "$DESKTOP_SESSION" == "kde-plasma" ]; then
			kwriteconfig --file plasma-desktop-appletsrc --group Containments --group 1 --group Wallpaper --group image --key wallpaper "";
			return 1;
		elif [ "$DESKTOP_SESSION" == "xfce" ] || [ "$DESKTOP_SESSION" == "xubuntu" ] ; then
			xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -r;
			return 1;
		elif [ "$DESKTOP_SESSION" == "mate" ]; then
			mateconftool-2 --unset /desktop/mate/background/picture_filename;
			return 1;
		elif [ "$DESKTOP_SESSION" == "fluxbox" ]; then
			/usr/bin/fbsetroot -solid black;
			return 1;
		elif [ "$DESKTOP_SESSION" == "Lubuntu" ] || [ "$DESKTOP_SESSION" == "LXDE" ]; then
			pcmanfm --wallpaper-mode=color;
			return 1;
		elif [ "$(which gconftool-2)" != "" ] ; then
			gconftool-2 --unset /desktop/gnome/background/picture_filename;
			return 1;
		elif [ "$(which gconftool)" != "" ] ; then
			gconftool --unset /desktop/gnome/background/picture_filename;
			return 1;
		fi
	else
		echo -e "Use\n\tbackground get\n ou \n\tbackground remove\n ou \n\tbackground set <url>";
	fi
	return 0;
}
mk=~/Dropbox/projetos/marcadagua.jpg;
dir=~/images_downloaded/;
#Bing - bing.com, bing.co.jp
#NASA - http://apod.nasa.gov
#Earth Science - http://epod.usra.edu
#National Geographic - http://photography.nationalgeographic.com/photography/photo-of-the-day
#Nature - http://www.naturepicoftheday.com
#Flickr - http://www.flickr.com/explore/

service="bing";
echo -e "Iniciando sistema...\n";
data=$(date +"%Y%m%d");
atoi $(date +"%H");
hora=$?;
if [ ! -e $dir ]; then
	mkdir -p $dir;
fi
urld=$dir/$data.jpg;
urld2=$dir/$data"2.jpg";
while :; do
	datanow=$(date +"%Y%m%d");
	atoi $(date +"%H");
	horanow=$?;
	bgactive=$(background "get");
	#echo -e $bgactive " " $urld "\n";
	if [ "$(du -sh $urld2 | cut -f1)" == "" ] || [ "$(file $urld2 | cut -d ' ' -f3)" != "image" ] ; then
		echo -e "Apagando imagem vazia...\n";
		rm -rf $urld;
	fi
	if [ $datanow -gt $data ] || [ $horanow -gt $hora ] || [ ! -e $urld ] ; then
		data=$datanow;
		hora=$horanow;
		data=$(date +"%Y%m%d");
		atoi $(date +"%H");
		hora=$?;
		urld=$dir/$data.jpg;
		urld2=$dir/$data"2.jpg";
		if [ ! -e $urld ] ; then
			temp=$(tempfile);
			if [ $service == "bing" ] ; then
				echo -e "Baixando imagem do bing...\n";
				wget --quiet bing.com -O $temp >/dev/null;
				img=$(cat $temp | sed "s/[;,:']/\n/g" | egrep "(.*)az(.*)\.(png|jpg|jpeg)$");
				url="www.bing.com$img";
			elif [ $service == "flickr" ] ; then
				echo -e "Baixando imagem do flickr...\n";
				wget --quiet www.flickr.com/explore/ -O $temp >/dev/null;
				img=$(cat $temp | sed "s/[\n\t]//g" | egrep "photo_container(.*)span" | awk -F'"' 'NR>1&&$0=$2' RS='href=');
				user=$(echo $img | cut -d "/" -f3);
				img_id=$(echo $img | cut -d "/" -f4);
				wget --quiet "www.flickr.com/photos/"$user"/"$img_id"/sizes/l/in/photostream/" -O $temp >/dev/null;
				img=$(cat $temp | sed "s/[\n\t]//g" | sed -n '/'$img_id'/s/.*src="\(.*\)".*/\1/p');
				url=$(echo $img | cut -d " " -f1);
			elif [ $service == "nasa" ] ; then
				echo -e "Baixando imagem da nasa...\n";
				wget --quiet apod.nasa.gov -O $temp>/dev/null;
				img=$(cat $temp | sed -n '/a/s/href="\(.*\)".*/\1/p'| grep "image"|sed 's/<a //g');
				url="apod.nasa.gov/"$img;
			elif [ $service == "earthscience" ] ; then
				echo -e "Baixando imagem do Earth Science...\n";
				wget --quiet http://epod.usra.edu -O $temp>/dev/null;
				img=$(cat $temp | sed "s/[<]/\n</g" | sed -n '/a/s/href=".*"/\0/p'| grep "/.a/"|cut -d '"' -f2);
				url=$img;
			elif [ $service == "nationalgeographic" ] ; then
				echo -e "Baixando imagem do National Geographic...\n";
				wget --quiet http://photography.nationalgeographic.com/photography/photo-of-the-day -O $temp>/dev/null;
				img=$(cat $temp | sed "s/[<]/\n</g" | sed -n '/img/s/src=".*"/\0/p'| grep "media-live"|cut -d '"' -f2);
				url=$(echo $img | cut -d " " -f1);
			elif [ $service == "nature" ] ; then
				echo -e "Baixando imagem da Nature...\n";
				wget --quiet http://www.naturepicoftheday.com/ -O $temp>/dev/null;
				img=$(cat $temp | sed "s/[<]/\n</g" | sed -n '/a/s/href=.*/\0/p'| grep "/npods/"|cut -d '=' -f2 | cut -d '>' -f1);
				url="http://www.naturepicoftheday.com"$img;
			fi
			wget --quiet $url -O $urld >/dev/null;
		fi
		sleep 2;
		wtmk=$(which composite);
		if [ "$wtmk" != "" ] && [ -e $mk ] ; then
			composite -dissolve 50% -gravity center -quality 100 $mk $urld $urld2;
			urld=$urld2;
		fi
		echo -e "Removendo background...\n";
		background "remove";
		sleep 5;
		echo -e "Setando background...\n";
		background "set" $urld;
		sleep 10;
	elif [ $bgactive != $urld2 ]  && [ -e $urld2 ] ; then
		echo -e "Setando background...\n";
		background "set" $urld2;
		sleep 10;
	else
		echo -e "background OK\nVoltando em 1h...\n";
		sleep 10;
	fi
done
