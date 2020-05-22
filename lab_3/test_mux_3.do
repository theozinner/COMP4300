add wave -position insertpoint \
sim:/mux_3/which \
sim:/mux_3/input_0 \
sim:/mux_3/input_1 \
sim:/mux_3/input_2 \
sim:/mux_3/output \
 
force -freeze sim:/mux_3/input_0 32'h00000000 0
force -freeze sim:/mux_3/input_1 32'hFFFFFFFF 0
force -freeze sim:/mux_3/input_2 32'hFFFF0000 0

force -freeze sim:/mux_3/which 2'h0 0
run 100 ns
force -freeze sim:/mux_3/which 2'h1 0
run 100 ns
force -freeze sim:/mux_3/which 2'h2 0
run 100 ns