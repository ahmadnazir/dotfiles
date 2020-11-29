# Usage:
# rdp-vm-saw home
function rdp-vm-saw () {
    case "$1" in
        home)
            IP=`cat /etc/hosts | grep ahraja-saw-vm$ | awk '{printf $1}'`
            ;;
        work)
            # TODO: update this to get the IP dynamically from /etc/hosts
            IP="?????????????"
            ;;
        *)
            echo $"Usage: $0 {home|work}"
            exit 1
    esac


    if [ -z $SAW_VM_PWD ]; then
        read -s "?Password:"
        echo
        SAW_VM_PW=$REPLY
    fi


    # When using xfreerdp, sometime I disconnect and I have to keep retrying
    # until I connect. Don't know why it is happening so I'll keep trying with
    # different switches to see if it makes any difference

    # Without additional switches
    #
    # xfreerdp  /monitors:1 /f /u:'Administrator' /v:$IP /p:$SAW_VM_PWD /cert-ignore -sec-nla

    # tls / but it shouldn't make a difference (I think)
    #
    xfreerdp  /monitors:1 /f /u:'Administrator' /v:$IP /p:$SAW_VM_PWD /cert-ignore -sec-nla /sec:tls

    # Trying with timeout - doesn't seem to work
    #
    # xfreerdp  /monitors:1 /f /u:'Administrator' /v:$IP /p:$SAW_VM_PWD /cert-ignore -sec-nla /timeout:60000

    # Extra gfx options - don't fix the problem
    #
    # xfreerdp  /monitors:1 /f /u:'Administrator' /v:$IP /p:$SAW_VM_PWD /cert-ignore -sec-nla \
    #     /gfx /rfx /network:auto

}

function rdp-test () {
    read -s "?Password:"
    echo
    local ip="ahraja-vm-saw"
    xfreerdp  /monitors:1 /f /u:'Administrator' /v:$ip /p:$SAW_VM_PWD
}

# Usage: rdp [domain]
# e.g. rdp microsoft.com
function rdp () {

  local domain=$1
  local user=$(lpass show $domain --username)
  echo $user
  local password=$(lpass show $domain --password)
  local url=$(lpass show $domain --url | awk -F 'http://' '{print $2}')
  echo $url

  xfreerdp /monitors:1 /f         \
           /u:"$user" \
           /v:"$url"  \
           /p:"$password"


  # xfreerdp --no-nla                           \
  #     -grab-keyboard                          \
  #     /f                                      \
  #     +fonts                                  \
  #     /aero                                   \
  #     /window-drag                            \
  #     /scale:250                              \
  #     /smart-sizing                           \
  #     /menu-anims                             \
  #     /bpp:32                                 \
  #     /gdi:sw                                 \
  #     /gfx                                    \
  #     /gfx-progressive                        \
  #     /clipboard                              \
  #     /cert-ignore                            \
  #     /auto-reconnect                         \
  #     /auto-reconnect-max-retries:3           \
  #     /u:"$user"                              \
  #     /v:"$url"                               \
  #     /p:"$password"

  # #    /d:"$domain"                            \
}
