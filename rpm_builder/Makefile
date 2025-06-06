all:

download:
	mkdir -p /tmp/bitbox-convertion/scripts/
	wget https://www.bitwig.com/dl/Bitwig%20Studio/5.3.2/installer_linux/ -O /tmp/bitbox-convertion/bitwig-studio-5.3.2.deb

install-development-dependecies-debian:
	sudo apt install alien

install-development-dependecies-fedora:
	sudo dnf5 install -y alien

build: download
	mkdir -p /tmp/bitbox-convertion/scripts/
	echo '[Preparing] scripts ==> /tmp/bitbox-convertion/'
	cp deb2rpm.sh /tmp/bitbox-convertion/
	cp -r scripts/* /tmp/bitbox-convertion/scripts/
	echo '[Entering] <==> /tmp/bitbox-convertion/'
	echo '[Extracting] + [Converting] ==> Bitwig'
	cd /tmp/bitbox-convertion/; bash deb2rpm.sh bitwig-studio-5.3.2.deb; cd -;
	echo 'DONE'; ls /tmp/bitbox-convertion/;
clean:
	sudo rm -f /tmp/bitbox-convertion/deb2rpm.sh
	sudo rm -rf /tmp/bitbox-convertion/scripts/

