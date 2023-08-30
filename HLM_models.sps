* Encoding: UTF-8.
GET
  FILE='C:\Users\JoaquinFarina\OneDrive - Teachers College, Columbia University\Desktop\TC\2 - '+
    'Spring2023\ORLA 6641 ATRMD\Midterm\chilean_test_scores_grade8_2015_expectations.sav'.

RECODE student_exp parent_exp teacher_exp (0=SYSMIS) (99=SYSMIS).
EXECUTE.

DESCRIPTIVES VARIABLES= ptje_mate8b_alu student_exp_binary gen_alu_bin ben_sep prom_gral asistencia  ive cod_depe2_public cod_depe2_private
  /STATISTICS=MEAN STDDEV MIN MAX.

PPLOT
  /VARIABLES=prom_gral_z ptje_mate8b_alu_z ive_z student_exp_binary_school_z
  /NOLOG
  /NOSTANDARDIZE
  /TYPE=Q-Q
  /FRACTION=BLOM
  /TIES=MEAN
  /DIST=NORMAL.

GRAPH
  /SCATTERPLOT(MATRIX)=gen_alu_bin student_exp_binary cod_depe2_public cod_depe2_private ptje_mate8b_alu_z ive_z prom_gral_z 
    student_exp_binary_school_z
  /MISSING=LISTWISE.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT ptje_mate8b_alu_z
  /METHOD=ENTER gen_alu_bin student_exp_binary cod_depe2_public cod_depe2_private  ben_sep ive_z prom_gral_z 
    student_exp_binary_school_z
  /SCATTERPLOT=(*ZRESID ,*ZPRED).

MIXED ptje_mate8b_alu_z
  /CRITERIA=DFMETHOD(SATTERTHWAITE) CIN(95) MXITER(100) MXSTEP(10) SCORING(1) 
    SINGULAR(0.000000000001) HCONVERGE(0.00000001, RELATIVE) LCONVERGE(0, ABSOLUTE) PCONVERGE(0, 
    ABSOLUTE)
  /FIXED=| SSTYPE(3)
  /METHOD=REML
  /PRINT=G  SOLUTION TESTCOV
  /RANDOM=INTERCEPT | SUBJECT(rbd) COVTYPE(VC).


MIXED ptje_mate8b_alu_z BY student_exp_binary gen_alu_bin ben_sep  WITH prom_gral_z 
  /CRITERIA=DFMETHOD(SATTERTHWAITE) CIN(95) MXITER(100) MXSTEP(10) SCORING(1) 
    SINGULAR(0.000000000001) HCONVERGE(0.00000001, RELATIVE) LCONVERGE(0, ABSOLUTE) PCONVERGE(0, 
    ABSOLUTE)
  /FIXED=student_exp_binary gen_alu_bin ben_sep prom_gral_z  | SSTYPE(3)
  /METHOD=REML
  /PRINT=G  SOLUTION TESTCOV
  /RANDOM=INTERCEPT | SUBJECT(rbd) COVTYPE(VC).

MIXED ptje_mate8b_alu_z BY student_exp_binary gen_alu_bin ben_sep cod_depe2_public cod_depe2_private   WITH 
    prom_gral_z  student_exp_binary_school_z ive_z
  /CRITERIA=DFMETHOD(SATTERTHWAITE) CIN(95) MXITER(100) MXSTEP(10) SCORING(1) 
    SINGULAR(0.000000000001) HCONVERGE(0.00000001, RELATIVE) LCONVERGE(0, ABSOLUTE) PCONVERGE(0, 
    ABSOLUTE)
  /FIXED=student_exp_binary_school_z ive_z cod_depe2_public cod_depe2_private   student_exp_binary gen_alu_bin ben_sep 
     prom_gral_z  | SSTYPE(3)
  /METHOD=REML
  /PRINT=G  SOLUTION TESTCOV
  /RANDOM=INTERCEPT | SUBJECT(rbd) COVTYPE(VC).





