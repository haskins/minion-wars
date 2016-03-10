// base

/* Initial beliefs */
delay(1000).

/* Initial goal */
//!death_check. 

/* Plans */
//check my health
+!health_check : delay(D) & .my_name(N) & status(N,T,_,H) & H = 100 & base_heal(T) 	<- .print("base healed"); revoke(base_heal(T)); .wait(D); !death_check. //remove base_heal request
+!health_check : delay(D) & .my_name(N) & status(N,T,_,H) & H < 100 & H > 30 		<- .print("base heal"); tell(base_heal(T)); .wait(D); !death_check. //add base_heal request
+!health_check : delay(D) & .my_name(N) & status(N,T,_,H) & H = 100 & base_emer(T) 	<- .print("base healed"); revoke(base_emer(T)); .wait(D); !death_check. //remove base_emer request
+!health_check : delay(D) & .my_name(N) & status(N,T,_,H) & H < 30 & H > 0 			<- .print("base heal"); tell(base_emer(T)); .wait(D); !death_check. //add base_emer request
+!health_check 																		<- .wait(D); !death_check.

//check if should be dead
+!death_check : .my_name(N) & status(N,_,_,H) & H = 0 							<- .print("killing myself"); .kill_agent(N).
+!death_check : .my_name(N) & status(N,T,_,_) & status(_,F,b,_) & not T = F 	<- .print("killing myself"); .kill_agent(N).
+!death_check 																	<- !health_check.