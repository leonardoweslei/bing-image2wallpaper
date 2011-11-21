#!/bin/bash
atoi()
{
	x=${1%%[!0-9]*};
	return $x;
}
echo -e "Iniciando sistema...\n";
data=$(date +"%Y%m%d");
atoi $(date +"%H");
hora=$?;
paises[0]="us";
paises[1]="uk";
paises[2]="au";
paises[3]="jp";
paises[4]="cn";
paises[5]="nz";
paises[6]="de";
paises[7]="ca";
paises[8]="br";
pais=$(($RANDOM%$hora));
if [ $pais -ge 10 ] ; then
	pais=$(($pais%${#paises[*]}));
fi
pais=${paises[$pais]};
urld=~/bing_images/$data-$pais.jpg;
while :; do
	datanow=$(date +"%Y%m%d");
	atoi $(date +"%H");
	horanow=$?;
	if [ -e $urld ] ; then
		tam=$(du -sh $urld | cut  -f1);
		tam=${tam%%[!0-9]*};
		if [ "$tam" -eq 0 ] ; then
			echo -e "Apagando imagem vazia...\n";
			rm -rf $urld;
			sleep 5;
		fi
	fi
	if [ $datanow -gt $data -o $horanow -gt $hora ] || [ ! -e $urld ] ; then
		data=$datanow;
		hora=$horanow;
		data=$(date +"%Y%m%d");
		atoi $(date +"%H");
		hora=$?;
		pais=$(($RANDOM%$hora));
		if [ $pais -ge 10 ] ; then
			pais=$(($pais%${#paises[*]}));
		fi
		pais=${paises[$pais]};
		urld=~/bing_images/$data-$pais.jpg;
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
			echo -e "\n\n$url\n\n";
			echo -e "\n\nimg$img\n\n";
			wget $url -O $urld >/dev/null;
			cd $OLDPWD;
		fi
		echo -e "Removendo background...\n";
		gsettings set org.gnome.desktop.background picture-uri "";
		#gconftool --unset /desktop/gnome/background/picture_filename;
		echo -e "Setando background...\n";
		#gconftool --type string --set /desktop/gnome/background/picture_filename $urld;
		gsettings set org.gnome.desktop.background picture-uri "file://"$urld;
		#sleep $((60*15));
		sleep 1;
	fi
done
