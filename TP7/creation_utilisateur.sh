#! /bin/bash
# script creation_utilisateur.sh
# Creation d'un nouvel utilisateur avec mise a jour des trois fichiers 
# concernes.
# Si la creation du nouvel utilisateur n'est pas possible un message
# d'erreur est affiche.
# Necessite trois parametres qui correspondent respectivement au login, 
# au mot de passe et au nom du nouvel utilisateur.

if [ "$#" -ne 3 ]; then
  echo "Vous devez saisir trois parametres"
  exit 1
fi
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "Vous devez saisir un login, un mot de passe et un nom non vide"
  exit 1
fi

lockfile -1 login.txt.verrou

if [ -f login.txt ] && [ ! -z "$(grep "^$1$" login.txt)" ]
then
  echo "Choisissez un login different de $1"
  exit 1
fi

echo "$1" >> login.txt

lockfile -1 pass.txt.verrou
rm -f login.txt.verrou
echo "$2" >> pass.txt

lockfile -1 nom.txt.verrou 
rm -f pass.txt.verrou
echo "$3" >> nom.txt
rm -f nom.txt.verrou

