# raspberry_IP
#This code will upload raspberry private ip address to iot.eclipse.org using mqtt protocol
```
#sudo apt-get install python-pip python-pil  i2c-tools git mosquitto-clients -y
git clone https://github.com/lbaitemple/raspberry_IP/
sudo pip install Adafruit_SSD1306 RPi.GPIO
sudo sh raspberry_IP/setup-i2c.sh
cp raspberry_IP/newtest2.sh ~/test2.sh
cp raspberry_IP/stats.py ~/stats.py
chmod +x ~/test2.sh
```
### need nodejs > 12.0.0, you will need to install nvm [do not use default raspberry pi node install]
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
source ~/.bashrc 
nvm install node
```

# Install jupyter lab
```
sudo apt install python3-pip python3-pil  i2c-tools git mosquitto-clients -y
sudo pip3 install jupyter jupyterlab
sudo jupyter labextension install @jupyter-widgets/jupyterlab-manager
jupyter lab --generate-config
```
#jupyter notebook password
```
python3 -c "from notebook.auth.security import set_password; set_password('$password', '$HOME/.jupyter/jupyter_notebook_config.json')"
```
# install jetbot python module
```
cd
sudo apt install -y python3-smbus
cd ~/pi
sudo apt-get install -y cmake
sudo python3 setup.py install 
```
# Install jetbot services
```
cd jetbot/utils
python3 create_stats_service.py
sudo mv jetbot_stats.service /etc/systemd/system/jetbot_stats.service
sudo systemctl enable jetbot_stats
sudo systemctl start jetbot_stats
python3 create_jupyter_service.py
sudo mv jetbot_jupyter.service /etc/systemd/system/jetbot_jupyter.service
sudo systemctl enable jetbot_jupyter
sudo systemctl start jetbot_jupyter
```
# Make swapfile
```
cd 
sudo fallocate -l 4G /var/swapfile
sudo chmod 600 /var/swapfile
sudo mkswap /var/swapfile
sudo swapon /var/swapfile
sudo bash -c 'echo "/var/swapfile swap swap defaults 0 0" >> /etc/fstab'
```
# Copy JetBot notebooks to home directory
```
cp -r ~/jetbot/notebooks ~/Notebooks
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
