#!/bin/sh
LDIR="/ua13app/lifeua/ecom/scripts/out/sb_transf/"
ARCHDIR="/ua13app/lifeua/ecom/scripts/saves/sb_transf/"
MASK="sb_transf*"
LOGFILE="/ua13app/lifeua/ecom/scripts/log/sb_transf.log"
echo "Start" >> $LOGFILE
date >> $LOGFILE
echo "Start sending" >> $LOGFILE
date >> $LOGFILE
SUBJECT="Selfbill daily transfer"
EMAIL=""
ls ${LDIR}${MASK} >> $LOGFILE
echo "Please find the report attached"|mailx -s "$SUBJECT" -a $1 $EMAIL
mv -f ${LDIR}${MASK} ${ARCHDIR}
echo "End sending" >> $LOGFILE
echo "End" >> $LOGFILE
echo "End"
