*#!/bin/bash

#définition des variables
date=$(date +%d-%B-%Y)
nom_user=$(whoami)
chemin=$(pwd)
nom_dossier_1=$nom_user-fichier-moins-7-jours-$date
nom_dossier_2=$nom_user-fichier-modifier-plus-7-jours-$date
nom_dossier_3=$nom_user-repertoire-contenu-plus-10-mo_$date
nom_dossier_4=$nom_user-repertoire-et-fichier-cache-$date

#Choix pour les différentes options de sauvegarde.
echo "entrer une valeur:"
echo "1 = fichier créer il y a 7 jours"
echo "2 = fichier modifliés depuis plus de 7 jours"
echo "3 = Répertoires dont le contenu est > 10 mo"
echo "4 = Répertoire et fichiers cachés"

#permet de lire linput de l'utilisateur
read input

if [[ $input = 1 ]]
then
 mkdir $nom_dossier_1
 find /home/$nom_user -type f -ctime -7 -exec cp -r "{}" $chemin/$nom_dossier_1 \;
 tar -czvf $nom_dossier_1.tar.gz $nom_dossier_1
 rm -r $nom_dossier_1
 chmod 600 $nom_dossier_1.tar.gz
 sudo mv $nom_dossier_1.tar.gz /var/backup
fi

if [[ $input = 2 ]]
then
 mkdir $nom_dossier_2
 find /home/$nom_user -type f -mtime +7 -exec cp "{}" $chemin/$nom_dossier_2 \;
 tar -czvf $nom_dossier_2.tar.gz $nom_dossier_2
 rm -r $nom_dossier_2
 chmod 600 $nom_dossier_2.tar.gz
 sudo mv $nom_dossier_2.tar.gz /var/backup
fi

if [[ $input = 3 ]]
then
 mkdir $nom_dossier_3
 sudo find /home/$user_name -type d -size +10M -exec cp "{}" $chemin/$nome_dossier_3 \;
 tar -czvf $nom_dossier_3.tar.gz $nom_dossier_3
 rm -r $nom_dossier_3
 chmod 600 $nom_dossier_3.tar.gz
 sudo mv $nom_dossier_3.tar.gz /var/backup
fi

if [[ $input = 4 ]]
then
 mkdir $nom_dossier_4
 sudo find /home/$user_name -iname ".*" -exec cp -r "{}" $chemin/$nom_dossier_4 \;
 sudo tar -czvf $nom_dossier_4.tar.gz $nom_dossier_4
 sudo rm -rf $nom_dossier_4
 sudo chown $nom_user $nom_dossier_4.tar.gz
 chmod 600 $nom_dossier_4.tar.gz
 sudo mv $nom_dossier_4.tar.gz /var/backup
fi
