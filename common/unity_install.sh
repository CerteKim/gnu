ui_print "   Extracting files..."
mkdir -p $TMPDIR/system/bin
tar -xf $TMPDIR/$ARCH.tar.xz -C $TMPDIR 2>/dev/null
mv -f $TMPDIR/$ARCH/* $TMPDIR/system/bin
if [ -f $ORIGDIR/system/etc/mkshrc ]; then
  cp_ch -i $ORIGDIR/system/etc/mkshrc $UNITY/system/etc/mkshrc
  [ ! "$(grep '/sdcard/.aliases' $ORIGDIR/system/etc/mkshrc)" ] && echo 'source /sdcard/.aliases' >> $UNITY/system/etc/mkshrc
else
  mktouch $UNITY/system/etc/mkshrc
  echo 'source /sdcard/.aliases' >> $UNITY/system/etc/mkshrc
  echo "/system/etc/mkshrc" >> $INFO
fi
if ! $MAGISK || $SYSOVER; then rm -f $TMPDIR/common/service.sh; fi
if $BOOTMODE; then
  mkdir -p /storage/emulated/0/gnu/com /storage/emulated/0/gnu/var /storage/emulated/0/gnu/share /storage/emulated/0/gnu/awkscripts
  cp -f $TMPDIR/awkscripts/* /storage/emulated/0/gnu/awkscripts
else
  mkdir -p /data/media/0/gnu/com /data/media/0/gnu/var /data/media/0/gnu/share /data/media/0/gnu/awkscripts
  cp -f $TMPDIR/awkscripts/* /data/media/0/gnu/awkscripts
fi
