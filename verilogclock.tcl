add_files [ glob ./src/design/*.v]

synth_design -top top -part xc7a100tcsg324-1

opt_design

place_design

route_design

write_bitstream ./bin/design.bit