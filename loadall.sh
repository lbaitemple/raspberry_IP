sudo apt-get install python-pip python-pil  i2c-tools git mosquitto-clients -y
git clone -b nomqtt  https://github.com/lbaitemple/raspberry_IP/
sudo pip install Adafruit_SSD1306 RPi.GPIO Adafruit_BBIO
sudo sh raspberry_IP/setup-i2c.sh
cp raspberry_IP/newtest2.sh ~/test2.sh
cp raspberry_IP/stats.py ~/stats.py
chmod +x ~/test2.sh

sudo cp raspberry_IP/ipaddress.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable  ipaddress
sudo systemctl start  ipaddress
