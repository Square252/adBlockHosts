#!/bin/sh
ADAWAYRAW="$(mktemp)"
ADAWAYCLEAN="$(mktemp)"

# TODO: Add handling for domain lists (without ip)
# e.g.: https://phishing.army/download/phishing_army_blocklist_extended.txt
# e.g.: https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt

LISTS='https://blocklistproject.github.io/Lists/ads.txt
        https://www.github.developerdan.com/hosts/lists/ads-and-tracking-extended.txt
	https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
	https://raw.githubusercontent.com/mitchellkrogza/Badd-Boyz-Hosts/master/hosts
	https://raw.githubusercontent.com/notracking/hosts-blocklists/master/hostnames.txt
	https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts
	https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts
	https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts
	https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Dead/hosts
	https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts
	https://raw.githubusercontent.com/azet12/KADhosts/master/KADhosts.txt
	https://raw.githubusercontent.com/AdAway/adaway.github.io/master/hosts.txt
	https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&mimetype=plaintext&useip=0.0.0.0
	https://adaway.org/hosts.txt
	https://winhelp2002.mvps.org/hosts.txt
	https://someonewhocares.org/hosts/hosts'

for list in $LISTS; do
	echo ["$(date +'%d.%m.%Y-%H:%M:%S:%N')"] Loading list: "$list"
	curl -s -f -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36" "$list" >> "$ADAWAYRAW"
done

echo ["$(date +'%d.%m.%Y-%H:%M:%S:%N')"] Replace 127.0.0.1 with 0.0.0.0
sed -i 's/127.0.0.1/0.0.0.0/' "$ADAWAYRAW"

echo ["$(date +'%d.%m.%Y-%H:%M:%S:%N')"] Removing comments and empty lines
sed -i -e 's/#.*$//' -e '/^$/d' "$ADAWAYRAW"


echo ["$(date +'%d.%m.%Y-%H:%M:%S:%N')"] Sorting and removing dupes
sed -i -e "s/[[:space:]]\+/ /g" "$ADAWAYRAW"
sed -i -e 's/[[:blank:]]*$//' "$ADAWAYRAW"

echo ["$(date +'%d.%m.%Y-%H:%M:%S:%N')"] Creating clean hosts
echo \# Script used to generate this file is available here: https://github.com/Square252/adBlockHosts > "$ADAWAYCLEAN"
echo \# Generated on "$(date +'%d.%m.%Y-%H:%M:%S:%N')" // "$(date)" > "$ADAWAYCLEAN"
echo \# Source Lists: >> "$ADAWAYCLEAN"
for list in $LISTS; do
	echo \# - "$list" >> "$ADAWAYCLEAN"
done
sort -u "$ADAWAYRAW" | uniq >> "$ADAWAYCLEAN"

echo ["$(date +'%d.%m.%Y-%H:%M:%S:%N')"] Removing invalid entries
sed -i 's/^0.0.0.0 0.0.0.0$//' "$ADAWAYCLEAN"
sed -i 's/^0.0.0.0 $//' "$ADAWAYCLEAN"
sed -i 's/^0.0.0.0$//' "$ADAWAYCLEAN"

rm "$ADAWAYRAW"

echo ["$(date +'%d.%m.%Y-%H:%M:%S:%N')"] Adding custom entries
{
	echo \#\#\# BEGIN CUSTOM ENTRY BLOCK \#\#\#
	echo 127.0.0.1 localhost
	echo \#\#\# END CUSTOM ENTRY BLOCK \#\#\#
} >> "$ADAWAYCLEAN"

echo ["$(date +'%d.%m.%Y-%H:%M:%S:%N')"]  Move file to /var/www/html and change permissions
mv "$ADAWAYCLEAN" /var/www/html/hosts.txt
chown www-data:www-data /var/www/html/hosts.txt

echo ["$(date +'%d.%m.%Y-%H:%M:%S:%N')"]  Generating unbound zone file...
rm -f /var/www/html/hosts-unbound-zones.txt
grep '^0\.0\.0\.0' /var/www/html/hosts.txt | awk '{print "local-zone: \""$2"\" redirect\nlocal-data: \""$2" A 0.0.0.0\""}' >> /var/www/html/hosts-unbound-zones.txt
chown www-data:www-data /var/www/html/hosts-unbound-zones.txt

echo ["$(date +'%d.%m.%Y-%H:%M:%S:%N')"] Done.
