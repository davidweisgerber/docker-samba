#!/bin/bash


at_term() { 
  echo "Caught SIGTERM signal!" 
    /etc/init.d/samba stop
    /etc/init.d/nmbd stop
  
  exit 0
}

trap at_term TERM

rm -rf /etc/samba
if [ ! -d "/data/config" ]; then
  mkdir /data/config
fi
ln -s /data/config /etc/samba
  
rm -rf /var/lib/samba
if [ ! -d "/data/lib" ]; then
  mkdir /data/lib
fi
ln -s /data/lib /var/lib/samba

rm -rf /var/lib/krb5kdc
if [ ! -d "/data/krb5kdc" ]; then
  mkdir /data/krb5kdc
fi
ln -s /data/krb5kdc /var/lib/krb5kdc

rm -rf /var/run/samba
if [ ! -d "/data/run" ]; then
  mkdir /data/run
fi
ln -s /data/run /var/run/samba

cp /var/lib/samba/private/krb5.conf /etc/krb5.conf

/etc/init.d/samba start
/etc/init.d/nmbd start

while true; do
    sleep 20
done

