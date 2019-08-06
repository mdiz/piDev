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
git commit -m "Test files for test-repo-789 fork" (send files to git)
git pull (to update a repository)
git push (push local commits)

Install the megaio software from github.com:
~$ git clone https://github.com/SequentMicrosystems/megaio-rpi.git
~$ cd /home/pi/megaio-rpi
~/megaio-rpi$ sudo make install
~/megaio-rpi$ megaio



Next Steps:
Create Lua code repository dir where all DGP files will reside
Create IO table
Create functions to read/write IO to/from IO table