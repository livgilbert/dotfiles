#!/bin/bash

run_lock() {

#scrot -o /tmp/screen.png
#convert /tmp/screen.png -scale 10% -scale 1000%  -fill "#2E3440" -colorize 60% /tmp/screen.png

i3lock -e \
-n \
-c 2E344060 \
--force-clock \
--indicator \
--ring-width 24 \
--radius 40 \
--ind-pos w-128+x:h-128 \
\
--insidever-color=FFFFFF00     \
--ringver-color=A3BE8C   \
\
--insidewrong-color=FFFFFF00   \
--ringwrong-color=BF616AFF     \
\
--inside-color=00000000        \
--ring-color=88C0D0        \
--line-color=00000000          \
--separator-color=2E344000   \
\
--verif-color=ECEEF4          \
--wrong-color=ECEEF4          \
--layout-color=ECEEF4       \
--keyhl-color=4C566A        \
--bshl-color=D8DEE9       \
\
--verif-text="" \
--wrong-text="" \
--noinput-text="" \
--lock-text="" \
\
--time-font="Noto Sans Display Light" \
--time-align=1 \
--time-size=96 \
--time-color=ECEEF4FF           \
--time-str=%H:%M:%S \
--time-pos=x+50:y+h-140 \
\
--date-font="Noto Sans Display Light" \
--date-align=1 \
--date-size=36 \
--date-color=ECEEF4FF           \
--date-str="%a %Y-%m-%d" \
--date-pos=x+64:h-64 \
\
--pass-media \
--pass-screen \
--pass-power \
--pass-volume \
--redraw-thread 
}

pre_lock() {
    return
}

post_lock() {
    return
}

pre_lock

if [[ -e /dev/fd/${XSS_SLEEP_LOCK_FD:--1} ]]; then
    kill_i3lock() {
        pkill -xu $EUID "$@" i3lock
    }

    trap kill_i3lock TERM INT

    run_lock

    exec ${XSS_SLEEP_LOCK_FD}<&-

    while kill_i3lock -0; do
        sleep 0.5
    done
else
    trap 'kill %%' TERM INT
    run_lock &
    wait
fi

post_lock
