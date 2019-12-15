# Usage: rdp [domain]
# e.g. rdp microsoft.com
function rdp () {

  local domain=$1
  local user=$(lpass show $domain --username)
  local password=$(lpass show $domain --password)
  local url=$(lpass show $domain --url | awk -F 'http://' '{print $2}')

  xfreerdp /f         \
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


function test-test-tes () {
    # xfreerdp --no-nla                           \
        #          -grab-keyboard                          \
        #          /f                                      \
        #          +fonts                                  \
        #          /aero                                   \
        #          /window-drag                            \
        #          /scale:250                              \
        #          /u:ahraja@microsoft.com                              \
        #          /v:"$url"                               \
        #          /p:"$password"


    # xfreerdp /scale:250 /v:10.60.22.7 /u:ahraja /d:EUROPE # Boot Camp
}
