
# Network {{{

function _list_wifi_device() {
  # -A2 means grep nclude after 2 lines, -o print only the matching part of lines
  en=$(networksetup -listallhardwareports | grep -A2 'Wi-Fi' | grep -o 'en[0-9]') #networksetup='networksetup'; port=$(getWiFiDevice)
  echo $en # return the grepped value
}
alias list_wifi_device=_list_wifi_device

# arguments
# $1 ssid
# $2 pwd
function _connect_wifi() {
  ssid=$1 # declare a variable named ssid of argument 1
  pwd=$2  # declare a variable named pwd of argument 2
  echo "connecting to Wi-Fi: $1..."
  networksetup -setairportnetwork $(_list_wifi_device) $ssid $pwd
}
alias con_wifi=_connect_wifi

function _connect_hotspot_stan() {
  connect_wifi Stan 88888888 #networksetup -setairportnetwork $(getWiFiDevice) Stan 88888888
}
alias hsts=_connect_hotspot_stan

function _toggle_wifi() {
  echo "Which network do you wanna join?"
  select hotspot in "NBFLEX" "AIR190" "Stan" "Cancel"; do
    case $hotspot in
      'NBFLEX' )
        _connect_wifi NBFLEX newHIGH2020
        break;; # 每個結尾使用連續兩個分號來處理
      'AIR190' )
        _connect_wifi AIR190
        break;;
      'Stan' )
        _connect_hotspot_stan
        break;;
    'Cancel' )
        break;;
    esac
  done
}
alias t_wifi=_toggle_wifi

# }}}

