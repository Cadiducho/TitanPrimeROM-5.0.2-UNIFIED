#!/system/bin/sh
#==============================================================================
#
#   File Name: init.titan.audio.sh
#
#   General Description: This script is used to install the proper audio acdb
#                        mixer_path.xml file for different type of hardware:
#                        ro.hw.hwrev >= 0x8400 need to use new gain control
#                        files.
#
#==============================================================================
#
#               Motorola Mobility Confidential Proprietary
#        (c) Copyright Motorola Mobility 2014, All Rights Reserved
#
#==============================================================================

# No path is set up at this point so we have to do it here.
PATH=/sbin:/system/sbin:/system/bin:/system/xbin
export PATH

#find the product type and hardware revision
product=`getprop ro.hw.device`
version=`getprop ro.hw.hwrev`
oldMixerFileName="/system/etc/mixer_paths_minus9.xml"
oldACDBFileName="/etc/Speaker_cal_minus9.acdb"

LOG_TAG="moto-titan-init"
LOG_NAME="${0}:"

loge ()
{
  /system/bin/log -t $LOG_TAG -p e "$LOG_NAME $@"
}

logi ()
{
  /system/bin/log -t $LOG_TAG -p i "$LOG_NAME $@"
}

failed ()
{
  loge "$1: exit code $2"
  exit $2
}

setOldGainFiles()
{
    if [ ! -f "${oldMixerFileName}" ]; then
        failed "${oldMixerFileName} not Found " 1
    elif [ ! -f "${oldACDBFileName}" ]; then
        failed "${oldACDBFileName} not found " 2
    else
        /system/bin/mount -o bind "${oldACDBFileName}" /system/etc/Speaker_cal.acdb
        logi "old ACDB file set for speaker"
        /system/bin/mount -o bind "${oldMixerFileName}" /system/etc/mixer_paths.xml
        logi "old mixer_path.xml file mounted"
    fi
}

logi "In Moto Titan Init shell Script"
logi "Product   : ${product}"
logi "HW Version: ${version}"

if [ "${product}" = "titan" ]
if [ "${version}" = "0x8100" ]; then
    logi "P1 HW found"
    setOldGainFiles
elif [ "${version}" = "0x8200" ]; then
    logi "P2 HW found"
    setOldGainFiles
elif [ "${version}" = "0x8300" ]; then
    logi "P3 HW found"
    setOldGainFiles
else
    logi "No need to do anything for new HW"
fi
fi

exit 0
