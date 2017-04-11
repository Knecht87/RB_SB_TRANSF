usql -h -n -t\; -e "

/*!pass-through*/

select
a9.\"paydepot\" as \"paydepot\"
,a9.\"prodaccount\" as \"prodaccount\"
,sum(nvl(a9.\"costs on prod\",0)) as \"costs\"
,a9.\"selfbill\" as \"selfbill\"
,a9.\"name\" as \"name\"
,relati.\"naam1\"||relati.\"naam2\" as \"name2\"
,a9.\"status\" as \"status\"
,relati.\"relnr\" as \"rel number\"
,a9.\"INVOICE_NR\" as \"INVOICE_NR\"
,a9.\"DATE_INVOICE\" as \"DATE_INVOICE\"
,\"BLOCK_STAT\"
/*31.01.17 pozo: added new function SBLASTROD*/
,vitaliy.\"SBLASTROD\"(a9.\"selfbill\") as \"ROD_DATE\",
\"TAR_DATE\"
from
(select
a8.\"trip stop date\" as \"trip stop date\"
,a8.\"trip owner\"
,a8.\"trip\" as \"trip\"
,a8.\"shipments total\"
,sum(a8.\"shipments on prod\") as \"shipments on prod\"
,a8.\"shipment owner\"
,sum(a8.\"internal sales\") as \"internal sales\"
,a8.\"paydepot\"
,a8.\"prodaccount\"
,case
when a8.\"prodaccount\" = '8031'
then 'K6'
when a8.\"prodaccount\" = '8071'
then 'K9'
when a8.\"prodaccount\" = '8011'
then 'K1'
when a8.\"prodaccount\" = '8015'
then 'K2'
when a8.\"prodaccount\" = '8051'
then 'K5'
when a8.\"prodaccount\" = '8055'
then 'K9'
else 'UNKNOWN'
end as \"Koeficient\"
,a8.\"trip type\"
,a8.\"tariff\" as \"tariff\"
,a8.\"distance\"
,a8.\"from\" as \"from\"
,a8.\"to\" as \"to\"
,a8.\"total costs\"
,sum(a8.\"costs on prod\") as \"costs on prod\"
,sum(a8.\"pp\") as \"pp\"
,sum(a8.\"BrutWeight\") as \"BrutWeight\"
,sum(a8.\"VolWeight\") as \"VolWeight\"
,a8.\"selfbill\"
,a8.\"status\"
,a8.\"name\"
,a8.\"truck\"
,a8.\"trailer\"
,a8.\"load indx\"
,a8.\"load weig\"
,a8.\"sb owner\"
,a8.\"specvz\"
,a8.\"INVOICE_NR\" as \"INVOICE_NR\"
,a8.\"DATE_INVOICE\" as \"DATE_INVOICE\"
,\"BLOCK_STAT\"
,\"ROD_DATE\",\"TAR_DATE\"
from
(select
a7.\"trip stop date\" as \"trip stop date\"
,a7.\"trip owner\"
,a7.\"trip\" as \"trip\"
,a7.\"shipments total\"
,sum(a7.\"shipments on prod\") as \"shipments on prod\"
,a7.\"shipment owner\"
,sum(a7.\"internal sales\") as \"internal sales\"
,a7.\"paydepot\"
,case
when a7.\"paydepot\" = '17401'
and a7.\"prodaccount\" = '8055'
and substr(a7.\"from\",2,2) = '01'
and substr(a7.\"to\",2,2) in ('09','14','21','22','40')
then '8051'
when a7.\"paydepot\" = '17428'
and a7.\"prodaccount\" = '8055'
and substr(a7.\"from\",2,2) = '28'
and substr(a7.\"to\",2,2) in ('56','46')
then '8051'
when a7.\"paydepot\" = '17449'
and a7.\"prodaccount\" = '8055'
and substr(a7.\"from\",2,2) = '49'
and substr(a7.\"to\",2,2) in ('34','50','25')
then '8051'
when a7.\"paydepot\" = '17479'
and a7.\"prodaccount\" = '8055'
and substr(a7.\"from\",2,2) = '79'
and substr(a7.\"to\",2,2) in ('33','76','43','88')
then '8051'
when a7.\"paydepot\" = '17465'
and a7.\"prodaccount\" = '8055'
and substr(a7.\"from\",2,2) = '65'
and substr(a7.\"to\",2,2) in ('73','99')
then '8051'
when a7.\"paydepot\" = '17461'
and a7.\"prodaccount\" = '8055'
and substr(a7.\"from\",2,2) = '61'
and substr(a7.\"to\",2,2) in ('36')
then '8051'
when a7.\"paydepot\" = '17483'
and a7.\"prodaccount\" = '8055'
and substr(a7.\"from\",2,2) = '83'
and substr(a7.\"to\",2,2) in ('71','84','91')
then '8051'
when a7.\"paydepot\" = '17401'
and a7.\"prodaccount\" = '8015'
and substr(a7.\"from\",2,2) = '01'
and substr(a7.\"to\",2,2) in ('09','14','21','22','40')
then '8011'
when a7.\"paydepot\" = '17428'
and a7.\"prodaccount\" = '8015'
and substr(a7.\"from\",2,2) = '28'
and substr(a7.\"to\",2,2) in ('56','46')
then '8011'
when a7.\"paydepot\" = '17479'
and a7.\"prodaccount\" = '8015'
and substr(a7.\"from\",2,2) = '79'
and substr(a7.\"to\",2,2) in ('33','76','43','88')
then '8011'
when a7.\"paydepot\" = '17465'
and a7.\"prodaccount\" = '8015'
and substr(a7.\"from\",2,2) = '65'
and substr(a7.\"to\",2,2) in ('73','99')
then '8011'
when a7.\"paydepot\" = '17461'
and a7.\"prodaccount\" = '8015'
and substr(a7.\"from\",2,2) = '61'
and substr(a7.\"to\",2,2) in ('36')
then '8011'
when a7.\"paydepot\" = '17483'
and a7.\"prodaccount\" = '8015'
and substr(a7.\"from\",2,2) = '83'
and substr(a7.\"to\",2,2) in ('71','84','91')
then '8011'
when a7.\"paydepot\" = '17449'
and a7.\"prodaccount\" = '8015'
and substr(a7.\"from\",2,2) = '49'
and substr(a7.\"to\",2,2) in ('34','50','25')
then '8011'
else a7.\"prodaccount\"
end as \"prodaccount\"
,a7.\"koeficient\" as \"koeficient\"
,a7.\"trip type\"
,a7.\"tariff\" as \"tariff\"
,a7.\"distance\"
,a7.\"from\" as \"from\"
,a7.\"to\" as \"to\"
,a7.\"total costs\"
,sum(a7.\"costs on prod\") as \"costs on prod\"
,sum(a7.\"pp\") as \"pp\"
,sum(a7.\"BrutWeight\") as \"BrutWeight\"
,sum(a7.\"VolWeight\") as \"VolWeight\"
,a7.\"selfbill\"
,a7.\"status\"
,a7.\"name\"
,a7.\"truck\"
,a7.\"trailer\"
,a7.\"load indx\"
,a7.\"load weig\"
,a7.\"sb owner\"
,a7.\"specvz\"
,a7.\"INVOICE_NR\" as \"INVOICE_NR\"
,a7.\"DATE_INVOICE\" as \"DATE_INVOICE\"
,\"BLOCK_STAT\"
,\"ROD_DATE\",\"TAR_DATE\"
from
(select
a6.\"trip stop date\" as \"trip stop date\"
,a6.\"trip owner\"
,a6.\"trip\" as \"trip\"
,a6.\"shipments total\"
,sum(a6.\"shipments on prod\") as \"shipments on prod\"
,a6.\"shipment owner\"
,sum(a6.\"internal sales\") as \"internal sales\"
,case
when (a6.\"shipments total\" = 0
and substr(a6.\"paydepot\",4,2) in ('49','01')
and substr(a6.\"trip\",6,1) = 6)
then (case
when a6.\"tsserl\" = 'MGL'
then '175'
else '177'
end)||
case
when a6.\"tsserl\" = 'MGL'
and substr(a6.\"paydepot\",4,2) = '01'
then '02'
when a6.\"tsserl\" = 'MGL'
and substr(a6.\"paydepot\",4,2) = '49'
then '48'
else
substr(a6.\"paydepot\",4,2)
end
when (a6.\"shipments total\" = 0
and substr(a6.\"paydepot\",4,2) in ('49','01')
and substr(a6.\"trip\",6,1) = 3)
then (case
when a6.\"tsserl\" = 'MGL'
then '173'
else '174'
end)||
case
when a6.\"tsserl\" = 'MGL'
and substr(a6.\"paydepot\",4,2) = '01'
then '02'
when a6.\"tsserl\" = 'MGL'
and substr(a6.\"paydepot\",4,2) = '49'
then '48'
else
substr(a6.\"paydepot\",4,2)
end
else a6.\"paydepot\"
end as \"paydepot\"
,a6.\"prodaccount\" as \"prodaccount\"
,a6.\"koeficient\" as \"koeficient\"
,a6.\"trip type\"
,a6.\"tariff\" as \"tariff\"
,a6.\"distance\"
,a6.\"from\" as \"from\"
,a6.\"to\" as \"to\"
,a6.\"total costs\"
,sum(a6.\"costs on prod\") as \"costs on prod\"
,sum(a6.\"pp\") as \"pp\"
,sum(a6.\"BrutWeight\") as \"BrutWeight\"
,sum(a6.\"VolWeight\") as \"VolWeight\"
,a6.\"selfbill\"
,a6.\"status\"
,a6.\"name\"
,a6.\"truck\"
,a6.\"trailer\"
,a6.\"load indx\"
,a6.\"load weig\"
,a6.\"sb owner\"
,a6.\"specvz\"
,a6.\"tsserl\"
,a6.\"INVOICE_NR\" as \"INVOICE_NR\"
,a6.\"DATE_INVOICE\" as \"DATE_INVOICE\"
,\"BLOCK_STAT\"
,\"ROD_DATE\",\"TAR_DATE\"
from
(
select
a5.\"trip stop date\" as \"trip stop date\"
,a5.\"trip owner\"
,a5.\"trip\" as \"trip\"
,to_char(a5.\"shipcount\") as \"shipments total\"
,to_char(z2.\"ship\") as \"shipments on prod\"
,a5.\"shipm\" as \"shipment owner\"
,sum(a5.\"intinc\") as \"internal sales\"
,a5.\"paydepot\" as \"paydepot\"
,a5.\"prodaccount\" as \"prodaccount\"
,a5.\"Koeficient\" as \"koeficient\"
,a5.\"type\" as \"trip type\"
,a5.\"tariff\" as \"tariff\"
,a5.\"dist\" as \"distance\"
,a5.\"from\" as \"from\"
,a5.\"to\" as \"to\"
,to_char(a5.\"coststotal\") as \"total costs\"
,sum(a5.\"costs\") as \"costs on prod\"
,sum(a5.\"pp\") as \"pp\"
,sum(a5.\"BrutWeight\") as \"BrutWeight\"
,sum(a5.\"VolWeight\") as \"VolWeight\"
,a5.\"selfbill\" as \"selfbill\"
,a5.\"status\" as \"status\"
,a5.\"name\" as \"name\"
,a5.\"truck\" as \"truck\"
,a5.\"trailer\" as \"trailer\"
,a5.\"load indx\" as \"load indx\"
,a5.\"load weig\" as \"load weig\"
,a5.\"sb owner\" as \"sb owner\"
,a5.\"specvz\" as \"specvz\"
,a5.\"tsserl\" as \"tsserl\"
,a5.\"INVOICE_NR\" as \"INVOICE_NR\"
,a5.\"DATE_INVOICE\" as \"DATE_INVOICE\"
,\"BLOCK_STAT\"
,\"ROD_DATE\",\"TAR_DATE\"
from
(select
a4.\"period\" as \"trip stop date\"
,substr(a4.\"trip\",4,2) as \"trip owner\"
,a4.\"trip\" as \"trip\"
,a4.\"shipcount\" as \"shipcount\"
,a4.\"shipm\" as \"shipm\"
,a4.\"intinc\" as \"intinc\"
,a4.\"paydepot\" as \"paydepot\"
,a4.\"prodaccount\" as \"prodaccount\"
,case
when a4.\"prodaccount\" = '8031'
then 'K6'
when a4.\"prodaccount\" = '8071'
then 'K9'
when a4.\"prodaccount\" = '8011'
then 'K1'
when a4.\"prodaccount\" = '8015'
then 'K2'
when a4.\"prodaccount\" = '8051'
then 'K5'
when a4.\"prodaccount\" = '8055'
then 'K9'
else 'UNKNOWN'
end as \"Koeficient\"
,a4.\"type\" as \"type\"
,a4.\"tariff\" as \"tariff\"
,a4.\"dist\" as \"dist\"
,a4.\"from\" as \"from\"
,a4.\"to\" as \"to\"
,round(a4.\"coststotal\",2) as \"coststotal\"
,round(a4.\"costs\",2) as \"costs\"
,a4.\"pp\" as \"pp\"
,a4.\"BrutWeight\" as \"BrutWeight\"
,a4.\"VolWeight\" as \"VolWeight\"
,a4.\"selfbill\" as \"selfbill\"
,a4.\"status\" as \"status\"
,a4.\"name\" as \"name\"
,a4.\"truck\" as \"truck\"
,a4.\"trailer\" as \"trailer\"
,a4.\"load indx\" as \"load indx\"
,a4.\"load weig\" as \"load weig\"
,a4.\"sb owner\" as \"sb owner\"
,a4.\"specvz\" as \"specvz\"
,a4.\"tsserl\" as \"tsserl\"
,a4.\"INVOICE_NR\" as \"INVOICE_NR\"
,a4.\"DATE_INVOICE\" as \"DATE_INVOICE\"
,\"BLOCK_STAT\"
,\"ROD_DATE\",\"TAR_DATE\"
from
(select
a3.\"period\" as \"period\"
,a3.\"trip\" as \"trip\"
,a3.\"shipcount\" as \"shipcount\"
,a3.\"shipm\" as \"shipm\"
,a3.\"intinc\" as \"intinc\"
,a3.\"paydepot\" as \"paydepot\"
,case
when a3.\"paydepot\" = '17401'
and a3.\"prodaccount\" = '8055'
and substr(a3.\"from\",2,2) = '01'
and substr(a3.\"to\",2,2) in ('09','14','21','22','40')
then '8051'
when a3.\"paydepot\" = '17428'
and a3.\"prodaccount\" = '8055'
and substr(a3.\"from\",2,2) = '28'
and substr(a3.\"to\",2,2) in ('56','46')
then '8051'
when a3.\"paydepot\" = '17449'
and a3.\"prodaccount\" = '8055'
and substr(a3.\"from\",2,2) = '49'
and substr(a3.\"to\",2,2) in ('34','50','25')
then '8051'
when a3.\"paydepot\" = '17479'
and a3.\"prodaccount\" = '8055'
and substr(a3.\"from\",2,2) = '79'
and substr(a3.\"to\",2,2) in ('33','76','43','88')
then '8051'
when a3.\"paydepot\" = '17465'
and a3.\"prodaccount\" = '8055'
and substr(a3.\"from\",2,2) = '65'
and substr(a3.\"to\",2,2) in ('73','99')
then '8051'
when a3.\"paydepot\" = '17461'
and a3.\"prodaccount\" = '8055'
and substr(a3.\"from\",2,2) = '61'
and substr(a3.\"to\",2,2) in ('36')
then '8051'
when a3.\"paydepot\" = '17483'
and a3.\"prodaccount\" = '8055'
and substr(a3.\"from\",2,2) = '83'
and substr(a3.\"to\",2,2) in ('71','84','91')
then '8051'
when a3.\"paydepot\" = '17401'
and a3.\"prodaccount\" = '8015'
and substr(a3.\"from\",2,2) = '01'
and substr(a3.\"to\",2,2) in ('09','14','21','22','40')
then '8011'
when a3.\"paydepot\" = '17428'
and a3.\"prodaccount\" = '8015'
and substr(a3.\"from\",2,2) = '28'
and substr(a3.\"to\",2,2) in ('56','46')
then '8011'
when a3.\"paydepot\" = '17479'
and a3.\"prodaccount\" = '8015'
and substr(a3.\"from\",2,2) = '79'
and substr(a3.\"to\",2,2) in ('33','76','43','88')
then '8011'
when a3.\"paydepot\" = '17465'
and a3.\"prodaccount\" = '8015'
and substr(a3.\"from\",2,2) = '65'
and substr(a3.\"to\",2,2) in ('73','99')
then '8011'
when a3.\"paydepot\" = '17461'
and a3.\"prodaccount\" = '8015'
and substr(a3.\"from\",2,2) = '61'
and substr(a3.\"to\",2,2) in ('36')
then '8011'
when a3.\"paydepot\" = '17483'
and a3.\"prodaccount\" = '8015'
and substr(a3.\"from\",2,2) = '83'
and substr(a3.\"to\",2,2) in ('71','84','91')
then '8011'
when a3.\"paydepot\" = '17449'
and a3.\"prodaccount\" = '8015'
and substr(a3.\"from\",2,2) = '49'
and substr(a3.\"to\",2,2) in ('34','50','25')
then '8011'
else a3.\"prodaccount\"
end as \"prodaccount\"
,a3.\"type\" as \"type\"
,a3.\"tariff\" as \"tariff\"
,a3.\"dist\" as \"dist\"
,a3.\"from\" as \"from\"
,a3.\"to\" as \"to\"
,a3.\"coststotal\" as \"coststotal\"
,a3.\"costs\" as \"costs\"
,a3.\"pp\" as \"pp\"
,a3.\"BrutWeight\" as \"BrutWeight\"
,a3.\"VolWeight\" as \"VolWeight\"
,a3.\"selfbill\" as \"selfbill\"
,a3.\"status\" as \"status\"
,a3.\"name\" as \"name\"
,a3.\"truck\" as \"truck\"
,a3.\"trailer\" as \"trailer\"
,a3.\"load indx\" as \"load indx\"
,a3.\"load weig\" as \"load weig\"
,a3.\"sb owner\" as \"sb owner\"
,a3.\"specvz\" as \"specvz\"
,a3.\"tsserl\" as \"tsserl\"
,a3.\"INVOICE_NR\" as \"INVOICE_NR\"
,a3.\"DATE_INVOICE\" as \"DATE_INVOICE\"
,\"BLOCK_STAT\"
,\"ROD_DATE\",\"TAR_DATE\"
from
(select
a2.\"period\" as \"period\"
,a2.\"trip\" as \"trip\"
,a2.\"shipcount\" as \"shipcount\"
,a2.\"shipm\" as \"shipm\"
,a2.\"intinc\" as \"intinc\"
,a2.\"tariff\" as \"tariff\"
,a2.\"dist\" as \"dist\"
,case
when substr(a2.\"trip\",6,1) = 3
then
(case
when a2.\"shipproduct\" = 'MET'
and substr(a2.\"trip\",4,2) in
('01','09','14','21','22','40','49','25','34','50')
and a2.\"specvz\" like 'RABEN%'
then '175'
when a2.\"shipproduct\" = 'CH'
and substr(a2.\"trip\",4,2) in
('01','09','14','21','22','40','49','25','34','50')
and a2.\"specvz\" like 'RABEN%'
then '173'
when a2.\"shipproduct\" = 'MET'
and substr(a2.\"trip\",4,2) in
('01','09','14','21','22','40','49','25','34','50')
and (a2.\"specvz\" not like 'RABEN%'
or a2.\"specvz\" is null)
then '173'
when a2.\"shipproduct\" = 'CH'
and substr(a2.\"trip\",4,2) in
('01','09','14','21','22','40','49','25','34','50')
and (a2.\"specvz\" not like 'RABEN%'
or a2.\"specvz\" is null)
then '173'
when a2.\"shipproduct\" = 'FR'
and a2.\"specvz\" like 'RABEN%'
then '174'
when a2.\"shipproduct\" = 'DD'
and a2.\"specvz\" like 'RABEN%'
then '177'
when a2.\"shipproduct\" = 'FR'
and (a2.\"specvz\" not like 'RABEN%'
or a2.\"specvz\" is null)
then '174'
when a2.\"shipproduct\" = 'DD'
and (a2.\"specvz\" not like 'RABEN%'
or a2.\"specvz\" is null)
then '174'
else (case
when a2.\"tsserl\" = 'MGL'
then '173'
else '174'
end)
end)
when substr(a2.\"trip\",6,1) = 6
then
(case
when a2.\"shipproduct\" = 'MET'
and substr(a2.\"trip\",4,2) in
('01','09','14','21','22','40','49','25','34','50')
and a2.\"specvz\" like 'RABEN%'
then '175'
when a2.\"shipproduct\" = 'CH'
and substr(a2.\"trip\",4,2) in
('01','09','14','21','22','40','49','25','34','50')
and a2.\"specvz\" like 'RABEN%'
then '173'
when a2.\"shipproduct\" = 'MET'
and substr(a2.\"trip\",4,2) in
('01','09','14','21','22','40','49','25','34','50')
and (a2.\"specvz\" not like 'RABEN%'
or a2.\"specvz\" is null)
then '175'
when a2.\"shipproduct\" = 'CH'
and substr(a2.\"trip\",4,2) in
('01','09','14','21','22','40','49','25','34','50')
and (a2.\"specvz\" not like 'RABEN%'
or a2.\"specvz\" is null)
then '175'
when a2.\"shipproduct\" = 'FR'
and a2.\"specvz\" like 'RABEN%'
then '174'
when a2.\"shipproduct\" = 'DD'
and a2.\"specvz\" like 'RABEN%'
then '177'
when a2.\"shipproduct\" = 'FR'
and (a2.\"specvz\" not like 'RABEN%'
or a2.\"specvz\" is null)
then '177'
when a2.\"shipproduct\" = 'DD'
and (a2.\"specvz\" not like 'RABEN%'
or a2.\"specvz\" is null)
then '177'
else (case
when a2.\"tsserl\" = 'MGL'
then '175'
else '177'
end)
end)
else 'UNKNOWN'
end
||case
when substr(a2.\"trip\",4,2) in ('01','09','14','21','22','40')
then
(case
when a2.\"shipproduct\" = 'MET'
then '02'
when a2.\"shipproduct\" = 'CH'
then '02'
else '01'
end)
when substr(a2.\"trip\",4,2) in ('28','56','46')
then '28'
when substr(a2.\"trip\",4,2) in ('79','33','76','43','88')
then '79'
when substr(a2.\"trip\",4,2) in ('65','55','73','95','99')
then '65'
when substr(a2.\"trip\",4,2) in ('49','25','34','50')
then
(case
when a2.\"shipproduct\" = 'MET'
then '48'
when a2.\"shipproduct\" = 'CH'
then '48'
else '49'
end)
when substr(a2.\"trip\",4,2) in ('61','36')
then '61'
when substr(a2.\"trip\",4,2) in ('83','71','84','91')
then '83'
when substr(a2.\"trip\",4,2) in ('69')
then '69'
else 'UNKNOWN'
end as \"paydepot\"
,case
when substr(a2.\"from\",2,2) = substr(a2.\"to\",2,2)
and a2.\"pp\" is null
then '8051'
when substr(a2.\"from\",2,2) <> substr(a2.\"to\",2,2)
and a2.\"pp\" is null
then '8055'
when substr(a2.\"from\",1,1) = 'D'
and substr(a2.\"to\",1,1) = 'D'
and a2.\"pp\" is not null
then '8031'
when substr(a2.\"from\",1,1) = 'D'
and substr(a2.\"to\",1,1) = 'Z'
and a2.\"pp\" is not null
and substr(a2.\"from\",2,2) = substr(a2.\"to\",2,2)
then '8051'
when substr(a2.\"from\",1,1) = 'Z'
and substr(a2.\"to\",1,1) = 'D'
and a2.\"pp\" is not null
and substr(a2.\"from\",2,2) = substr(a2.\"to\",2,2)
then '8011'
when substr(a2.\"from\",1,1) = 'D'
and substr(a2.\"to\",1,1) = 'Z'
and a2.\"pp\" is not null
and substr(a2.\"from\",2,2) <> substr(a2.\"to\",2,2)
then '8055'
when substr(a2.\"from\",1,1) = 'Z'
and substr(a2.\"to\",1,1) = 'D'
and a2.\"pp\" is not null
and substr(a2.\"from\",2,2) <> substr(a2.\"to\",2,2)
then '8015'
when substr(a2.\"from\",1,1) = 'Z'
and substr(a2.\"to\",1,1) = 'Z'
and a2.\"pp\" is not null
then '8071'
else 'UNKNOWN'
end as \"prodaccount\"
,a2.\"type\" as \"type\"
,a2.\"from\" as \"from\"
,a2.\"to\" as \"to\"
,a2.\"coststotal\" as \"coststotal\"
,a2.\"costs\" as \"costs\"
,a2.\"pp\" as \"pp\"
,a2.\"BrutWeight\" as \"BrutWeight\"
,a2.\"VolWeight\" as \"VolWeight\"
,a2.\"selfbill\" as \"selfbill\"
,a2.\"status\" as \"status\"
,a2.\"name\" as \"name\"
,a2.\"truck\" as \"truck\"
,a2.\"trailer\" as \"trailer\"
,a2.\"load indx\" as \"load indx\"
,a2.\"load weig\" as \"load weig\"
,a2.\"sb owner\" as \"sb owner\"
,a2.\"specvz\" as \"specvz\"
,a2.\"tsserl\" as \"tsserl\"
,a2.\"INVOICE_NR\" as \"INVOICE_NR\"
,a2.\"DATE_INVOICE\" as \"DATE_INVOICE\"
,\"BLOCK_STAT\"
,\"ROD_DATE\",\"TAR_DATE\"
from
(select
a1.\"period\" as \"period\"
,a1.\"trip\" as \"trip\"
,\"tsdsmd1\".\"shipcount\" as \"shipcount\"
,a1.\"intinc\" as \"intinc\"
,case
when a1.\"tripown\" = a1.\"shipown\"
then a1.\"tripown\"
else '<>'||a1.\"tripown\"
end as \"shipm\"
,a1.\"shipproduct\"
,a1.\"type\" as \"type\"
,\"tsdsmd1\".\"tarsrt\" as \"tariff\"
,\"tsdsmd1\".\"tsdist\" as \"dist\"
,\"tsdsmd1\".\"tsserl\" as \"tsserl\"
,a1.\"from\" as \"from\"
,a1.\"to\" as \"to\"
,a1.\"costs\" as \"coststotal\"
,\"tsdsmd1\".\"tsloai\" as \"pptotal\"
,case when \"tsdsmd1\".\"tsloai\" = 0
then a1.\"costs\"
when \"tsdsmd1\".\"tsloai\" is null
then a1.\"costs\"
else a1.\"costs\"/\"tsdsmd1\".\"tsloai\"*a1.\"pp\"
end as \"costs\"
,a1.\"pp\" as \"pp\"
,a1.\"BrutWeight\" as \"BrutWeight\"
,a1.\"VolWeight\" as \"VolWeight\"
,a1.\"selfbill\" as \"selfbill\"
,a1.\"status\" as \"status\"
,a1.\"name\" as \"name\"
,\"wagens1\".\"zoek\" as \"truck\"
,\"wagens2\".\"zoek\" as \"trailer\"
,case
when \"wagens2\".\"tsloai\" is null
then \"wagens1\".\"tsloai\"
else \"wagens2\".\"tsloai\"
end as \"load indx\"
,case
when \"wagens2\".\"laadma\" is null
then \"wagens1\".\"laadma\"
else \"wagens2\".\"laadma\"
end as \"load weig\"
,a1.\"sb owner\" as \"sb owner\"
,\"wagens2\".\"specvz\" as \"specvz\"
,a1.\"INVOICE_NR\" as \"INVOICE_NR\"
,a1.\"DATE_INVOICE\" as \"DATE_INVOICE\"
,\"BLOCK_STAT\"
,\"ROD_DATE\",\"TAR_DATE\"
from
(
select distinct
aa1.\"period\" as \"period\"
,aa1.\"trip\" as \"trip\"
,case
when substr(aa1.\"trip\",4,2) in ('01','09','14','21','22','40')
then '01'
when substr(aa1.\"trip\",4,2) in ('49','25','34','50')
then '49'
when substr(aa1.\"trip\",4,2) in ('28','46','56')
then '28'
when substr(aa1.\"trip\",4,2) in ('79','33','43','76','88')
then '79'
when substr(aa1.\"trip\",4,2) in ('61','36')
then '61'
when substr(aa1.\"trip\",4,2) in ('65','55','73','95','99')
then '65'
when substr(aa1.\"trip\",4,2) in ('83','71','84','91')
then '83'
when substr(aa1.\"trip\",4,2) in ('69')
then '69'
else 'unknown'
end as \"tripown\"
,case
when substr(aa1.\"dosvlg\",4,2) in
('01','09','14','21','22','40')
then '01'
when substr(aa1.\"dosvlg\",4,2) in ('49','25','34','50')
then '49'
when substr(aa1.\"dosvlg\",4,2) in ('28','46','56')
then '28'
when substr(aa1.\"dosvlg\",4,2) in ('79','33','43','76','88')
then '79'
when substr(aa1.\"dosvlg\",4,2) in ('61','36')
then '61'
when substr(aa1.\"dosvlg\",4,2) in ('65','55','73','95','99')
then '65'
when substr(aa1.\"dosvlg\",4,2) in ('83','71','84','91')
then '83'
when substr(aa1.\"dosvlg\",4,2) in ('69')
then '69'
else 'unknown'
end as \"shipown\"
,sum(nvl(dosmu1.\"bedrlv\",0)) as \"intinc\"
,aa1.\"shipproduct\"
,aa1.\"type\" as \"type\"
,aa1.\"from\"
,aa1.\"to\"
,aa1.\"costs\" as \"costs\"
,sum(aa1.\"pp\") as \"pp\"
,sum(aa1.\"BrutWeight\") as \"BrutWeight\"
,sum(aa1.\"VolWeight\") as \"VolWeight\"
,aa1.\"selfbill\" as \"selfbill\"
,aa1.\"status\" as \"status\"
,aa1.\"name\" as \"name\"
,aa1.\"sb owner\" as \"sb owner\"
,aa1.\"INVOICE_NR\" as \"INVOICE_NR\"
,aa1.\"DATE_INVOICE\" as \"DATE_INVOICE\"
,\"BLOCK_STAT\"
,\"ROD_DATE\",\"TAR_DATE\"
from
(
select distinct
A.\"period\" as \"period\"
,A.\"trip\" as \"trip\"
,\"tsdsmd\".\"dosvlg\" as \"dosvlg\"
,case
when (\"tsdsmd\".\"plaanl\" is null
and substr(\"tsdsmd\".\"dosvlg\",6,1) = 1)
then 'FR'
when (\"tsdsmd\".\"plaanl\" is null
and substr(\"tsdsmd\".\"dosvlg\",6,1) = 2)
then 'DD'
when \"tsdsmd\".\"plaanl\" = 'CHI'
then 'CH'
when \"tsdsmd\".\"plaanl\" = 'MFV'
then 'CH'
when (\"tsdsmd\".\"dosvlg\" is null
and substr(A.\"trip\",6,1) = 6)
then null
when (\"tsdsmd\".\"dosvlg\" is null
and substr(A.\"trip\",6,1) = 3)
then null
else 'MET'
end as \"shipproduct\"
,A.\"type\" as \"type\"
,\"tsdstd\".\"tsfrhn\" as \"from\"
,\"tsdstd\".\"tstohn\" as \"to\"
,A.\"costs\" as \"costs\"
,sum(\"tsdsmd\".\"tsloai\") as \"pp\"
,sum(\"tsdsmd\".\"brgew\") as \"BrutWeight\"
,sum(\"tsdsmd\".\"vogew\") as \"VolWeight\"
,A.\"selfbill\" as \"selfbill\"
,A.\"status\" as \"status\"
,A.\"name\" as \"name\"
,A.\"sb owner\" as \"sb owner\"
,A.\"INVOICE_NR\" as \"INVOICE_NR\"
,A.\"DATE_INVOICE\" as \"DATE_INVOICE\"
,\"BLOCK_STAT\"
,\"ROD_DATE\",\"TAR_DATE\"
from
(
select
AB1.\"tsunld\" as \"period\"
,AB.\"trip\" as \"trip\"
,AB.\"type\" as \"type\"
,AB.\"costs\" as \"costs\"
,AB.\"selfbill\" as \"selfbill\"
,AB.\"status\" as \"status\"
,AB.\"name\" as \"name\"
,case when AB.\"selfbill\" < 999999999
then '0'||substr(AB.\"selfbill\",1,1)
else substr(AB.\"selfbill\",1,2)
end as \"sb owner\",
appsb.\"INVOICE_NR\" as \"INVOICE_NR\",
appsb.\"DATE_INVOICE\" as \"DATE_INVOICE\"
,\"BLOCK_STAT\"
,\"ROD_DATE\",\"TAR_DATE\"
from
(select
\"tsfadd\" as \"period\"
,\"dosvlg\" as \"trip\"
,\"afh\" as \"type\"
,sum(\"bedrvv\") as \"costs\"
,\"boeknr\" as \"selfbill\"
,case
when \"status\" = 9
then '1_Issued'
when \"status\" = 5
then '2_Generated'
else (case
when \"boeknr\" = 0
then '4_Not Issued'
else '3_Temporary' end)
end as \"status\"
,\"zoek\" as \"name\"
from life.\"cef_dosmut\"
where
\"aktkod\" > 0
and (\"afd\" like '%tr'
or \"afd\" like '%ft')
group by
\"tsfadd\"
,\"afh\"
,\"dosvlg\"
,\"boeknr\"
,\"status\"
,\"zoek\") AB
left outer join
life.\"cef_tsdsmd\" AB1
on AB.\"trip\" = AB1.\"dosvlg\"
join
(select distinct
\"BOEKNR\",\"INVOICE_NR\",\"DATE_INVOICE\",
\"DATE_PASS\",\"DATE_RECEIVED\",	
\"ROD_DATE\",\"TAR_DATE\",	
case	
when \"DATE_PASS\" is not null	
then null	
when \"DATE_PASS\" is null	
and \"COMMENT\" is null	
then 'Check in progress'	
when \"DATE_PASS\" is null	
and \"COMMENT\" is not null
then \"COMMENT\"
end as \"BLOCK_STAT\"
from
life.\"APPROVED_SELFBILL\") appsb
on AB.\"selfbill\" = appsb.\"BOEKNR\"
where
#appsb.\"DATE_PASS\" between to_date(SYSDATE,'YYYY-MM-DD')
#and to_date(SYSDATE,'YYYY-MM-DD')+1
    appsb.\"DATE_PASS\" >= to_date(to_char(SYSDATE, 'YYYY-MM-DD'), 'YYYY-MM-DD')
and appsb.\"DATE_PASS\" <= to_date(to_char(SYSDATE+1, 'YYYY-MM-DD'), 'YYYY-MM-DD')

and (AB.\"selfbill\" = ''
or 'x' = 'x')
) A
left outer join
life.\"cef_tsdstd\" \"tsdstd\"
on A.\"trip\" = \"tsdstd\".\"dosvlg\"
left outer join
(select distinct
\"tsrido\"
,\"dosvlg\"
from
life.\"cef_tsroma\") \"tsroma\"
on A.\"trip\" = \"tsroma\".\"tsrido\"
left outer join
(select distinct
\"dosvlg\"
,\"tsloai\"
,\"vogew\"
,\"brgew\"
,\"plaanl\"
from
life.\"cef_tsdsmd\") \"tsdsmd\"
on \"tsdsmd\".\"dosvlg\" = \"tsroma\".\"dosvlg\"
where
(A.\"sb owner\" = ''
or 'a' = 'a')
group by
A.\"period\"
,A.\"trip\"
,case
when (\"tsdsmd\".\"plaanl\" is null
and substr(\"tsdsmd\".\"dosvlg\",6,1) = 1)
then 'FR'
when (\"tsdsmd\".\"plaanl\" is null
and substr(\"tsdsmd\".\"dosvlg\",6,1) = 2)
then 'DD'
when \"tsdsmd\".\"plaanl\" = 'CHI'
then 'CH'
when \"tsdsmd\".\"plaanl\" = 'MFV'
then 'CH'
when (\"tsdsmd\".\"dosvlg\" is null
and substr(A.\"trip\",6,1) = 6)
then null
when (\"tsdsmd\".\"dosvlg\" is null
and substr(A.\"trip\",6,1) = 3)
then null
else 'MET'
end
,A.\"type\"
,\"tsdstd\".\"tsfrhn\"
,\"tsdstd\".\"tstohn\"
,\"tsdsmd\".\"dosvlg\"
,A.\"costs\"
,A.\"selfbill\"
,A.\"status\"
,A.\"name\"
,A.\"sb owner\"
,A.\"INVOICE_NR\"
,A.\"DATE_INVOICE\"
,\"BLOCK_STAT\"
,\"ROD_DATE\",\"TAR_DATE\"
) aa1
left outer join
(
select distinct
\"dosvlg\"
,case
when \"aktkod\" in (601,606)
then 'p'
when \"aktkod\" in (602,603,609,610)
then 'h'
when \"aktkod\" in (604,611)
then 'd'
else 'unknown'
end as \"type1\"
,sum(\"bedrlv\") as \"bedrlv\"
,\"zoek\"
from
life.\"cef_dosmut\" \"dosm\"
where
\"aktkod\" in (601,602,603,604,606,609,610,611)
and \"dosm\".\"mutsrt\" = 'I'
group by
\"dosvlg\"
,case
when \"aktkod\" in (601,606)
then 'p'
when \"aktkod\" in (602,603,609,610)
then 'h'
when \"aktkod\" in (604,611)
then 'd'
else 'unknown'
end
,\"zoek\"
) dosmu1
on aa1.\"dosvlg\" = dosmu1.\"dosvlg\"
and aa1.\"type\" = dosmu1.\"type1\"
and substr(aa1.\"trip\",4,2) = substr(dosmu1.\"zoek\",6,2)
group by
aa1.\"period\"
,aa1.\"trip\"
,aa1.\"shipproduct\"
,aa1.\"type\"
,aa1.\"from\"
,aa1.\"to\"
,aa1.\"costs\"
,aa1.\"selfbill\"
,aa1.\"status\"
,aa1.\"name\"
,case
when substr(aa1.\"trip\",4,2) in ('01','09','14','21','22','40')
then '01'
when substr(aa1.\"trip\",4,2) in ('49','25','34','50')
then '49'
when substr(aa1.\"trip\",4,2) in ('28','46','56')
then '28'
when substr(aa1.\"trip\",4,2) in ('79','33','43','76','88')
then '79'
when substr(aa1.\"trip\",4,2) in ('61','36')
then '61'
when substr(aa1.\"trip\",4,2) in ('65','55','73','95','99')
then '65'
when substr(aa1.\"trip\",4,2) in ('83','71','84','91')
then '83'
when substr(aa1.\"trip\",4,2) in ('69')
then '69'
else 'unknown'
end
,case
when substr(aa1.\"dosvlg\",4,2) in
('01','09','14','21','22','40')
then '01'
when substr(aa1.\"dosvlg\",4,2) in ('49','25','34','50')
then '49'
when substr(aa1.\"dosvlg\",4,2) in ('28','46','56')
then '28'
when substr(aa1.\"dosvlg\",4,2) in ('79','33','43','76','88')
then '79'
when substr(aa1.\"dosvlg\",4,2) in ('61','36')
then '61'
when substr(aa1.\"dosvlg\",4,2) in ('65','55','73','95','99')
then '65'
when substr(aa1.\"dosvlg\",4,2) in ('83','71','84','91')
then '83'
when substr(aa1.\"dosvlg\",4,2) in ('69')
then '69'
else 'unknown'
end
,aa1.\"sb owner\"
,aa1.\"INVOICE_NR\"
,aa1.\"DATE_INVOICE\"
,\"BLOCK_STAT\"
,\"ROD_DATE\",\"TAR_DATE\"
) a1
left outer join
(select distinct
\"tsroma1\".\"tsrido\" as \"dosvlg\"
,count(\"tsroma1\".\"dosvlg\") as \"shipcount\"
,\"tsdsmd2\".\"tarsrt\" as \"tarsrt\"
,\"tsdsmd2\".\"tsdist\" as \"tsdist\"
,\"tsdsmd2\".\"autonr\" as \"autonr\"
,\"tsdsmd2\".\"tsserl\" as \"tsserl\"
,sum(\"tsdsmd3\".\"tsloai\") as \"tsloai\"
from
(select
\"trips\".\"dosvlg\" as \"tsrido\"
,\"shipm\".\"dosvlg\" as \"dosvlg\"
from
life.\"cef_tsdsmd\" \"trips\"
left outer join
(select distinct
\"dosvlg\"
,\"tsrido\"
from
life.\"cef_tsroma\"
) \"shipm\"
on
\"trips\".\"dosvlg\" = \"shipm\".\"tsrido\"
where
substr(\"trips\".\"dosvlg\",6,1) = 3
or substr(\"trips\".\"dosvlg\",6,1) = 6) \"tsroma1\"
left outer join
life.\"cef_tsdsmd\" \"tsdsmd3\"
on \"tsroma1\".\"dosvlg\" = \"tsdsmd3\".\"dosvlg\"
left outer join
life.\"cef_tsdsmd\" \"tsdsmd2\"
on \"tsroma1\".\"tsrido\" = \"tsdsmd2\".\"dosvlg\"
group by
\"tsroma1\".\"tsrido\"
,\"tsdsmd2\".\"tarsrt\"
,\"tsdsmd2\".\"tsdist\"
,\"tsdsmd2\".\"autonr\"
,\"tsdsmd2\".\"tsserl\") \"tsdsmd1\"
on \"tsdsmd1\".\"dosvlg\" = a1.\"trip\"
left outer join
life.\"cef_wagens\" \"wagens1\"
on \"tsdsmd1\".\"autonr\" = \"wagens1\".\"autonr\"
left outer join
life.\"cef_wagens\" \"wagens2\"
on \"wagens1\".\"hrtbij\" = \"wagens2\".\"autonr\"
) a2
) a3
) a4
order by
a4.\"status\"
,a4.\"selfbill\"
,a4.\"period\"
,a4.\"trip\") a5
left outer join
(select distinct
count(z1.\"dosvlg\") as \"ship\"
,z1.\"tsrido\"
,z1.\"proj\"
,z1.\"tripown\"
,case
when z1.\"tripown\" = z1.\"shipown\"
then z1.\"tripown\"
else '<>'||z1.\"tripown\"
end as \"shipdept\"
from
(select distinct
\"tsroma\".\"dosvlg\" as \"dosvlg\"
,\"tsroma\".\"tsrido\" as \"tsrido\"
,case
when substr(\"tsroma\".\"tsrido\",6,1) = 3
then
(case
when \"tsdsmd\".\"plaanl\" = 'CHI'
and substr(\"tsroma\".\"tsrido\",4,2) in
('01','09','14','21','22','40','49','25','34','50')
then '173'
when \"tsdsmd\".\"plaanl\" = 'MFV'
and substr(\"tsroma\".\"tsrido\",4,2) in
('01','09','14','21','22','40','49','25','34','50')
then '173'
when \"tsdsmd\".\"plaanl\" = 'MGL'
and substr(\"tsroma\".\"tsrido\",4,2) in
('01','09','14','21','22','40','49','25','34','50')
then '175'
when \"tsdsmd\".\"plaanl\" = 'RETURN'
and substr(\"tsroma\".\"tsrido\",4,2) in
('01','09','14','21','22','40','49','25','34','50')
then '175'
when (substr(\"tsdsmd\".\"dosvlg\",6,1) = 1)
then '174'
when (substr(\"tsdsmd\".\"dosvlg\",6,1) = 2)
then '177'
else 'unknown'
end)
when substr(\"tsroma\".\"tsrido\",6,1) = 6
then
(case
when \"tsdsmd\".\"plaanl\" = 'CHI'
and substr(\"tsroma\".\"tsrido\",4,2) in
('01','09','14','21','22','40','49','25','34','50')
then '173'
when \"tsdsmd\".\"plaanl\" = 'MFV'
and substr(\"tsroma\".\"tsrido\",4,2) in
('01','09','14','21','22','40','49','25','34','50')
then '173'
when \"tsdsmd\".\"plaanl\" = 'MGL'
and substr(\"tsroma\".\"tsrido\",4,2) in
('01','09','14','21','22','40','49','25','34','50')
then '175'
when \"tsdsmd\".\"plaanl\" = 'RETURN'
and substr(\"tsroma\".\"tsrido\",4,2) in
('01','09','14','21','22','40','49','25','34','50')
then '175'
when (substr(\"tsdsmd\".\"dosvlg\",6,1) = 1)
then '174'
when (substr(\"tsdsmd\".\"dosvlg\",6,1) = 2)
then '177'
else 'unknown'
end)
else 'UNKNOWN'
end as \"proj\"
,case
when substr(\"tsroma\".\"tsrido\",4,2) in
('01','09','14','21','22','40')
then '01'
when substr(\"tsroma\".\"tsrido\",4,2) in ('49','25','34','50')
then '49'
when substr(\"tsroma\".\"tsrido\",4,2) in ('28','46','56')
then '28'
when substr(\"tsroma\".\"tsrido\",4,2) in ('79','33','43','76','88')
then '79'
when substr(\"tsroma\".\"tsrido\",4,2) in ('61','36')
then '61'
when substr(\"tsroma\".\"tsrido\",4,2) in
('65','55','73','95','99')
then '65'
when substr(\"tsroma\".\"tsrido\",4,2) in ('83','71','84','91')
then '83'
when substr(\"tsroma\".\"tsrido\",4,2) in ('69')
then '69'
else 'unknown'
end as \"tripown\"
,case
when substr(\"tsroma\".\"dosvlg\",4,2) in
('01','09','14','21','22','40')
then '01'
when substr(\"tsroma\".\"dosvlg\",4,2) in ('49','25','34','50')
then '49'
when substr(\"tsroma\".\"dosvlg\",4,2) in ('28','46','56')
then '28'
when substr(\"tsroma\".\"dosvlg\",4,2) in ('79','33','43','76','88')
then '79'
when substr(\"tsroma\".\"dosvlg\",4,2) in ('61','36')
then '61'
when substr(\"tsroma\".\"dosvlg\",4,2) in
('65','55','73','95','99')
then '65'
when substr(\"tsroma\".\"dosvlg\",4,2) in ('83','71','84','91')
then '83'
when substr(\"tsroma\".\"dosvlg\",4,2) in ('69')
then '69'
else 'unknown'
end as \"shipown\"
from life.\"cef_tsroma\" \"tsroma\"
left outer join
life.\"cef_tsdsmd\" \"tsdsmd\"
on \"tsdsmd\".\"dosvlg\" = \"tsroma\".\"dosvlg\"
) z1
group by
z1.\"tsrido\"
,z1.\"proj\"
,z1.\"tripown\"
,case
when z1.\"tripown\" = z1.\"shipown\"
then z1.\"tripown\"
else '<>'||z1.\"tripown\"
end
) z2
on
a5.\"trip\" = z2.\"tsrido\"
and a5.\"shipm\" = z2.\"shipdept\"
and substr(a5.\"paydepot\",1,3) = z2.\"proj\"
group by
a5.\"trip stop date\"
,a5.\"trip owner\"
,a5.\"trip\"
,a5.\"shipcount\"
,a5.\"shipm\"
,z2.\"ship\"
,a5.\"paydepot\"
,a5.\"prodaccount\"
,a5.\"Koeficient\"
,a5.\"type\"
,a5.\"tariff\"
,a5.\"dist\"
,a5.\"from\"
,a5.\"to\"
,a5.\"coststotal\"
,a5.\"selfbill\"
,a5.\"status\"
,a5.\"name\"
,a5.\"truck\"
,a5.\"trailer\"
,a5.\"load indx\"
,a5.\"load weig\"
,a5.\"sb owner\"
,a5.\"specvz\"
,a5.\"tsserl\"
,a5.\"INVOICE_NR\"
,a5.\"DATE_INVOICE\"
,\"BLOCK_STAT\"
,\"ROD_DATE\",\"TAR_DATE\"
order by
a5.\"status\"
,a5.\"selfbill\"
,a5.\"trip stop date\"
,a5.\"trip\"
) a6
group by
a6.\"trip stop date\"
,a6.\"trip owner\"
,a6.\"trip\"
,a6.\"shipments total\"
,a6.\"shipment owner\"
,case
when (a6.\"shipments total\" = 0
and substr(a6.\"paydepot\",4,2) in ('49','01')
and substr(a6.\"trip\",6,1) = 6)
then (case
when a6.\"tsserl\" = 'MGL'
then '175'
else '177'
end)||
case
when a6.\"tsserl\" = 'MGL'
and substr(a6.\"paydepot\",4,2) = '01'
then '02'
when a6.\"tsserl\" = 'MGL'
and substr(a6.\"paydepot\",4,2) = '49'
then '48'
else
substr(a6.\"paydepot\",4,2)
end
when (a6.\"shipments total\" = 0
and substr(a6.\"paydepot\",4,2) in ('49','01')
and substr(a6.\"trip\",6,1) = 3)
then (case
when a6.\"tsserl\" = 'MGL'
then '173'
else '174'
end)||
case
when a6.\"tsserl\" = 'MGL'
and substr(a6.\"paydepot\",4,2) = '01'
then '02'
when a6.\"tsserl\" = 'MGL'
and substr(a6.\"paydepot\",4,2) = '49'
then '48'
else
substr(a6.\"paydepot\",4,2)
end
else a6.\"paydepot\"
end
,a6.\"prodaccount\"
,a6.\"koeficient\"
,a6.\"trip type\"
,a6.\"tariff\"
,a6.\"distance\"
,a6.\"from\"
,a6.\"to\"
,a6.\"total costs\"
,a6.\"selfbill\"
,a6.\"status\"
,a6.\"name\"
,a6.\"truck\"
,a6.\"trailer\"
,a6.\"load indx\"
,a6.\"load weig\"
,a6.\"sb owner\"
,a6.\"specvz\"
,a6.\"tsserl\"
,a6.\"INVOICE_NR\"
,a6.\"DATE_INVOICE\"
,\"BLOCK_STAT\"
,\"ROD_DATE\",\"TAR_DATE\") a7
group by
a7.\"trip stop date\"
,a7.\"trip owner\"
,a7.\"trip\"
,a7.\"shipments total\"
,a7.\"shipment owner\"
,a7.\"paydepot\"
,case
when a7.\"paydepot\" = '17401'
and a7.\"prodaccount\" = '8055'
and substr(a7.\"from\",2,2) = '01'
and substr(a7.\"to\",2,2) in ('09','14','21','22','40')
then '8051'
when a7.\"paydepot\" = '17428'
and a7.\"prodaccount\" = '8055'
and substr(a7.\"from\",2,2) = '28'
and substr(a7.\"to\",2,2) in ('56','46')
then '8051'
when a7.\"paydepot\" = '17449'
and a7.\"prodaccount\" = '8055'
and substr(a7.\"from\",2,2) = '49'
and substr(a7.\"to\",2,2) in ('34','50','25')
then '8051'
when a7.\"paydepot\" = '17479'
and a7.\"prodaccount\" = '8055'
and substr(a7.\"from\",2,2) = '79'
and substr(a7.\"to\",2,2) in ('33','76','43','88')
then '8051'
when a7.\"paydepot\" = '17465'
and a7.\"prodaccount\" = '8055'
and substr(a7.\"from\",2,2) = '65'
and substr(a7.\"to\",2,2) in ('73','99')
then '8051'
when a7.\"paydepot\" = '17461'
and a7.\"prodaccount\" = '8055'
and substr(a7.\"from\",2,2) = '61'
and substr(a7.\"to\",2,2) in ('36')
then '8051'
when a7.\"paydepot\" = '17483'
and a7.\"prodaccount\" = '8055'
and substr(a7.\"from\",2,2) = '83'
and substr(a7.\"to\",2,2) in ('71','84','91')
then '8051'
when a7.\"paydepot\" = '17401'
and a7.\"prodaccount\" = '8015'
and substr(a7.\"from\",2,2) = '01'
and substr(a7.\"to\",2,2) in ('09','14','21','22','40')
then '8011'
when a7.\"paydepot\" = '17428'
and a7.\"prodaccount\" = '8015'
and substr(a7.\"from\",2,2) = '28'
and substr(a7.\"to\",2,2) in ('56','46')
then '8011'
when a7.\"paydepot\" = '17479'
and a7.\"prodaccount\" = '8015'
and substr(a7.\"from\",2,2) = '79'
and substr(a7.\"to\",2,2) in ('33','76','43','88')
then '8011'
when a7.\"paydepot\" = '17465'
and a7.\"prodaccount\" = '8015'
and substr(a7.\"from\",2,2) = '65'
and substr(a7.\"to\",2,2) in ('73','99')
then '8011'
when a7.\"paydepot\" = '17461'
and a7.\"prodaccount\" = '8015'
and substr(a7.\"from\",2,2) = '61'
and substr(a7.\"to\",2,2) in ('36')
then '8011'
when a7.\"paydepot\" = '17483'
and a7.\"prodaccount\" = '8015'
and substr(a7.\"from\",2,2) = '83'
and substr(a7.\"to\",2,2) in ('71','84','91')
then '8011'
when a7.\"paydepot\" = '17449'
and a7.\"prodaccount\" = '8015'
and substr(a7.\"from\",2,2) = '49'
and substr(a7.\"to\",2,2) in ('34','50','25')
then '8011'
else a7.\"prodaccount\"
end
,a7.\"koeficient\"
,a7.\"trip type\"
,a7.\"tariff\"
,a7.\"distance\"
,a7.\"from\"
,a7.\"to\"
,a7.\"total costs\"
,a7.\"selfbill\"
,a7.\"status\"
,a7.\"name\"
,a7.\"truck\"
,a7.\"trailer\"
,a7.\"load indx\"
,a7.\"load weig\"
,a7.\"sb owner\"
,a7.\"specvz\"
,a7.\"INVOICE_NR\"
,a7.\"DATE_INVOICE\"
,\"BLOCK_STAT\"
,\"ROD_DATE\",\"TAR_DATE\") a8
group by
a8.\"trip stop date\"
,a8.\"trip owner\"
,a8.\"trip\"
,a8.\"shipments total\"
,a8.\"shipment owner\"
,a8.\"paydepot\"
,a8.\"prodaccount\"
,case
when a8.\"prodaccount\" = '8031'
then 'K6'
when a8.\"prodaccount\" = '8071'
then 'K9'
when a8.\"prodaccount\" = '8011'
then 'K1'
when a8.\"prodaccount\" = '8015'
then 'K2'
when a8.\"prodaccount\" = '8051'
then 'K5'
when a8.\"prodaccount\" = '8055'
then 'K9'
else 'UNKNOWN'
end
,a8.\"trip type\"
,a8.\"tariff\"
,a8.\"distance\"
,a8.\"from\"
,a8.\"to\"
,a8.\"total costs\"
,a8.\"selfbill\"
,a8.\"status\"
,a8.\"name\"
,a8.\"truck\"
,a8.\"trailer\"
,a8.\"load indx\"
,a8.\"load weig\"
,a8.\"sb owner\"
,a8.\"specvz\"
,a8.\"INVOICE_NR\"
,a8.\"DATE_INVOICE\"
,\"BLOCK_STAT\"
,\"ROD_DATE\",\"TAR_DATE\") a9
left outer join
life.\"cef_relati\" relati
on relati.\"zoek\" = a9.\"name\"
group by
a9.\"paydepot\"
,a9.\"prodaccount\"
,a9.\"selfbill\"
,a9.\"status\"
,a9.\"name\"
,relati.\"naam1\"||relati.\"naam2\"
,relati.\"relnr\"
,a9.\"INVOICE_NR\"
,a9.\"DATE_INVOICE\"
,\"BLOCK_STAT\"
,\"ROD_DATE\",\"TAR_DATE\"
order by
a9.\"status\"
,a9.\"selfbill\"
; 
"
