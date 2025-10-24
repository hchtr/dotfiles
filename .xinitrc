if [ -f ~/.fehbg ]; then
    . ~/.fehbg
fi

xrdb -merge .Xresources

exec i3
