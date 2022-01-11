style_heading1=$(tput bold)$(tput setaf 4)
style_heading2=$(tput setaf 4)
style_heading3=$(tput bold)
style_info=$(tput setaf 3)
style_error=$(tput bold)$(tput setaf 1)
style_reset=$(tput sgr0)

function text-h1()
{
    echo
    echo "$style_heading1 [ $@ ] $style_reset"
    echo
}

function text-h2()
{
    echo
    echo "$style_heading2 $1 $style_reset"
    echo
}

function text-h3()
{
    echo
    echo "$style_heading3 $1 $style_reset"
    echo
}

function text-info()
{
    echo
    echo "$style_info $1 $style_reset"
    echo
}

function text-error()
{
    echo
    echo "$style_error $1 $style_reset"
    echo
}
