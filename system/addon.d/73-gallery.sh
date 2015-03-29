#!/sbin/sh
# 
# /system/addon.d/73-gallery.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/Gallery2/lib/arm/libjni_eglfence.so
app/Gallery2/lib/arm/libjni_filtershow_filters.so
app/Gallery2/lib/arm/libjni_jpegstream.so
app/Gallery2/lib/arm/librsjni.so
app/Gallery2/Gallery2.apk
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/$FILE
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    # Stub
  ;;
esac
