sudo apt-get update
sudo apt-get install python3-pip python3-pil  i2c-tools git mosquitto-clients -y
git clone -b jupyter https://github.com/lbaitemple/raspberry_IP/
sudo pip3 install --system  Adafruit_SSD1306 RPi.GPIO
sudo bash raspberry_IP/setup-i2c.sh
cp raspberry_IP/newtest2.sh ~/test2.sh
cp raspberry_IP/stats.py ~/stats.py
chmod +x ~/test2.sh
sudo systemctl enable systemd-networkd-wait-online.service
sudo cp raspberry_IP/ipaddress.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable  ipaddress
sudo systemctl start  ipaddress

sudo dd if=/dev/zero of=/swap1 bs=1M count=4096
sudo mkswap /swap1
sudo swapon /swap1
sudo bash -c "echo '/swap1 swap swap' >> /etc/fstab"
