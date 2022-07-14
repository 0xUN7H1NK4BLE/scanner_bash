#!/bin/bash
ifconfig | grep 'inet '| grep -v "127.0.0.1"| cut -d" " -f10 >list1.txt
echo "Starting scanner"
echo " "
ip=$(cat list1.txt)
echo "Your IP is $ip"
echo " "
a=$(ifconfig | grep $ip | cut -d" " -f13)
echo Your subnet mask for $ip is:$a So,
echo ""
if [ $a == "255.255.255.0" ]; then
echo "Your subnet is 24."
b=24
elif [ $a == "255.255.0.0"]; then
echo " Your subnet is 16."
b=16
else
echo " Your subnet is 8."
b=8
fi
echo " "
function yes() {
echo "Do you want to scan your network?(y/n)"
read c
if [ $c == "y" ]; then
echo ".....Starting to scan your network..... "
nmap -sn $ip/$b>list1.txt
echo " "
echo "....Scanning is over...."
elif [[ $c == "n" ]]; then
echo "existing the scanner..."
exit
else 
echo "*****wrong input*****"
yes
fi
}
yes
function ip() {
cat list1.txt|grep "scan " | cut -d" " -f5>list2.txt
nl -s "." list2.txt>list3.txt

echo "Do you want to see the result or save it"
echo "[*]"
echo "     v to view and s to save"
read d
if [[ $d == "v" ]]; then

 echo " The ip in your network are"
 #cat list1.txt | grep "scan " | cut -d" " -f5>list2.txt
 #nl -s "." list1.txt>list3.txt
 cat list3.txt
elif [[ $d == "s" ]]; then
        echo "please name your file"
        read name
        cp list1.txt $name
        echo "your file location is $(readlink -f $name)"
else
 echo "***error in your input***"
 echo " " 
 ip
fi

}
ip
function run() {
echo "Do you want to scan the host(y/n)"
read ans
if [ $ans = "y" ]; then
 echo ".....Listing all the available host..... "
 cat list3.txt
elif [[ $ans == "n" ]]; then
        echo "....existing the scanner..."
        exit
else
 echo "please enter valid word"
 run
fi
}
run

function scan() {
echo " Which ip do You want to scan"
read num
re='^[0-9]+$'
if [[ $num =~ $re ]]; then
cat list3.txt | tail -n 1 | cut -d"." -f1>list4.txt
a=$(cat list4.txt)
if [[ $num -le $a ]]; then
head -n $num list2.txt | tail -1>list1.txt
c=$(cat list1.txt)
else
echo "enter valid number"
scan
fi
else
echo "enter a valid number"
scan
fi
}
scan
function port() {
echo "..what do you want to scan port or all(p/a).."
echo ".......press ctrl + c or exit to end........"
read data
if [[ $data == "p" ]]; then
echo "********************************"
echo "*******Scanning for ports*******"
echo "********************************"
nmap -p- $c>list1.txt
cat list1.txt | grep "open " >list2.txt
head -n 1 list2.txt | cut -d"o" -f2 | cut -d" " -f1>list3.txt
pen=$(cat list3.txt)
 if [[ $pen == "pen" ]]; then
echo "The open ports with service are:"
   cat list1.txt| grep "PORT" && cat list1.txt | grep "open "
   port
 else 
   echo "No port is open"
   port
 fi
elif [[ $data == "a" ]]; then
echo "********************************"
echo "*******Aggressive scanning******"
echo "********************************"
sudo nmap -A -sV -sS $c>list1.txt
cp list1.txt agg-scan
echo "The output of this result is saved in a file "agg-scan""
echo in
pwd
elif [[ $data == "exit" ]]; then
echo "******closing*****"
exit
else
echo "..Wrong input"
port
fi
}
port


rm list1.txt list2.txt list3.txt list4.txt 




