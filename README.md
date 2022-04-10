# raspberry_IP
#This code will upload raspberry private ip address to iot.eclipse.org using mqtt protocol
```
sudo apt-get install python-pip python-pil  i2c-tools git mosquitto-clients -y
git clone -b nomqtt  https://github.com/lbaitemple/raspberry_IP/
sudo pip install Adafruit_SSD1306 RPi.GPIO
sudo sh raspberry_IP/setup-i2c.sh
cp raspberry_IP/newtest2.sh ~/test2.sh
cp raspberry_IP/stats.py ~/stats.py
chmod +x ~/test2.sh
```

You will need to ensure a startup service to enable network
```
sudo systemctl is-enabled systemd-networkd-wait-online.service
sudo systemctl enable systemd-networkd-wait-online.service
```
Now, you will need to create a startup service
```
sudo cp raspberry_IP/ipaddress.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable  ipaddress
sudo systemctl start  ipaddress
```


If you have a local mqtt broker, you can use the following command to read ip address
```
mosquitto_sub -t raspberry/ipaddress
```

You should be able to search a MQTTbox in google
![Alt text](mqtt/step1.png?raw=true "Download MQTTBox")

Install MQTTbox in Chrome Store
![Alt text](mqtt/step2.png?raw=true "MQTTBox")

You can setup a new MQTT client

![Alt text](mqtt/step3.png?raw=true "MQTTBox")

In the new client, please specify m16.cloudmqtt.com:12247, username: pspniyjc, password: sBm4EpaDgRe5 as shown in the redbox
![Alt text](mqtt/step4.png?raw=true "MQTTBox")


Specify a new topic in subscriber as "raspberry/ipaddress"
![Alt text](mqtt/step5.png?raw=true "MQTTBox")

You can remove publisher as shown in the figure below
![Alt text](mqtt/step6.png?raw=true "MQTTBox")

In your raspberry pi, you can click on the last two pins so you will see you will the new private IP address of raspberry Pi.
![Alt text](mqtt/step7.png?raw=true "MQTTBox")

We can also add google text to speech to speak out the ip address. However, you will need to do the following commands
```
sudo apt-get install mplayer -y
nano $HOME/.mplayer/config 
```
you will add a line of the following in the file
```
lirc=no
```

### step 6: Setup USB-C OTG
#### open configuration file
```
sudo nano /boot/config.txt
```
add a line to the end of the file
```
dtoverlay=dwc2
```

#### open cmdline file
```
sudo nano /boot/cmdline.txt
```
add below before "root=" (make sure that is one line)
```
modules-load=dwc2 
```
#### open moddule file
```
sudo nano /etc/modules
```
add  a line to the end of the file
```
libcomposite 
```

#### open dhcpcd.conf file
```
sudo nano  /etc/dhcpcd.conf
```
add  a line to the end of the file
```
denyinterfaces usb0 
```

###### Install dnsmasq
```
sudo apt-get install dnsmasq -y
sudo nano /etc/dnsmasq.d/usb
```
Add the following content
```
interface=usb0
dhcp-range=10.55.0.2,10.55.0.6,255.255.255.248,1h
dhcp-option=3
leasefile-ro
```

###### Install ifdownup
```
sudo apt-get install ifupdown -y
sudo nano /etc/network/interfaces
```
Add the following content
```
auto usb0
allow-hotplug usb0
iface usb0 inet static
  address 10.55.0.1
  netmask 255.255.255.248
  
allow-hotplug wlan0
iface wlan0 inet dhcp
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
iface default inet dhcp

```

#### create a startup file
```
sudo nano /root/usb.sh
```
Add the following content
```
#!/bin/bash
cd /sys/kernel/config/usb_gadget/
mkdir -p pi4
cd pi4
echo 0x1d6b > idVendor # Linux Foundation
echo 0x0104 > idProduct # Multifunction Composite Gadget
echo 0x0100 > bcdDevice # v1.0.0
echo 0x0200 > bcdUSB # USB2
echo 0xEF > bDeviceClass
echo 0x02 > bDeviceSubClass
echo 0x01 > bDeviceProtocol
mkdir -p strings/0x409
echo "fedcba9876543211" > strings/0x409/serialnumber
echo "Ben Hardill" > strings/0x409/manufacturer
echo "PI4 USB Device" > strings/0x409/product
mkdir -p configs/c.1/strings/0x409
echo "Config 1: ECM network" > configs/c.1/strings/0x409/configuration
echo 250 > configs/c.1/MaxPower
# Add functions here
# see gadget configurations below
# End functions
mkdir -p functions/ecm.usb0
HOST="00:dc:c8:f7:75:14" # "HostPC"
SELF="00:dd:dc:eb:6d:a1" # "BadUSB"
echo $HOST > functions/ecm.usb0/host_addr
echo $SELF > functions/ecm.usb0/dev_addr
ln -s functions/ecm.usb0 configs/c.1/
udevadm settle -t 5 || :
ls /sys/class/udc > UDC
ifup usb0
service dnsmasq restart
```

#### create rc.local file
```
sudo nano /etc/rc.local
```
Add the following content
```
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.
/root/usb.sh

exit 0
```

#### make /root/usb.sh executable
```
sudo chmod +x /etc/rc.local
sudo chmod +x /root/usb.sh
```

