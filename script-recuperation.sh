#!/bin/bash

#fonction permet d enlever les - pour manipuler les dates
date_test() {
        local date="$1" #premiere date rentrer
        IFS="-" #delimiteur
        read -a date_tableau <<< "$date" #read la variable initialiser precedement
        for date_delimite in "${date_tableau[@]}"; do #boucle qui echo chaque partit de la date 
                echo "$date_delimite"
        done
}

#boucle qui permt de lire l echo de  la fonction precedante pour la ranger dans une nouvelle variale
while read -r ligne; do
	date_1+=$ligne
done <<< $(date_test "$1")

#pareil que precedement mais pour la deuxieme date
while read -r ligne; do
	date_2+=$ligne
done <<< $(date_test "$2")

# manipulation string pour trouver quelle partie du str pour la suite
# ${date_1:0:2} =jour
# ${date_1:2:2} =moi
# ${date_1:4:4} =annee

#format de la  date qui doit etre utiliser pour la commande last
# ${date_1:4:4}/${date_1:2:2}/${date_1:0:2} = date depart
# ${date_2:4:4}/${date_2:2:2}/${date_2:0:2} = date arrive

#on définit une variable pour le nom du dossier
nom_dossier=recuperation-${date_1:0:2}-$(date +"%b-%Y")

#creation d'un dossier pour stoker les infos
mkdir $nom_dossier

#prendre la liste des logs et les entrer dans un fichier 
last -R -s ${date_1:4:4}-${date_1:2:2}-${date_1:0:2} -t ${date_2:4:4}-${date_2:2:2}-${date_2:0:2} | grep -v -E "(^reboot)" >> $nom_dossier/nom-des-users

# ecrire le nombre de log dans un fichier en lisant le nombre de ligne du fichier precedent en enlevant la
echo nombre de login entre $1 $2 est de $(grep -v -E "(^$|^wtmp)" $nom_dossier/nom-des-users | wc -l) connexion >> $nom_dossier/nombre-de-log

#on compresse le fichier precedent pour ensuite l'envoyer /var/backup
tar -czvf $nom_dossier.tar.gz $nom_dossier

#on peut remove le dossier de stockage precedent
rm -r $nom_dossier

sudo mv $nom_dossier.tar.gz /var/backup
