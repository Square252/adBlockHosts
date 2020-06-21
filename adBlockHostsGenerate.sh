#!/bin/sh
export LC_ALL=de_DE
ADAWAYRAW=`mktemp`
ADAWAYCLEAN=`mktemp`
DATE=$(date +'%d.%m.%Y-%H:%M:%S:%N')

# TODO: Add handling for domain lists (without ip)
# e.g.: 	https://phishing.army/download/phishing_army_blocklist_extended.txt

LISTS='http://someonewhocares.org/hosts/hosts
	http://winhelp2002.mvps.org/hosts.txt
	https://adaway.org/hosts.txt
	https://hosts-file.net/ad_servers.txt
	https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&mimetype=plaintext&useip=0.0.0.0
	https://raw.githubusercontent.com/AdAway/adaway.github.io/master/hosts.txt
	https://raw.githubusercontent.com/azet12/KADhosts/master/KADhosts.txt
	https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts
	https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Dead/hosts
	https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts
	https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts
	https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts
	https://raw.githubusercontent.com/mitchellkrogza/Badd-Boyz-Hosts/master/hosts
	https://raw.githubusercontent.com/tyzbit/hosts/master/data/tyzbit/hosts
	https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt
	https://www.malwaredomainlist.com/hostslist/hosts.txt
    http://sysctl.org/cameleon/hosts'

for list in $LISTS; do
	echo [$(date +'%d.%m.%Y-%H:%M:%S:%N')] Loading list: $list
	curl -s -S -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36" $list >> $ADAWAYRAW
done

echo [$(date +'%d.%m.%Y-%H:%M:%S:%N')] Replace 127.0.0.1 with 0.0.0.0
sed -i 's/127.0.0.1/0.0.0.0/' $ADAWAYRAW

echo [$(date +'%d.%m.%Y-%H:%M:%S:%N')] Removing comments and empty lines
sed -i -e 's/#.*$//' -e '/^$/d' $ADAWAYRAW

echo [$(date +'%d.%m.%Y-%H:%M:%S:%N')] Creating clean hosts
echo \# Generated $(date +'%d.%m.%Y-%H:%M:%S:%N') > $ADAWAYCLEAN
echo [$(date +'%d.%m.%Y-%H:%M:%S:%N')] Sorting and removing dupes
cat $ADAWAYRAW | sed -e "s/[[:space:]]\+/ /g" | sed -e 's/[[:blank:]]*$//' | sort -u | uniq >> $ADAWAYCLEAN

echo [$(date +'%d.%m.%Y-%H:%M:%S:%N')] Removing invalid entries
sed -i -e 's/0.0.0.0$//' $ADAWAYCLEAN

rm $ADAWAYRAW

echo [$(date +'%d.%m.%Y-%H:%M:%S:%N')] Adding custom entries
echo \#\#\# BEGIN CUSTOM ENTRY BLOCK \#\#\# >> $ADAWAYCLEAN
echo 127.0.0.1 localhost >> $ADAWAYCLEAN
echo \#\#\# END CUSTOM ENTRY BLOCK \#\#\# >> $ADAWAYCLEAN
echo \#\#\# END GENERATED HOSTS \#\#\# >> $ADAWAYCLEAN

echo [$(date +'%d.%m.%Y-%H:%M:%S:%N')]  Move file to /var/www and change permissions
mv $ADAWAYCLEAN /var/www/hosts.txt
chown www-data:www-data /var/www/hosts.txt

echo [$(date +'%d.%m.%Y-%H:%M:%S:%N')]  Generating unbound zone file...
rm -f /var/www/hosts-unbound-zones.txt
cat /var/www/hosts.txt | grep '^0\.0\.0\.0' | awk '{print "local-zone: \""$2"\" redirect\nlocal-data: \""$2" A 0.0.0.0\""}' >> /var/www/hosts-unbound-zones.txt
chown www-data:www-data /var/www/hosts-unbound-zones.txt

echo [$(date +'%d.%m.%Y-%H:%M:%S:%N')] Done.
