#!/bin/bash
OPENVPN_PATH=/openvpn/route-nw

#ipv4 insert check --
echo -n "Do you want to input ip information? [y/n] : ";
  read vChk

  if [ $vChk == "y" ]; then
        echo -n "What is my ipv4 : ";
          read IP

        vString="$IP via 10.178.0.1"

        echo $vString | sudo tee -a $OPENVPN_PATH > /dev/null
        sudo cat $OPENVPN_PATH

        #service restart
        sudo service network restart
        #vpn start
        sudo nohup openvpn --config /openvpn/ENCORE_RND_VPN.ovpn > ./log/route.log 2>&1 &
        #sudo nohup openvpn --config /openvpn/ENCORE_RND_VPN.ovpn > /dev/null 2>&1 & ./log/route.log
        #ping test
sleep 1
echo "Route Setting End..."
  elif [ $vChk == "n" ]; then
        #service restart
        #sudo service network restart
        #vpn start
        sudo nohup openvpn --config /openvpn/ENCORE_RND_VPN.ovpn > ./log/route.log 2>&1 &
        #sudo nohup openvpn --config /openvpn/ENCORE_RND_VPN.ovpn > /dev/null 2>&1 & > ./log/route.log
        #ping test
sleep 1
echo "Route Setting End..."
  else
    exit;
  fi
