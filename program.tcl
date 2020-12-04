open_hw_manager

connect_hw_server

open_hw_target

set Device [lindex [get_hw_devices] 0]
current_hw_device $Device
refresh_hw_device -update_hw_probes false $Device
set_property PROGRAM.FILE "./bin/design.bit" $Device

program_hw_devices $Device
refresh_hw_device $Device

close_hw_target
disconnect_hw_server