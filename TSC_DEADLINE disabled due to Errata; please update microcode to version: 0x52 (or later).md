При ошибке  
**[Firmware Bug]: TSC_DEADLINE disabled due to Errata; please update microcode to version: 0x20 (or later)**

Необходимо установить пакетыиз Debian’s contrib and non-free repositories.  then run
```
apt update
# for Intel CPUs
apt install intel-microcode
# for AMD CPUs
apt install amd64-microcode
```
 Once that’s done, reboot, and your microcode should be updated. If TSC deadline support is re-enabled, you won’t see the error message at boot, and you’ll see tsc_deadline_timer in the flags lines of /proc/cpuinfo.
 The Debian wiki has more information on microcode updates- https://wiki.debian.org/Microcode.
