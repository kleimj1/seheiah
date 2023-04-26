# check-seheiahd-status.sh
# checks, if seheiahd is running
# you shuould run it in cronjob:
# */2 * * * * /bin/bash --login PATH_TO_SEHEIAH/check-seheihad-status.sh
#!/bin/bash

PATH_TO_SEHEIAH="/home/falko/seheiah"

if [ `ps -e | grep -c "seheiahd.py"` -eq 0 ]
then
	echo "Daemon ist gestorben" | /usr/bin/mail -s "Daemon ist tot" f.benthin@jpberlin.de
	sleep 10
	mpg321 -o alsa -a hw:0,0 $PATH_TO_SEHEIAH/audiofiles/de_seheiahd_isnt_running.mp3
	cd $PATH_TO_SEHEIAH/program/
	killall gstSphinxCli.py
	sudo ./seheiahd.py start &
	sleep 10
fi

if [ `ps -e | grep -c "gstSphinxCli.py"` -eq 0 ]
then
        echo "PocketSphinx ist gestorben" | /usr/bin/mail -s "Daemon ist tot" f.benthin@jpberlin.de
        sleep 10
        mpg321 -o alsa -a hw:0,0 $PATH_TO_SEHEIAH/audiofiles/de_seheiahd_isnt_running.mp3
        cd $PATH_TO_SEHEIAH/program/
        ./gstSphinxCli.py &
fi

exit 0
