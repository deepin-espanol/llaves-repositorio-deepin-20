#!/bin/bash

CARPETA_ACTUAL=$(pwd)

echo Desactivando todos los repositorios actuales

sudo sed -i -e 's/^[[:space:]]*//; s/^deb/#deb/g' /etc/apt/sources.list

cd /etc/apt/sources.list.d/; for REPO in $(ls); do sudo sed -i -e 's/^[[:space:]]*//; s/^deb/#deb/g' $REPO; done; cd $CARPETA_ACTUAL;



echo Agregando los repositorios de Deepin 20

echo -e "\n#Repositorio de Deepin 20 (procedimiento Deepin en Español)\ndeb [by-hash=force] https://community-packages.deepin.com/deepin/ apricot main contrib non-free" | sudo tee -a /etc/apt/sources.list 

echo -e "#Repositorio de tienda de aplicaciones para Deepin 20 (procedimiento Deepin en Español)\ndeb https://community-store-packages.deepin.com/appstore eagle appstore" | sudo tee /etc/apt/sources.list.d/appstore.list

echo -e "#Repositorio de impresoras para Deepin 20 (procedimiento Deepin en Español)\ndeb http://packages.chinauos.com/printer eagle non-free" | sudo tee /etc/apt/sources.list.d/printer.list

echo Respaldando las llaves de los repositorios de Deepin 15

mkdir ~/respaldo-llaves-repo-deepin-15
cp /etc/apt/trusted.gpg ~/respaldo-llaves-repo-deepin-15/
cp /etc/apt/trusted.gpg.d/deepin-pools-keyring.gpg ~/respaldo-llaves-repo-deepin-15/
cp /etc/apt/trusted.gpg.d/uos-archive-keyring.gpg ~/respaldo-llaves-repo-deepin-15/



echo Agregando llaves de los repositorios de Deepin 20

wget https://github.com/deepin-espanol/llaves-repositorio-deepin-20/raw/master/trusted.gpg

wget https://github.com/deepin-espanol/llaves-repositorio-deepin-20/raw/master/deepin-pools-keyring.gpg

wget https://github.com/deepin-espanol/llaves-repositorio-deepin-20/raw/master/uos-archive-keyring.gpg

sudo cp trusted.gpg /etc/apt/

sudo cp deepin-pools-keyring.gpg uos-archive-keyring.gpg /etc/apt/trusted.gpg.d/

rm trusted.gpg deepin-pools-keyring.gpg uos-archive-keyring.gpg




echo Cambiando a repositorio espejo de Deepin en Español

sudo sed -i "s|^deb \[by-hash=force\] https://community-packages.deepin.com/deepin/ apricot main contrib non-free|#deb \[by-hash=force\] https://community-packages.deepin.com/deepin/ apricot main contrib non-free\ndeb \[by-hash=force\] https://mirror.deepines.com/deepin/ apricot main contrib non-free|" /etc/apt/sources.list

sudo sed -i "s|^deb https://community-store-packages.deepin.com/appstore eagle appstore|#deb https://community-store-packages.deepin.com/appstore eagle appstore\ndeb https://mirror.deepines.com/testing/appstore eagle appstore\n|" /etc/apt/sources.list.d/appstore.list


echo Ejecute el siguiente comando para iniciar la actualización

echo "sudo apt update && sudo apt full-upgrade"
