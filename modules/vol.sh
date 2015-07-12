#!/bin/bash
source $PANEL_HOME/panel.cfg
if which amixer ; then
    while true ; do
        volinfo=$(amixer get Master | tail -1)
        buf="vol$cmd_ifs"
        if grep -wq on <<< "$volinfo" ; then
            buf="$buf$fmt_vol %{A:amixer set Master mute:}$ico_vol%{A} "
            echo "$buf$(awk '{ print $4 }' <<< "$volinfo" | tr -d '[]') "
        else
            echo "$buf$fmt_vol_muted %{A:amixer set Master unmute:}$ico_vol_muted%{A} "
        fi

        sleep 1
    done
else
    exit 1
fi
