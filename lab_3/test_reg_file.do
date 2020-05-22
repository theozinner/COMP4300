add wave -position insertpoint \
sim:/reg_file/data_in \
sim:/reg_file/clock \
sim:/reg_file/data_out \
sim:/reg_file/readnotwrite \
sim:/reg_file/reg_number \


force -freeze sim:/reg_file/data_in 32'hFFFFFFFF 0
force -freeze sim:/reg_file/reg_number 4'h1 0
force -freeze sim:/reg_file/readnotwrite 1'h1
force -freeze sim:/reg_file/clock 1 0, 0 {50 ns} -r 100
run 100 ns

force -freeze sim:/reg_file/data_in 32'hFFFFFFFF 0
force -freeze sim:/reg_file/reg_number 4'h1 0
force -freeze sim:/reg_file/readnotwrite 1'h0
force -freeze sim:/reg_file/clock 1 0, 0 {50 ns} -r 100
run 100 ns