################################################
## xfan100 compile make file.
################################################


RV_ROOT := ${PWD}/..

RV_TB := ${RV_ROOT}/rtl/tb
RV_CORE := ${RV_ROOT}/rtl/core

TESTNAME := rv32ui-p-addi

TESTCASE := ${RV_ROOT}/testcases/riscv-tests/isa/generated/${TESTNAME}

VCS    := vcs
VERDI := verdi

install:
	ls ${RV_TB}/*.v >> rtl_flist
	ls ${RV_CORE}/*defines.v >> rtl_flist
	ls ${RV_CORE}/*/*.v >> rtl_flist
	ls ${RV_CORE}/*/*.v >> tb_flist
	ls ${RV_CORE}/*/*.v >> core_flist


compile:        
	${VCS} -full64 -assert svaext \
	-sverilog +error+500 +incdir+${RV_TB} +libext+.v -f tb_flist 

run_test:       
	${VCS} -full64 -assert svaext \
	-sverilog +error+500 +incdir+${RV_TB} +incdir+${RV_CORE}  +libext+.v -f rtl_flist \
	-P /home/baicai/__working/SynopsysTools/verdi_install/share/PLI/VCS/LINUX64/novas.tab \
       /home/baicai/__working/SynopsysTools/verdi_install/share/PLI/VCS/LINUX64/pli.a	\
	-l vcs.log
	./simv

wave:
	${VERDI} +libext+.v +incdir+${RV_TB} -f rtl_flist  -top tb_top \
		-ssf tb_top.fsdb -nologo &



clean:
	rm simv.daidir -rf;	rm *_flist;	rm vc_hdrs.h;rm csrc -rf;rm novas*.*;rm simv;rm tb_top*.*;rm ucli.key;rm vcs.log;rm -rf verdiLog
