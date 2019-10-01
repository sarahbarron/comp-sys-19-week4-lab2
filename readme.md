# 04: Computer Networks and the TCP/IP Protocol Stack

## Lab 2

### webserver-eth1-traffic1.pcap
---------------------------------
This file contains the recording of 10 ICMP packets on eth1 interface

I entered the following command in the webserver to create this file

```$ tshark -i eth1 -f icmp -c 10 -w /vagrant/webserver-eth1-traffic1.pcap ```
 
### webserver-eth0-traffic1.pcap
---------------------------------
Capture and analyse remote ICMP Data

This file contains the recordings of ICMP packets this time on the eth0
interface. This recording includes pings made to google.ie, www.cisco.com
and www.yahoo.com

I entered the following command in the webserver to create this file

```$ tshark -w /vagrant/webserver-eth0-traffic1.pcap -i etho0 -f icmp >& /dev/null &```

### webserver-eth0-traffic2.pcap
---------------------------------
FTP PDU Capture

This file contains recordings of FTP network traffic. Traffic was captured 
on the webserver network interface eth0, filtering to port 20 and 21.

In the webserver i entered the following commands to create this file 

```$ tshark -w /vagrant/webserver-eth0-traffic2.pcap -i eth0 -f "tcp port 20 or tcp port 21" >& /dev/null $```

```$ ftp speedtest.tele2.net```
 
#### Lab2(3) Question 5

I examined the output, of an FTP frame and could see the protocols encapsulated

Encapsulation Type - Ethernet (1)

Protocols in Frame - eth:ethertype:ip:tcp:ftp

Ethernet II

Internet Protocol Version 4

Transmission Control Protocol

File Transfer Protocol (FTP)  

### webserver-eth0-traffic3.pcap
----------------------------------
HTTP PDU Capture

This file contains recording of captured tcp traffic on port 80. 

The command I entered to create this file was

```$ tshark -w /vagrant/webserver-eth0-traffic3.pcap -i etho 0 -f "tcp port 80" >& /dev/null &```

followed by `wget http://www.google.ie` this retrieved content from google, causing traffic on the network

### webserver-eth0-traffic4.pcap
----------------------------------
Here a large amount of captured tcp network traffic are sorted into unique website addresses, 
they are sorted and stored alphabetically in this file.

* Capturing the traffic

```$tshark -w /vagrant/webserver-eth0-traffic4.pcap -i eth0 -f "tcp port 80" >& /dev/null &```

* Traffic was created by requesting `wget` information from www.bbc.co.uk, www.wit.ie, www.yahoo.ie, www.rte.ie and www.facebook.com

* Filtering the traffic by unique website addresses and sorting them alphabetically

```$ tshark -r /vagrant/webserver-eth0-traffic4.pcap -Y http.request -T fields -e http.host -e http.user_agent | sort | uniq-c | sort -n```

### Exercise 1
-------------------
* solution.txt and ip_addresses.txt are stored in folder /exercises/exercise1/

Using the traffic captured in webserver-eth0-traffic4.pcap I was able to list just the unique IP addresses of the HTTP response.

I stored these IP addresses in ip_addresses.txt.

I used the following command to find, list and store these unique IP addresses

```$ tshark -r /vagrant/webserver-eth0-traffic4.pcap -Y http.response -T fields -e ip.src | sort | uniq | sort -n >& ip_addresses.txt```


### Exercise 2
-------------------
* Stored in folder /exercises/exercise2/
    - Script - solution.sh
    - Stored MAC Address - solution.txt
    - Pcap file - webserver-eth1-traffic2.pcap

1. Using `ifconfig` I was able to find out the MAC address of interface eth1 on dbserver

    MAC address: 08:00:27:5a:8c:ca

2. I started tshark on interface eth1 on webserver and captured 20 packets

```$tshark -i eth1 -c 20 -w webserver-eth1-traffic2.pcap``` 

3. I pinged the webserver (192.168.5.2) from both the host and the dbserver

4. The script solution.sh takes in 2 parameteres the first parameter is the name of the pcap 
file and the second parameter is the MAC address you want to check if its a source address of 
ethernet frames. 

I ran the following command to check that the MAC address of the dbserver was a source address 
of ethernet frames in the webserver-eth1-traffic2.pcap file.
 
```$ .solution.sh webserver-eth1-traffic2.pcap 08:00:27:5a:8c:ca```
