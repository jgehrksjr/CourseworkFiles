onerror {quit -f}
vlib work
vlog -work work CE4720_SimpleCPU.vo
vlog -work work CE4720_SimpleCPU.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.CE4720_SimpleCPU_vlg_vec_tst
vcd file -direction CE4720_SimpleCPU.msim.vcd
vcd add -internal CE4720_SimpleCPU_vlg_vec_tst/*
vcd add -internal CE4720_SimpleCPU_vlg_vec_tst/i1/*
add wave /*
run -all
