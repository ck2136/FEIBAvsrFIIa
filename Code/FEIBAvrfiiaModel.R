#Objectives####
#Determine CEA/CUA of FEIBA vs rFIIa using Markov Model

#Packages####
install.packages("heemod")
library(heemod)

#Model Building####

#Transition Matrix#
mat_feiba <- define_transition(
  state_names = c("Cont_bleed","Bleed_stop","Thrombosis"),
C, p_bleed_stop_feiba, p_thrombosis_feiba ,
 0,1, 0,
0,0,1
)

mat_base <- NULL

mat_rfiia<- define_transition(
  state_names = c("Cont_bleed","Bleed_stop","Thrombosis"),
  C, p_bleed_stop_rfiia, p_thrombosis_rfiia ,
  0,1, 0,
  0,0,1
)

#State Values#
state_cont_bleed <- define_state(
  
)