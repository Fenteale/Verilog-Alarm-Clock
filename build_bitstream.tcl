

synth_design -top $topModule -part xc7a100tcsg324-1

opt_design

place_design

route_design

write_bitstream -force ./bin/design.bit