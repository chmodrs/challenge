#!/bin/bash

MAIL=youremail@company.com

apt-get install -y sendmail mailutils

date="`date +%d/%b/%Y`"; \
for webserver in nginx; do \
echo -e "********** BEGIN Report for $webserver **********\n\n"; \
for log in `ls /var/log/$webserver/ | grep "access.log"`; do \
echo -e "\n$log\n"; \
awk -v d=$date '$4 ~ d && $9~/^[4-5]/' /var/log/$webserver/$log; \
done; \
echo -e "\n\n********** END Report for $webserver **********\n\n"; \
done | mail -s "Daily 4xx/5xx Report from `hostname`" $MAIL
