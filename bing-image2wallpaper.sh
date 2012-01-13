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
		elif [ "$DESKTOP_SESSION" == "xfce" ] || [ "$DESKTOP_SESSION" == "xubuntu" ] ; then
			xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s $2;
			return 1;
		elif [ "$DESKTOP_SESSION" == "mate" ]; then
			mateconftool-2 --type string --set /desktop/mate/background/picture_filename $2;
			return 1;
		elif [ "$DESKTOP_SESSION" == "fluxbox" ]; then
			fbsetbg -f $2;
			return 1;
		fi
	elif [ "$1" == "get" ] ; then
		if [ "$DESKTOP_SESSION" == "ubuntu-2d" ] || [ "$DESKTOP_SESSION" == "ubuntu" ] || [ "$DESKTOP_SESSION" == "gnome-shell" ] || [ "$DESKTOP_SESSION" == "gnome-classic" ] || [ "$DESKTOP_SESSION" == "gnome-fallback" ] || [ "$DESKTOP_SESSION" == "gnome-classic" ] ; then
			echo $(echo $(gsettings get org.gnome.desktop.background picture-uri)| sed 's/file:\/\///g'| sed "s/'//g");
			return 1;
		elif [ "$DESKTOP_SESSION" == "xfce" ] || [ "$DESKTOP_SESSION" == "xubuntu" ] ; then
			echo $(xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path);
			return 1;
		elif [ "$DESKTOP_SESSION" == "mate" ]; then
			echo $(mateconftool-2 --get /desktop/mate/background/picture_filename);
			return 1;
		fi
	elif [ "$1" == "remove" ] ; then
		if [ "$DESKTOP_SESSION" == "ubuntu-2d" ] || [ "$DESKTOP_SESSION" == "ubuntu" ] || [ "$DESKTOP_SESSION" == "gnome-shell" ] || [ "$DESKTOP_SESSION" == "gnome-classic" ] || [ "$DESKTOP_SESSION" == "gnome-fallback" ] || [ "$DESKTOP_SESSION" == "gnome-classic" ] ; then
			gsettings reset org.gnome.desktop.background picture-uri;
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
		fi
	else
		echo -e "Use\n\tbackground get\n ou \n\tbackground remove\n ou \n\tbackground set <url>";
	fi
	return 0;
}
mk=~/Dropbox/projetos/marcadagua.jpg;
echo -e "Iniciando sistema...\n";
data=$(date +"%Y%m%d");
atoi $(date +"%H");
hora=$?;
paises[0]="us";
#paises[1]="us";
#paises[2]="uk";
#paises[3]="au";
#paises[4]="jp";
#paises[5]="cn";
#paises[6]="nz";
#paises[7]="de";
#paises[8]="ca";
pais=$(($RANDOM%$hora));
pais=$(($pais%${#paises[*]}));
pais=${paises[$pais]};
urld=~/bing_images/$data-$pais.jpg;
while :; do
	datanow=$(date +"%Y%m%d");
	atoi $(date +"%H");
	horanow=$?;
	if [ -e $urld ] || [ $(du -sh $urld | cut -f1) -eq 0 ] || [ $(file $urld | cut -d ' ' -f3) != "image" ] ; then
		tam=$(du -sh $urld | cut  -f1);
		tam=${tam%%[!0-9]*};
		if [ "$tam" -eq 0 ] ; then
			echo -e "Apagando imagem vazia...\n";
			rm -rf $urld;
			sleep 0;
		fi
	fi
	if [ $datanow -gt $data -o $horanow -gt $hora ] || [ ! -e $urld ] ; then
		data=$datanow;
		hora=$horanow;
		data=$(date +"%Y%m%d");
		atoi $(date +"%H");
		hora=$?;
		pais=$(($RANDOM%$hora));
		pais=$(($pais%${#paises[*]}));
		pais=${paises[$pais]};
		urld=~/bing_images/$data-$pais.jpg;
		urld2=~/bing_images/$data-$pais"2.jpg";
		if [ ! -e "$HOME/bing_images/" ] ; then
			echo -e "Criando diretorio de imagens...\n";
			mkdir ~/bing_images;
		fi
		if [ ! -e $urld ] ; then
			cd /tmp;
			rm .tmp.txt*;
			echo -e "Baixando imagem$data-${paises[$hora]}.jpg do bing...\n";
			wget $pais.bing.com -O .tmp.txt >/dev/null;
			img=$(cat .tmp.txt | sed "s/[;,:']/\n/g" | egrep "(.*)az(.*)\.(png|jpg|jpeg)$");
			#$(cat .tmp.txt | sed "s/[;,']/\n/g" | egrep "url(.*)(png|jpg|jpeg)$" | sed 's/\\//g');
			url="www.bing.com$img";
			wget $url -O $urld >/dev/null;
			cd $OLDPWD;
		fi
		sleep 2;
		wtmk=$(which composite);
		if [ "$wtmk" != "" ] && [ -e $mk ] ; then
			composite -dissolve 50% -gravity center -quality 100 $mk $urld $urld2;
			urld=$urld2;
		fi
		echo -e "Removendo background...\n";
		background "remove";
		echo -e "Setando background...\n";
		background "set" $urld;
		sleep $((60*15));
		#sleep 1;
	fi
done
