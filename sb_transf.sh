#!/bin/bash
echo "File is being generated do not stop this script!"
cd /ua13app/lifeua/ecom/scripts/sb_transf/

path_src=/ua13app/lifeua/ecom/scripts/sb_transf
path_out=/ua13app/lifeua/ecom/scripts/out/sb_transf
path_sav=/ua13app/lifeua/ecom/scripts/saves/sb_transf
file_log=/ua13app/lifeua/ecom/scripts/log/sb_transf.log

#kto=`whoami`
#if [ "${kto}" != "%username%" ]; then
#echo "skrypt odpalil ${kto}" >> ${file_log}
#echo "Invalid user to run this script!!! You must be logged as %username%"
#exit
#else
#echo "${kto}" >> ${file_log}
#fi

. /ua13app/lifeua/.unims

file_name_out=sb_transf
file_name=sb_transf_`date +'%d%m%Y%H%M'`

czas=`date +'%H%M%S'`

echo "`date` ************START************" >> ${file_log}
echo `id` >> ${file_log}

echo "file ${file_log} start created at `date`" >> ${file_log}

usu %username% sb_transf_sql.sh >> ${path_out}/${file_name}.txt

echo "file ${file_name} end creation at `date`" >> ${file_log}
sleep 60
echo "`date` file is generated" >> ${file_log}
echo "file generated"

iconv -f utf8 -t cp1251 ${path_out}/${file_name}.txt > ${path_out}/${file_name}.csv

iconv -f utf8 -t cp1251 ${path_out}/${file_name}.txt > ${path_out}/${file_name_out}.csv
sleep 5
echo "`date` file is converted" >> ${file_log}
echo "file converted"

php ${path_src}/send.php #"${path_out}/${file_name}.csv" > /dev/null >> ${file_log}
echo "`date` mail script has been accompished" >> ${file_log}
echo "mail script has been accompished" 

mv -f ${path_out}/${file_name}.csv ${path_sav}
rm ${path_out}/${file_name_out}.csv
rm ${path_out}/${file_name}.txt

echo "mail sent"

echo "`date` ************STOP************" >> ${file_log}
echo "done"
