#!/bin/bash
source $PANEL_HOME/panel.cfg

pull() {
    buf="song$cmd_ifs"
    infos=`mpc`
    case `awk 'NR==2 { print $1 }' <<< "$infos" | tr -d '[]'` in
        playing)
            buf="$buf$fmt_song_playing"
            ico="$ico_song_playing"
            txt="$(head -1 <<< "$infos") "
            ;;
        paused)
            buf="$buf$fmt_song_paused"
            ico="$ico_song_paused"
            txt="$(head -1 <<< "$infos") "
            ;;
        *)
            buf="$buf$fmt_song_stopped"
            ico="$ico_song_stopped"
            txt=""
            ;;
    esac
    echo "$buf $ico $txt"
}

pull
mpc idleloop | while read; do
    pull
done
