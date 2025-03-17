# Bitwig RPM Generator + Extractor
In this script we are going to extract the contents of the given
bitwig debian packages also we will get an rpm package in the process
also we will get a nice folder with bitwigs contents reasy to use any distro.


*Makefile Structure*

 - 1. Downloading Bitwig .deb into /tmp/
 - 2. Installing Dependencies
 - 2.1 Debian
 - 2.2 Fedora
 - 3. Entering the convertion & extraction script (you will get an log file too)
 - 4. Patience the step above takes alot of time do not worry it's not frozen
 - 5. Done

Lastly, cd into the build directory
	For the universal linux folder go to */tmp/bitbox-convertion/bitwig-studio-5.3.2/*
		The opt/ folder contains the executable and the /usr folder contains the symbolic link
	For the rpm package */tmp/bitbox-convertion/* and use *bitwig-studio-5.3.2-2.x86_64.rpm* the way you want to :)
		sudo dnf5 install ./tmp/bitbox-convertion/bitwig-studio-5.3.2-2.x86_64.rpm or use in a container whatever you like

Contents of the build directory */tmp/bitbox-convertion/*:
```
bitwig-studio-5.3.2  bitwig-studio-5.3.2-2.x86_64.rpm  bitwig-studio-5.3.2.deb  rpm_bitwig-studio-5.3.2.log  rpm_bitwig.log  scripts
```
*Usage*


