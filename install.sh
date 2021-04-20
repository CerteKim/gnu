##########################################################################################
#
# Unity Config Script
# by topjohnwu, modified by Zackptg5
#
##########################################################################################

##########################################################################################
# Unity Logic - Don't change/move this section
##########################################################################################

if [ -z $UF ]; then
  UF=$TMPDIR/common/unityfiles
  unzip -oq "$ZIPFILE" 'common/unityfiles/util_functions.sh' -d $TMPDIR >&2
  [ -f "$UF/util_functions.sh" ] || { ui_print "! Unable to extract zip file !"; exit 1; }
  . $UF/util_functions.sh
fi

comp_check

##########################################################################################
# Config Flags
##########################################################################################

# Uncomment and change 'MINAPI' and 'MAXAPI' to the minimum and maximum android version for your mod
# Uncomment DYNLIB if you want libs installed to vendor for oreo+ and system for anything older
# Uncomment SYSOVER if you want the mod to always be installed to system (even on magisk) - note that this can still be set to true by the user by adding 'sysover' to the zipname
# Uncomment DEBUG if you want full debug logs (saved to /sdcard in magisk manager and the zip directory in twrp) - note that this can still be set to true by the user by adding 'debug' to the zipname
#MINAPI=21
#MAXAPI=25
#DYNLIB=true
#SYSOVER=true
#DEBUG=true

# Uncomment if you do *NOT* want Magisk to mount any files for you. Most modules would NOT want to set this flag to true
# This is obviously irrelevant for system installs. This will be set to true automatically if your module has no files in system
#SKIPMOUNT=true

##########################################################################################
# Replace list
##########################################################################################

# List all directories you want to directly replace in the system
# Check the documentations for more info why you would need this

# Construct your list in the following format
# This is an example
REPLACE_EXAMPLE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"

# Construct your own list here
REPLACE="
"

##########################################################################################
# Custom Logic
##########################################################################################

# Set what you want to display when installing your module

print_modname() {
  center_and_print # Replace this line if using custom print stuff
  unity_main # Don't change this line
}

set_permissions() {
  if ! $MAGISK || $SYSOVER; then BAKSYM=true; else BAKSYM=false; fi

  set_perm $UNITY/system/etc/profile.d/gawk.sh 0 0 0755
  for i in $(ls -A $TMPDIR/system/bin); do
    set_perm $UNITY/system/bin/$i 0 2000 0755
  done
  # Generate symlinks (but don't overwrite oem binaries)
  cd $UNITY/system/bin
  $BAKSYM && local FLAGS="-sfb" || local FLAGS="-sf"
  [ -f "/system/bin/awk" ] || $UNITY/system/bin/coreutils --coreutils-prog=ln $FLAGS gawk awk
  for APPLET in $(cat $TMPDIR/coreutils_modules); do
    if ([ ! -f "$ORIGDIR/system/bin/$APPLET" ] && [ ! -L "$ORIGDIR/system/bin/$APPLET" ]) || [ "$APPLET" == "cp" ] || [ "$APPLET" == "mv" ]; then
      $UNITY/system/bin/coreutils --coreutils-prog=ln $FLAGS coreutils $APPLET
      $BAKSYM && [ -f "/system/bin/$APPLET~" ] && echo "/system/bin/$APPLET~" >> $INFO
    fi
    $BAKSYM && echo "/system/bin/$APPLET" >> $INFO
  done
  cd /

  # Note that all files/folders have the $UNITY prefix - keep this prefix on all of your files/folders
  # Also note the lack of '/' between variables - preceding slashes are already included in the variables
  # Use $VEN for vendor (Do not use /system$VEN, the $VEN is set to proper vendor path already - could be /vendor, /system/vendor, etc.)

  # Some examples:

  # For directories (includes files in them):
  # set_perm_recursive  <dirname>                <owner> <group> <dirpermission> <filepermission> <contexts> (default: u:object_r:system_file:s0)

  # set_perm_recursive $UNITY/system/lib 0 0 0755 0644
  # set_perm_recursive $UNITY$VEN/lib/soundfx 0 0 0755 0644

  # For files (not in directories taken care of above)
  # set_perm  <filename>                         <owner> <group> <permission> <contexts> (default: u:object_r:system_file:s0)

  # set_perm $UNITY/system/lib/libart.so 0 0 0644
}

# Custom Variables for Install AND Uninstall - Keep everything within this function - runs before uninstall/install
unity_custom() {
  : # Remove this if adding to this function
}

# Custom Functions for Install AND Uninstall - You can put them here
