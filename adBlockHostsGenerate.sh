#!/bin/sh
export LC_ALL=de_DE
ADAWAYRAW=`mktemp`
ADAWAYCLEAN=`mktemp`
DATE=$(date +'%d.%m.%Y-%H:%M:%S:%N')

LISTS='http://someonewhocares.org/hosts/hosts 
	http://hosts-file.net/ad_servers.txt 
	http://winhelp2002.mvps.org/hosts.txt 
	https://adaway.org/hosts.txt
	https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts
	https://raw.githubusercontent.com/AdAway/adaway.github.io/master/hosts.txt
	https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts
	https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Dead/hosts
	https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts
	https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts
	https://raw.githubusercontent.com/mitchellkrogza/Badd-Boyz-Hosts/master/hosts
	https://raw.githubusercontent.com/azet12/KADhosts/master/KADhosts.txt
	https://www.malwaredomainlist.com/hostslist/hosts.txt
	https://raw.githubusercontent.com/FadeMind/hosts.extras/master/SpotifyAds/hosts
	https://raw.githubusercontent.com/tyzbit/hosts/master/data/tyzbit/hosts
	https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&mimetype=plaintext&useip=0.0.0.0'

for list in $LISTS; do
	echo [$(date +'%d.%m.%Y-%H:%M:%S:%N')] Loading list: $list
	curl -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36" $list >> $ADAWAYRAW
done

echo [$(date +'%d.%m.%Y-%H:%M:%S:%N')] Replace 127.0.0.1 with 0.0.0.0
sed -i 's/127.0.0.1/0.0.0.0/' $ADAWAYRAW

echo [$(date +'%d.%m.%Y-%H:%M:%S:%N')] Removing comments and empty lines
sed -i -e 's/#.*$//' -e '/^$/d' $ADAWAYRAW

echo [$(date +'%d.%m.%Y-%H:%M:%S:%N')] Creating clean hosts
echo \# Generated $(date +'%d.%m.%Y-%H:%M:%S:%N') > $ADAWAYCLEAN
echo [$(date +'%d.%m.%Y-%H:%M:%S:%N')] Sorting and removing dupes
cat $ADAWAYRAW | sed -e "s/[[:space:]]\+/ /g" | sort -u | uniq >> $ADAWAYCLEAN

rm $ADAWAYRAW

echo [$(date +'%d.%m.%Y-%H:%M:%S:%N')] Adding custom entries
echo \#\#\# BEGIN CUSTOM ENTRY BLOCK \#\#\# >> $ADAWAYCLEAN
# noc
# echo 217.28.97.70 noc.leitwerk.net noc >> $ADAWAYCLEAN
# Microsoft Spyware server
echo 127.0.0.1 localhost >> $ADAWAYCLEAN
echo 0.0.0.0 a-0001.a-msedge.net >> $ADAWAYCLEAN
echo 0.0.0.0 a.ads1.msn.com >> $ADAWAYCLEAN
echo 0.0.0.0 a.ads2.msn.com >> $ADAWAYCLEAN
echo 0.0.0.0 ad.doubleclick.net >> $ADAWAYCLEAN
echo 0.0.0.0 adnexus.net >> $ADAWAYCLEAN
echo 0.0.0.0 adnxs.com >> $ADAWAYCLEAN
echo 0.0.0.0 ads.msn.com >> $ADAWAYCLEAN
echo 0.0.0.0 ads1.msads.net >> $ADAWAYCLEAN
echo 0.0.0.0 ads1.msn.com >> $ADAWAYCLEAN
echo 0.0.0.0 az361816.vo.msecnd.net >> $ADAWAYCLEAN
echo 0.0.0.0 az512334.vo.msecnd.net >> $ADAWAYCLEAN
echo 0.0.0.0 choice.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 choice.microsoft.com.nsatc.net >> $ADAWAYCLEAN
echo 0.0.0.0 compatexchange.cloudapp.net >> $ADAWAYCLEAN
echo 0.0.0.0 corp.sts.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 corpext.msitadfs.glbdns2.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 cs1.wpc.v0cdn.net >> $ADAWAYCLEAN
echo 0.0.0.0 dc.services.visualstudio.com >> $ADAWAYCLEAN
echo 0.0.0.0 df.telemetry.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 diagnostics.support.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 download-ssl.msgamestudios.com >> $ADAWAYCLEAN
echo 0.0.0.0 dt.adsafeprotected.com >> $ADAWAYCLEAN
echo 0.0.0.0 fe2.update.microsoft.com.akadns.net >> $ADAWAYCLEAN
echo 0.0.0.0 feedback.microsoft-hohm.com >> $ADAWAYCLEAN
echo 0.0.0.0 feedback.search.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 feedback.windows.com >> $ADAWAYCLEAN
echo 0.0.0.0 fw.adsafeprotected.com >> $ADAWAYCLEAN
echo 0.0.0.0 go.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 googleads4.g.doubleclick.net >> $ADAWAYCLEAN
echo 0.0.0.0 i1.services.social.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 i1.services.social.microsoft.com.nsatc.net >> $ADAWAYCLEAN
echo 0.0.0.0 licensing.md.mp.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 mobileads.msn.com >> $ADAWAYCLEAN
echo 0.0.0.0 mpd.mxptint.net >> $ADAWAYCLEAN
echo 0.0.0.0 mscrl.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 oca.telemetry.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 oca.telemetry.microsoft.com.nsatc.net >> $ADAWAYCLEAN
echo 0.0.0.0 ocsp.usertrust.com >> $ADAWAYCLEAN
echo 0.0.0.0 pre.footprintpredict.com >> $ADAWAYCLEAN
echo 0.0.0.0 preview.msn.com >> $ADAWAYCLEAN
echo 0.0.0.0 rad.msn.com >> $ADAWAYCLEAN
echo 0.0.0.0 redir.metaservices.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 reports.wes.df.telemetry.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 sc.iasds01.com >> $ADAWAYCLEAN
echo 0.0.0.0 services.wes.df.telemetry.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 settings-sandbox.data.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 sls.update.microsoft.com.akadns.net >> $ADAWAYCLEAN
echo 0.0.0.0 sm.mcafee.com >> $ADAWAYCLEAN
echo 0.0.0.0 solitaireprod.maelstrom.xboxlive.com >> $ADAWAYCLEAN
echo 0.0.0.0 sqm.df.telemetry.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 sqm.telemetry.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 sqm.telemetry.microsoft.com.nsatc.net >> $ADAWAYCLEAN
echo 0.0.0.0 statsfe1.ws.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 statsfe2.update.microsoft.com.akadns.net >> $ADAWAYCLEAN
echo 0.0.0.0 statsfe2.ws.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 storeedgefd.dsx.mp.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 su3.mcafee.com >> $ADAWAYCLEAN
echo 0.0.0.0 survey.watson.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 telecommand.telemetry.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 telecommand.telemetry.microsoft.com.nsatc.net >> $ADAWAYCLEAN
echo 0.0.0.0 telemetry.appex.bing.net >> $ADAWAYCLEAN
echo 0.0.0.0 telemetry.appex.bing.net:443 >> $ADAWAYCLEAN
echo 0.0.0.0 telemetry.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 telemetry.urs.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 tunnel.cfw.trustedsource.org >> $ADAWAYCLEAN
echo 0.0.0.0 updatekeepalive.mcafee.com >> $ADAWAYCLEAN
echo 0.0.0.0 vortex-sandbox.data.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 vortex-win.data.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 vortex.data.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 watson.live.com >> $ADAWAYCLEAN
echo 0.0.0.0 watson.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 watson.ppe.telemetry.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 watson.telemetry.microsoft.com >> $ADAWAYCLEAN
echo 0.0.0.0 watson.telemetry.microsoft.com.nsatc.net >> $ADAWAYCLEAN
echo 0.0.0.0 wes.df.telemetry.microsoft.com >> $ADAWAYCLEAN
echo \#\#\# END OF GENERATED HOSTS \#\#\# >> $ADAWAYCLEAN

echo [$(date +'%d.%m.%Y-%H:%M:%S:%N')]  Move file to /var/www and change permissions
sudo mv $ADAWAYCLEAN /var/www/hosts.txt
chown www-data:www-data /var/www/hosts.txt 

echo [$(date +'%d.%m.%Y-%H:%M:%S:%N')] Done.
