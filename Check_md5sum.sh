#!/bin/bash

# Spécifiez le chemin du répertoire contenant les fichiers fastq.gz et .md5sum correspondants
repertoire="/PATH/TO/REPO"

# Accédez au répertoire
cd "$repertoire"

# Boucle à travers les fichiers fastq.gz
for fichier in *.fastq.gz; do
    # Vérifiez si un fichier md5sum correspondant existe
    fichier_md5sum="$fichier.md5sum"
    if [ -e "$fichier_md5sum" ]; then
        # Calculez le md5sum du fichier
        md5_fichier=$(md5sum "$fichier" | awk '{print $1}')
        # Lisez le md5sum du fichier md5sum correspondant
        md5_attendu=$(cat "$fichier_md5sum" | awk '{print $1}')
        # Comparez les md5sum
        if [ "$md5_fichier" = "$md5_attendu" ]; then
            echo "Le fichier $fichier est intègre."
        else
            echo "Le fichier $fichier est corrompu."
        fi
    else
        echo "Aucun fichier md5sum correspondant trouvé pour $fichier."
    fi
done
