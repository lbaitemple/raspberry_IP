# raspberry_IP
#This code will upload raspberry private ip address to iot.eclipse.org using mqtt protocol
```
sudo apt-get install python-pip python-pil  i2c-tools git mosquitto-clients -y
git clone https://github.com/lbaitemple/raspberry_IP/
sudo pip install Adafruit_SSD1306 RPi.GPIO
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
