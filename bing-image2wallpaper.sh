#!/bin/bash
#by leonardoweslei@gamil.com
atoi()
{
	x=${1%%[!0-9]*};
	return $x;
}
echo -e "Iniciando sistema...\n";
data=$(date +"%Y%m%d");
atoi $(date +"%H");
hora=$?;
#paises[0]="us";
#paises[1]="uk";
#paises[2]="au";
#paises[3]="jp";
#paises[4]="cn";
#paises[5]="nz";
#paises[6]="de";
#paises[7]="ca";
#
#paises[8]="us";
#paises[9]="uk";
#paises[10]="au";
#paises[11]="jp";
#paises[12]="cn";
#paises[13]="nz";
#paises[14]="de";
#paises[15]="ca";
#
#paises[16]="us";
#paises[17]="uk";
#paises[18]="au";
#paises[19]="jp";
#paises[20]="cn";
#paises[21]="nz";
#paises[22]="de";
#paises[23]="ca";
paises[0]="us";
paises[1]="us";
paises[2]="us";
paises[3]="us";
paises[4]="us";
paises[5]="us";
paises[6]="us";
paises[7]="us";

paises[8]="us";
paises[9]="us";
paises[10]="us";
paises[11]="us";
paises[12]="us";
paises[13]="us";
paises[14]="us";
paises[15]="us";

paises[16]="us";
paises[17]="us";
paises[18]="us";
paises[19]="us";
paises[20]="us";
paises[21]="us";
paises[22]="us";
paises[23]="us";

urld=~/bing_images/$data-${paises[$hora]}.jpg;
while :; do
	datanow=$(date +"%Y%m%d");
	atoi $(date +"%H");
	horanow=$?;
	tam=$(du -sh $urld | cut  -f1);
	tam=${tam%%[!0-9]*};
	if [ $tam -eq 0 ] ; then
		echo -e "Apagando imagem vazia...\n";
		rm -rf $urld;
	fi
	if [ $datanow -gt $data -o $horanow -gt $hora ] || [ ! -e $urld ] ; then
		data=$datanow;
		hora=$horanow;
		data=$(date +"%Y%m%d");
		atoi $(date +"%H");
		hora=$?;
		urld=~/bing_images/$data-${paises[$hora]}.jpg;
		if [ ! -e "$HOME/bing_images/" ] ; then
			echo -e "Criando diretorio de imagens...\n";
			mkdir ~/bing_images;
		fi
		if [ ! -e $urld ] ; then
			cd /tmp;
			rm .tmp.txt*;
			echo -e "Baixando imagem$data-${paises[$hora]}.jpg do bing...\n";
			wget www.istartedsomething.com/bingimages/getimage.php?id=$data-${paises[$hora]} -O .tmp.txt >/dev/null;
			img=$(cat .tmp.txt | awk -F"\"" '{print $4}' | awk -F"/" '{print $1}' );
			url="www.bing.com/fd/hpk2/$img";
			wget $url -O $urld >/dev/null;
			cd $OLDPWD;
		fi
		echo -e "Removendo background...\n";
		gconftool --unset /desktop/gnome/background/picture_filename;
		echo -e "Setando background...\n";
		gconftool --type string --set /desktop/gnome/background/picture_filename $urld;
	fi
	sleep $((60*15));
done
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
#paises[0]="us";
#paises[1]="uk";
#paises[2]="au";
#paises[3]="jp";
#paises[4]="cn";
#paises[5]="nz";
#paises[6]="de";
#paises[7]="ca";
#
#paises[8]="us";
#paises[9]="uk";
#paises[10]="au";
#paises[11]="jp";
#paises[12]="cn";
#paises[13]="nz";
#paises[14]="de";
#paises[15]="ca";
#
#paises[16]="us";
#paises[17]="uk";
#paises[18]="au";
#paises[19]="jp";
#paises[20]="cn";
#paises[21]="nz";
#paises[22]="de";
#paises[23]="ca";
paises[0]="us";
paises[1]="us";
paises[2]="us";
paises[3]="us";
paises[4]="us";
paises[5]="us";
paises[6]="us";
paises[7]="us";

paises[8]="us";
paises[9]="us";
paises[10]="us";
paises[11]="us";
paises[12]="us";
paises[13]="us";
paises[14]="us";
paises[15]="us";

paises[16]="us";
paises[17]="us";
paises[18]="us";
paises[19]="us";
paises[20]="us";
paises[21]="us";
paises[22]="us";
paises[23]="us";

urld=~/bing_images/$data-${paises[$hora]}.jpg;
while :; do
	datanow=$(date +"%Y%m%d");
	atoi $(date +"%H");
	horanow=$?;
	tam=$(du -sh $urld | cut  -f1);
	tam=${tam%%[!0-9]*};
	if [ $tam -eq 0 ] ; then
		echo -e "Apagando imagem vazia...\n";
		rm -rf $urld;
		sleep 5;
	fi
	if [ $datanow -gt $data -o $horanow -gt $hora ] || [ ! -e $urld ] ; then
		data=$datanow;
		hora=$horanow;
		data=$(date +"%Y%m%d");
		atoi $(date +"%H");
		hora=$?;
		urld=~/bing_images/$data-${paises[$hora]}.jpg;
		if [ ! -e "$HOME/bing_images/" ] ; then
			echo -e "Criando diretorio de imagens...\n";
			mkdir ~/bing_images;
		fi
		if [ ! -e $urld ] ; then
			cd /tmp;
			rm .tmp.txt*;
			echo -e "Baixando imagem$data-${paises[$hora]}.jpg do bing...\n";
			wget www.istartedsomething.com/bingimages/getimage.php?id=$data-${paises[$hora]} -O .tmp.txt >/dev/null;
			img=$(cat .tmp.txt | awk -F"\"" '{print $4}' | awk -F"/" '{print $1}' );
			url="www.bing.com/fd/hpk2/$img";
			wget $url -O $urld >/dev/null;
			cd $OLDPWD;
		fi
		echo -e "Removendo background...\n";
		gsettings set org.gnome.desktop.background picture-uri "";
		#gconftool --unset /desktop/gnome/background/picture_filename;
		echo -e "Setando background...\n";
		#gconftool --type string --set /desktop/gnome/background/picture_filename $urld;
		gsettings set org.gnome.desktop.background picture-uri "file://"$urld;
		sleep $((60*15));
	fi
done
