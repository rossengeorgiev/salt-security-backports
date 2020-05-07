
SALTREPO ?= apt
PYEXEC ?= python

install:
	wget -O - https://repo.saltstack.com/${SALTREPO}/ubuntu/16.04/amd64/archive/${SALTVER}/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
	echo "deb http://repo.saltstack.com/${SALTREPO}/ubuntu/16.04/amd64/archive/${SALTVER} xenial main" | sudo tee -a /etc/apt/sources.list.d/saltstack.list
	sudo apt-get update
	sudo apt-get install salt-master patch

patch:
	sudo patch -p2 -d `${PYEXEC} -c "import imp; print(imp.find_module('salt')[1])"` < ${SALTVER}_CVE-2020-11651.patch
	sudo patch -p2 -d `${PYEXEC} -c "import imp; print(imp.find_module('salt')[1])"` < ${SALTVER}_CVE-2020-11652.patch

test:
	sudo systemctl restart salt-master; sleep 15
	sudo ${PYEXEC} salt-cve-check.py ${CHKPARAM}

