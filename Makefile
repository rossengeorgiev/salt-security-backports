install:
	wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/archive/${SALTVER}/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
	echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/archive/${SALTVER} xenial main" | sudo tee -a /etc/apt/sources.list.d/saltstack.list
	sudo apt-get update
	sudo apt-get install salt-master patch

patch:
	sudo patch -p2 -d /usr/lib/python2.7/dist-packages/salt < ${SALTVER}_CVE-2020-11651.patch
	sudo patch -p2 -d /usr/lib/python2.7/dist-packages/salt < ${SALTVER}_CVE-2020-11652.patch

test:
	sudo systemctl restart salt-master; sleep 15
	sudo python salt-cve-check.py
