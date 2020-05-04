
⚠⚠  **APPLY THESE PATCHES AT YOUR OWN RISK** ⚠⚠

# Backported security patches for unspported salt versions

Patches in this repo address the following CVEs:

* CVE-2020-11651 & CVE-2020-11652 - https://labs.f-secure.com/advisories/saltstack-authorization-bypass

Bugfixes:

* fix typo `_minion_runner` -> `minion_runner`. See: https://docs.saltstack.com/en/latest/topics/releases/3000.2.html#known-issue
* fix type `_find_file_and_stat` -> `_find_hash_and_stat`. See https://github.com/rossengeorgiev/salt-security-backports/issues/1

# Check if your salt-master is vulnerable

Check script needs to be ran locally on your salt-master as `root`

```bash
python salt-cve-check.py
```

Example output for Salt 2017.7.8:

```bash
[+] Salt version: 2017.7.8
[ ] This version of salt is vulnerable! Check results below
[+] Checking salt-master (127.0.0.1:4506) status... ONLINE
[+] Checking if vulnerable to CVE-2020-11651... YES
[+] Checking if vulnerable to CVE-2020-11652 (read_token)... YES
[+] Checking if vulnerable to CVE-2020-11652 (read)... YES
[+] Checking if vulnerable to CVE-2020-11652 (write1)... YES
[+] Checking if vulnerable to CVE-2020-11652 (write2)... YES
```

# Applying the patches

```bash
# locate the salt package directory (use python3 if necessary)

python -c "import imp; print(imp.find_module('salt')[1])"

# in my case: /usr/lib/python2.7/dist-packages/salt
# apply patches
# (adding -b flag will backup file before modifications at same path with .orig suffix)
# (patch can be reversed running the same command with -R flag)

patch -p2 -d /usr/lib/python2.7/dist-packages/salt < 2017.7.8_CVE-2020-11651.patch
patch -p2 -d /usr/lib/python2.7/dist-packages/salt < 2017.7.8_CVE-2020-11652.patch

# restart salt-master

systemctl restart salt-master
# or
service salt-master restart
```

Rerun the check script:

```bash
user@salt # python salt-cve-check.py
[+] Salt version: 2017.7.8
[ ] This version of salt is vulnerable! Check results below
[+] Checking salt-master (127.0.0.1:4506) status... ONLINE
[+] Checking if vulnerable to CVE-2020-11651... NO
[+] Checking if vulnerable to CVE-2020-11652 (read_token)... NO
[+] Checking if vulnerable to CVE-2020-11652 (read)... NO
[+] Checking if vulnerable to CVE-2020-11652 (write1)... NO
[+] Checking if vulnerable to CVE-2020-11652 (write2)... NO
```
