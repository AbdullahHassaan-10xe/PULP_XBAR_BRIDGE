SHELL=bash
#SIM_OPT_CXXFLAGS := -O3
CLOCK_PERIOD ?= 1.0
RESET_DELAY ?= 777.7
SIM_OPT += -l sim.log
#SIM_OPT += +vcs+initreg+0
target?=0
export ROOT:=$(PWD)
f_list_lint=$(ROOT)/sim/f_list/soc_flist.f
lint_rtl :=$(ROOT)/rtl
lint_1 :=$(ROOT)/dv/uvm_agents/xbar_l2_agent 
lint_2 :=$(ROOT)/dv/seq_lib
lint_3 :=$(ROOT)/dv/tests
lint_4 :=$(ROOT)/dv/tb/tb_xbar_l2

##########################################
# QuestaSim Flag for Simulation
##########################################
QSIM_OPTS = -sv
			

#########################################################################################
# QuestaSim binary and arguments
#########################################################################################
QSIM = vsim


main: compile sim


compile: 
	vlog $(QSIM_OPTS) -f $(f_list_lint) +incdir+$(lint_rtl) +incdir+$(lint_1) +incdir+$(lint_2) +incdir+$(lint_3) +incdir+$(lint_4)

sim:
	@echo "Simulating the lint target..."
	$(QSIM) -gui -do "run -all" -voptargs=+acc work.tb_top $(SIM_OPT) +UVM_TESTNAME=cons_read_test +UVM_VERBOSITY=UVM_HIGH  
	
	
	
clean:
	rm -rf *.vdb csrc *.daidir *.h novas.* *.log *simv *.fsdb waves.* *.dump verdiLog simvs  *.vcd *.wlf work    
	
.PHONY: main compile sim clean



