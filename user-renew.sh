#!/bin/bash
#Script Created By Pa'an Finest
echo -e "\e[032;1m---------- Menambah Masa\e[0m \e[034;1mAktif Akun SSH----------\e[0m"
# begin of user-list
echo "-----------------------------------"
echo "USERNAME              EXP DATE     "
echo "-----------------------------------"

while read expired
do
	AKUN="$(echo $expired | cut -d: -f1)"
	ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
	exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
	if [[ $ID -ge 1000 ]]; then
		printf "%-21s %2s\n" "$AKUN" "$exp"
	fi
done < /etc/passwd
echo "-----------------------------------"
echo ""
# end of user-list

read -p "Isikan username: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	#read -p "Isikan password akun [$username]: " password
	read -p "Berapa hari akun [$username] aktif: " AKTIF
	
	expiredate=$(chage -l $username | grep "Account expires" | awk -F": " '{print $2}')
	today=$(date -d "$expiredate" +"%Y-%m-%d")
	expire=$(date -d "$today + $AKTIF days" +"%Y-%m-%d")
	chage -E "$expire" $username
	passwd -u $username
	#useradd -M -N -s /bin/false -e $expire $username

	echo ""
	echo "------------------------------------------"
	echo "Informasi Detail Akun Anda :"
	echo "------------------------------------------"
	echo "Host/IP: $MYIP"
	echo "Username : $username"
	echo "Password : $password"
	echo "OpenSSH Port : 22, 143"
  echo "SSL/TSL Port : 443"
	echo "Squid Proxy : 80, 8080, 3128"
	echo "OpenVPN Config : http://$MYIP:81/client.ovpn"
	echo "Aktif Sampai : $(date -d "$AKTIF days" +"%d-%m-%Y")"
    echo -e "\e[032;1mScript Created\e[0m \e[034;1mBy Pa'an Finest\e[032;1m"
    echo "------------------------------------------"
    echo ""
    echo -e " \e[032;1m[ Facebook : Pa'an\e[0m | \e[031;1mInstagram : @paan_finest\e[0m | \e[034;1mWA : +1 (202) 852-2868 ]\e[0m"
    echo ""
else
	echo "Username [$username] belum terdaftar!"
	exit 1
fi
