#!/bin/sh

FILEDATE=$1
FILETYPES=("Ks" "Bac" "Kta" "Ukc" "Kyi")

cat <<EOS

Filedate? (ex. 220319)
yymmdd の形式で入力してください。
EOS

read FILEDATE

for FILETYPE in "${FILETYPES[@]}"
do
sh ./converter.sh << EOS 
${FILETYPE}
${FILEDATE}
EOS
done
