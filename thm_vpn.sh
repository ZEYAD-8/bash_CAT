#!/bin/bash
select option in connect disconnect
do 
    if [ $option == "connect" ] ; then 
        sudo -v
        echo "//-----------------------------------------------------\\\\"
        echo "|| ----------- Initializing warp connection ----------- ||"
        echo "\\\\-----------------------------------------------------//"

        warp-cli connect

        sleep 5
        if ifconfig | grep -q "CloudflareWARP" ; then
            echo "--------> warp is initiated"
        else
            echo "--------> something is wrong with warp"
            exit 1
        fi

        echo "//-----------------------------------------------------\\\\"
        echo "|| ---------- Initializing openvpn connection --------- ||"
        echo "\\\\-----------------------------------------------------//"

        sudo openvpn ~/Desktop/zeyad.10.ovpn > /dev/null 2>&1 &

        sleep 5
        if ifconfig | grep -q "tun0" ; then
            echo "--------> openvpn started"
        else
            echo "--------> something is wrong with openvpn"
            warp-cli disconnect
            exit 1
        fi

        echo "*** Testing the connection"
        ping 10.10.10.10 -c 3

        echo "//-----------------------------------------------------\\\\"
        echo "|| -------------- Closing warp connection ------------- ||"
        echo "\\\\-----------------------------------------------------//"

        warp-cli disconnect

    elif [ $option == "disconnect" ] ; then
        echo "//-----------------------------------------------------\\\\"
        echo "|| ---------------- Disconnecting openvpn ------------- ||"
        echo "\\\\-----------------------------------------------------//"

        sudo pkill openvpn
    fi
    break
done
