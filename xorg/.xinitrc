if [ -f ~/.fehbg ]; then
    . ~/.fehbg
fi

picom -b &

exec i3
