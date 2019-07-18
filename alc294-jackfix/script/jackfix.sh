#!/bin/sh

###
### Bits for ALC294
###

### Inject a delay to make sure we're awake before continuing

while true
do
  sleep 3
  SLEEPTEST=$(/usr/local/bin/hda-verb 0x01 GET_POWER_STATE POWER_STATE 2>&1 | awk 'BEGIN {FS="= "}; /result/ {print $2}')
  if [ ! "${SLEEPTEST}" == "0x00000000" ]
  then
    /usr/local/bin/hda-verb 0x01 SET_POWER_STATE 1
    /usr/local/bin/hda-verb 0x01 SET_POWER_STATE 0
    break
  else
    break
  fi
done

### Tickle the control pins
/usr/local/bin/hda-verb 0x18 SET_PIN_WIDGET_CONTROL 0x24
/usr/local/bin/hda-verb 0x19 SET_PIN_WIDGET_CONTROL 0x24
/usr/local/bin/hda-verb 0x1a SET_PIN_WIDGET_CONTROL 0x24
/usr/local/bin/hda-verb 0x1f SET_PIN_WIDGET_CONTROL 0x24
