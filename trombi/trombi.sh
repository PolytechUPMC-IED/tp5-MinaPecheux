#!/bin/bash
#
# [MAIN3 - EnvDev] / Oct. 2016, Mina Pêcheux
# Cours de C. Braunstein.
#
# Ce script automatise la récupération des photos pour le trombinoscope.


# décompressage de l'archive
tar xzvf photos.tgz

# récupération des fichiers jpeg
liste_fichiers=`ls | grep "jpg"`

# initialisation du fichier listant les filières
echo -n "" > filieres.txt

# parcours des fichiers jpeg pour la création des dossiers et la conversion des images
for fichier in $liste_fichiers;
do
	# récupération du nom du fichier sans l'extension
	filename="${fichier%.*}"
	# découpe des différents champs
	prenom=`cut -d "_" -f 1 <<< $filename`
	nom=`cut -d "_" -f 2 <<< $filename`
	spe=`cut -d "_" -f 3 <<< $filename`
	annee=`cut -d "_" -f 4 <<< $filename`

	# si le répertoire "spéannée" n'existe pas, on le crée
	mkdir -p "$spe$annee"

	# conversion et copie du fichier dans le répertoire
	convert -resize 90x120 $fichier $spe$annee/$nom.$prenom.jpg

	# si la filière n'a pas déjà été ajoutée à la liste
	if ! grep -q $spe$annee filieres.txt; then
		# alors on l'ajoute
	    echo $spe$annee >> filieres.txt
	fi
done

# parcours des dossiers pour la création des fichiers index.html
filieres=`cat filieres.txt`
for dossier in $filieres;
do
	# ajout du header
	contenu="<html><head><title>Trombinoscope $dossier</title></head>\n<body>\n<h1 align='center'>Trombinoscope $dossier</h1>"

	# début du tableau
	contenu="$contenu\n<table cols=2 align='center'>"
	# remplissage du tableau
	imgs=`ls $dossier | grep "jpg" | sort`

	# compteur de la colonne de la photo
	count="0"
	# parcours des photos dans le dossier
	for img in $imgs;
	do
		# récupération du nom et prénom de l'enseignant
		nom=`cut -d "." -f 1 <<< $img`
		prenom=`cut -d "." -f 2 <<< $img`
		# vérification du numéro de la colonne et ajout du code html correspondant
		if [ $count == "0" ]; then
			contenu="$contenu\n<tr>\n<td><img src="$img" width=90 height=120/><br/>$prenom $nom</td>"
			count="1"
		else
			contenu="$contenu\n<td><img src="$img" width=90 height=120/><br/>$prenom $nom</td>\n</tr>"
			count="0"
		fi
	done

	# fin du tableau
	contenu="$contenu\n</table>"

	# fin du fichier
	contenu="$contenu\n</body></html>"

	# (ré)initialisation du fichier index.html
	echo -n "" > $dossier/index.html
	# écriture du fichier
	echo -e $contenu > $dossier/index.html
done

# suppression des photos temporaires (fichiers exportés)
rm *.jpg
