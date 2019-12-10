onerror {quit -f}
vlib work
vlog -work work micro.vo
vlog -work work micro.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.micro_vlg_vec_tst
vcd file -direction micro.msim.vcd
vcd add -internal micro_vlg_vec_tst/*
vcd add -internal micro_vlg_vec_tst/i1/*
add wave /*
run -all
