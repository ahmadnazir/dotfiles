# Usage: rdp [domain]
# e.g. rdp microsoft.com
function rdp () {

  local domain=$1
  local user=$(lpass show $domain --username)
  local password=$(lpass show $domain --password)
  local url=$(lpass show $domain --url | awk -F 'http://' '{print $2}')

  xfreerdp --no-nla                           \
      -grab-keyboard                          \
      /f                                      \
      /fonts                                  \
      /aero                                   \
      /window-drag                            \
      /scale:180                              \
      /smart-sizing                           \
      /menu-anims                             \
      /bpp:32                                 \
      /gdi:sw                                 \
      /gfx                                    \
      /gfx-progressive                        \
      /clipboard                              \
      /cert-ignore                            \
      /auto-reconnect                         \
      /auto-reconnect-max-retries:3           \
      /u:"$user"                              \
      /v:"$url"                               \
      /p:"$password"

  #    /d:"$domain"                            \
}
