sidCmdLineBehaviorAnalysisOpt -incr -clockSkew 0 -loopUnroll 0 -bboxEmptyModule 0  -cellModel 0 -bboxIgnoreProtected 0 
debImport "+libext+.v" \
          "+incdir+/home/baicai/__working/project/XFAN/xfan100/run/..//rtl/tb" \
          "-f" "tb_flist" "-top" "tb_top"
debLoadSimResult /home/baicai/__working/project/XFAN/xfan100/run/tb_top.fsdb
wvCreateWindow
srcHBSelect "tb_top.u_tb_mem_init" -win $_nTrace1
srcSetScope -win $_nTrace1 "tb_top.u_tb_mem_init" -delim "."
srcDeselectAll -win $_nTrace1
srcSelect -signal "instr" -win $_nTrace1
srcAddSelectedToWave -win $_nTrace1
wvZoom -win $_nWave2 1867.074940 2193.486643
srcDeselectAll -win $_nTrace1
debExit
