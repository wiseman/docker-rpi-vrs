#!/bin/sh

if [ ! -f /app/vrs/admin_created ]
then
	echo "First Time Run: Admin account created"
	echo "Username: admin"
	echo "Password: password"
	touch /app/vrs/admin_created
	mono /app/vrs/VirtualRadar.exe -createAdmin:admin -password:password -nogui
else	
	mono /app/vrs/VirtualRadar.exe -nogui
fi
