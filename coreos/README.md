Commands to use systemd to start website container at init
* sudo wget https://raw.githubusercontent.com/debonairio/website/master/coreos/debonair.io.website.service
* sudo systemctl enable /etc/systemd/system/debonair.io.website.service
* sudo systemctl start debonair.io.website.service

Commands to use systemd to start watchtower container at init
* sudo wget https://raw.githubusercontent.com/debonairio/website/master/coreos/centurylink.watchtower.service
* sudo systemctl enable /etc/systemd/system/centurylink.watchtower.service
* sudo systemctl start centurylink.watchtower.service
