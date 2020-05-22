add wave -position insertpoint \
sim:/pcplusone/input \
sim:/pcplusone/clock \
sim:/pcplusone/output \

force -freeze sim:/pcplusone/clock 1 0, 0 {50 ns} -r 100
run 100 ns

force -freeze sim:/pcplusone/input 32'h00000000

force -freeze sim:/pcplusone/clock 1 0, 0 {50 ns} -r 100
run 100 ns

force -freeze sim:/pcplusone/input 32'h00000001

force -freeze sim:/pcplusone/clock 1 0, 0 {50 ns} -r 100
run 100 ns