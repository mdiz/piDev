"# piDev" 

Pi Setup:
Install Raspbian Buster with desktop
Setup network
Enable SSH and VNC (sudo raspi-config)
Set Lua package.path to include Lua application locations
	package.path="./?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/usr/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?/init.lua;/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua;/home/pi/Documents/?.lua;/home/pi/Documents/piDev/?.lua"


	Setup Lua enviroment variables
	Install LuaRocks (module manager)
	Install lua-periphery I/O ((GPIO, SPI, I2C, MMIO, Serial)

git clone https://github.com/mdiz/piDev.git
info on git commands: https://www.linode.com/docs/development/version-control/how-to-install-git-and-clone-a-github-repository/
git status (update of any changed files)
git add . (add all changed files to staging area)
git commit -m "Test files for test-repo-789 fork" (Add commit)
git push (push local commits to git)
git pull (to update a repository)


Install the megaio software from github.com:
~$ git clone https://github.com/SequentMicrosystems/megaio-rpi.git
~$ cd /home/pi/megaio-rpi
~/megaio-rpi$ sudo make install
~/megaio-rpi$ megaio

Raspberry Pi Commands
gpio readall
sudo raspi-config
https://learn.sparkfun.com/tutorials/raspberry-pi-spi-and-i2c-tutorial/all
https://www.google.com/search?q=wiringPI&rlz=1C1CHBF_enUS822US822&oq=wiringPI&aqs=chrome..69i57.2455j0j7&sourceid=chrome&ie=UTF-8

ADC Hats
http://linuxgizmos.com/17-raspberry-pi-hat-features-8-channel-adc/
Pimoroni’s $37 Automation HAT. 
RPi Zero sized RasPiO Analog Zero board.

Next Steps:
Create Lua code repository dir where all DGP files will reside
Create IO table
Create functions to read/write IO to/from IO table
Create a table for advValue=Temp with 10k-3.  Use resistance functions as tools to build it

