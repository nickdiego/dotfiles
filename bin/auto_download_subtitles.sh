#!/bin/bash
VERSION="0.2"
function show_help_txt {
  THISPROG=$(basename $0)
  echo " $THISPROG v$VERSION (license GPLv3)"
  echo ""
  echo " DESCRIPTION:"
  echo "    Automatically download portuguese subtitles to all videos of directory <MOVIES_DIR>"
  echo '    If <MOVIES_DIR> is not given, but the Transmission environment variables $TR_TORRENT_DIR, $TR_TORRENT_NAME are'
  echo '    defined, then it will consider MOVIES_DIR=$TR_TORRENT_DIR/$TR_TORRENT_NAME'
  echo ""
  echo " USAGE:"
  echo "    $THISPROG <MOVIES_DIR>"
  echo "    $THISPROG (with environment variables "'$TR_TORRENT_DIR, $TR_TORRENT_NAME)'
  echo ""
  echo " EXAMPLE:"
  echo "    $THISPROG /datas/movies/ink"
  echo ""
}

env > /tmp/env.tmp

#Args check
if [ "$1" ]; then
  # Argument given: <MOVIES_DIR>
  MOVIES_DIR="$1"
  [ -d "$MOVIES_DIR" ] || { echo "Error: '$MOVIES_DIR' not a directory?!?"; exit 1; }
elif [ -n "$TR_TORRENT_DIR" -a -n "$TR_TORRENT_NAME" ]; then
  # No argument given, but we have found Transmission environment variables
  MOVIES_DIR="$TR_TORRENT_DIR/$TR_TORRENT_NAME"
else
  # Neither argument, nor environment variables
  show_help_txt; exit 1
fi

# Download subtitles
  # Language of the subtitles - only info I found about filebot languages was this: http://filebot.sourceforge.net/cli.html
  #LANGUAGE_CODE="en"
  #LANGUAGE_CODE="de"
  #LANGUAGE_CODE="fr"
  LANGUAGE_CODE="pt"
  #LANGUAGE_CODE="ja"
  #LANGUAGE_CODE="zh"

echo -ne "diegoyam\n123mudar" | filebot -script fn:configure
filebot -script fn:suball --output srt --lang $LANGUAGE_CODE "$MOVIES_DIR" \
  -non-strict --def maxAgeDays=30
exit $?
