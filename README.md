# adBlocking Hosts

[![Hosts online](https://img.shields.io/website-up-down-green-red/https/0xfc.de/hosts.txt.svg)](https://0xfc.de/hosts.txt)

The script in this repository consolidates several sources of ad and malware related hosts files and merges them into a unified hosts file.

The resulting hosts file is available under the following URL:

### [https://0xfc.de/hosts.txt](https://0xfc.de/hosts.txt)

The file gets regenerated daily and is suitable for use in [PiHole](https://pi-hole.net/) or [AdAway](https://adaway.org/) for example.

# Usage
```
./adBlockHostsGenerate.sh
```
The resulting file is saved under `/var/www/html/hosts.txt`

### Requirementes

Depends on `idn2`

# Currently included source lists:
```
https://adaway.org/hosts.txt
https://blocklistproject.github.io/Lists/ads.txt
https://blocklistproject.github.io/Lists/phishing.txt
https://blocklistproject.github.io/Lists/tracking.txt
https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&mimetype=plaintext&useip=0.0.0.0
https://raw.githubusercontent.com/AdAway/adaway.github.io/master/hosts.txt
https://raw.githubusercontent.com/azet12/KADhosts/master/KADhosts.txt
https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts
https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Dead/hosts
https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts
https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts
https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts
https://raw.githubusercontent.com/mitchellkrogza/Badd-Boyz-Hosts/master/hosts
https://raw.githubusercontent.com/notracking/hosts-blocklists/master/hostnames.txt
https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
https://reddestdream.github.io/Projects/MinimalHosts/etc/MinimalHostsBlocker/minimalhosts
https://someonewhocares.org/hosts/hosts
https://winhelp2002.mvps.org/hosts.txt
https://www.github.developerdan.com/hosts/lists/ads-and-tracking-extended.txt'

```
