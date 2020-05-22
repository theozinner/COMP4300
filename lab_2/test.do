add wave -position insertpoint  \
sim:/alu/operand1 \
sim:/alu/operand2 \
sim:/alu/operation \
sim:/alu/result \
sim:/alu/error


force -freeze sim:/alu/operand1 32'hFFFFFFFF 0
force -freeze sim:/alu/operand2 32'h00000000 0
force -freeze sim:/alu/operation 4'h0 0
run 100 ns

force -freeze sim:/alu/operand1 32'hFFFFFFFF 0
force -freeze sim:/alu/operand2 32'h00000001 0
force -freeze sim:/alu/operation 4'h0 0
run 100 ns

force -freeze sim:/alu/operand1 32'h00000010 0
force -freeze sim:/alu/operand2 32'h00000001 0
force -freeze sim:/alu/operation 4'h1 0
run 100 ns

force -freeze sim:/alu/operand1 32'hf0000001 0
force -freeze sim:/alu/operand2 32'hf0000001 0
force -freeze sim:/alu/operation 4'h1 0
run 100 ns

force -freeze sim:/alu/operand1 32'hf0000001 0
force -freeze sim:/alu/operand2 32'hf000000F 0
force -freeze sim:/alu/operation 4'h1 0
run 100 ns

force -freeze sim:/alu/operand1 32'h00000010 0
force -freeze sim:/alu/operand2 32'h00000001 0
force -freeze sim:/alu/operation 4'h2 0
run 100 ns

force -freeze sim:/alu/operand1 32'hFFFFFF11 0
force -freeze sim:/alu/operand2 32'hFFFFFFFF 0
force -freeze sim:/alu/operation 4'h2 0
run 100 ns

force -freeze sim:/alu/operand1 32'hF40FFFFF 0
force -freeze sim:/alu/operand2 32'h8ACFFFFF 0
force -freeze sim:/alu/operation 4'h2 0
run 100 ns


force -freeze sim:/alu/operand1 32'h0000FFF1 0
force -freeze sim:/alu/operand2 32'h0000FFFF 0
force -freeze sim:/alu/operation 4'h3 0
run 100 ns

force -freeze sim:/alu/operand1 32'h7FFFFFFF 0
force -freeze sim:/alu/operand2 32'hFFFFFFFF 0
force -freeze sim:/alu/operation 4'h3 0
run 100 ns

force -freeze sim:/alu/operand1 32'h0000F11F 0
force -freeze sim:/alu/operand2 32'h0000FFF0 0
force -freeze sim:/alu/operation 4'h3 0
run 100 ns

force -freeze sim:/alu/operand1 32'h0000FFFF 0
force -freeze sim:/alu/operand2 32'h00000001 0
force -freeze sim:/alu/operation 4'h4 0
run 100 ns

force -freeze sim:/alu/operand1 32'hFFFFF0FF 0
force -freeze sim:/alu/operand2 32'h80010000 0
force -freeze sim:/alu/operation 4'h4 0
run 100 ns

force -freeze sim:/alu/operand1 32'hFFFFFFFF 0
force -freeze sim:/alu/operand2 32'h80000FF0 0
force -freeze sim:/alu/operation 4'h4 0
run 100 ns

force -freeze sim:/alu/operand1 32'hFFFF 0
force -freeze sim:/alu/operand2 32'hFFFFFFFF 0
force -freeze sim:/alu/operation 4'h5 0
run 100 ns

force -freeze sim:/alu/operand1 32'h0000000F 0
force -freeze sim:/alu/operand2 32'h00000000 0
force -freeze sim:/alu/operation 4'h5 0
run 100 ns

force -freeze sim:/alu/operand1 32'h80000000 0
force -freeze sim:/alu/operand2 32'hFFFFFFFF 0
force -freeze sim:/alu/operation 4'h5 0
run 100 ns

force -freeze sim:/alu/operand1 32'h00000001 0
force -freeze sim:/alu/operand2 32'h00000001 0
force -freeze sim:/alu/operation 4'h6 0
run 100 ns

force -freeze sim:/alu/operand1 32'h00000001 0
force -freeze sim:/alu/operand2 32'h00000000 0
force -freeze sim:/alu/operation 4'h6 0
run 100 ns

force -freeze sim:/alu/operand1 32'h00000001 0
force -freeze sim:/alu/operand2 32'h00000001 0
force -freeze sim:/alu/operation 4'h7 0
run 100 ns

force -freeze sim:/alu/operand1 32'h00000001 0
force -freeze sim:/alu/operand2 32'h00000000 0
force -freeze sim:/alu/operation 4'h7 0
run 100 ns

force -freeze sim:/alu/operand1 32'h00000001 0
force -freeze sim:/alu/operand2 32'h00000000 0
force -freeze sim:/alu/operation 4'h9 0
run 100 ns

force -freeze sim:/alu/operand1 32'h00000000 0
force -freeze sim:/alu/operand2 32'h00000000 0
force -freeze sim:/alu/operation 4'h9 0
run 100 ns

force -freeze sim:/alu/operand1 32'hFFFFFFFF 0
force -freeze sim:/alu/operand2 32'h00000000 0
force -freeze sim:/alu/operation 4'hB 0
run 100 ns

force -freeze sim:/alu/operand1 32'hFFFFFFFF 0
force -freeze sim:/alu/operand2 32'h00000000 0
force -freeze sim:/alu/operation 4'hC 0
run 100 ns

force -freeze sim:/alu/operand1 32'h00000000 0
force -freeze sim:/alu/operand2 32'hFFFFFFFF 0
force -freeze sim:/alu/operation 4'hD 0
run 100 ns