################################################
## xfan100 compile make file.
################################################


RV_ROOT := ${PWD}/../

RV_TB := ${RV_ROOT}/rtl/tb

TESTNAME := rv32ui-p-addi

TESTCASE := ${RV_ROOT}/testcases/riscv-tests/isa/generated/${TESTNAME}

VCS    := vcs
VERDI := verdi

install:
	ls ${RV_TB}/*.v &> tb_flist


compile:install 
	${VCS} -full64 -assert svaext \
	-sverilog +error+500 +incdir+${RV_TB} +libext+.v -f tb_flist 

run_test: 
	${VCS} -full64 -assert svaext \
	-sverilog +error+500 +incdir+${RV_TB} +libext+.v -f tb_flist \
	-P /home/baicai/__working/SynopsysTools/verdi_install/share/PLI/VCS/LINUX64/novas.tab \
       /home/baicai/__working/SynopsysTools/verdi_install/share/PLI/VCS/LINUX64/pli.a	\
	-l vcs.log
	./simv

wave:
	${VERDI} +libext+.v +incdir+${RV_TB} -f tb_flist  -top tb_top \
		-ssf tb_top.fsdb -nologo &



clean:
	rm simv.daidir -rf
	rm tb_flist
	rm vc_hdrs.h
	rm csrc -rf
