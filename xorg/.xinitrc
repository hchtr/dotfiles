if [ -f ~/.fehbg ]; then
    . ~/.fehbg
fi

picom -b &

idesk &

exec i3
