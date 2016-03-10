// attacker
// kills attacker first, then any discovered enemy

/* Initial beliefs */
delay(1000).

/* Initial goal */
!death_check.

/* Plans */
//find target
+!find : .my_name(N) & status(N,T,_,_) & status(E,A,_,H) & H > 0 & not T = A & pos(N,X,Y) & pos(E,W,Z) & X = W & Y = Z <- .print("attacking person on me"); !travel(E).
+!find : .my_name(N) & status(N,T,_,_) & status(E,A,a,H) & H > 0 & not T = A 										   <- .print("attempting to find"); !travel(E). //find any other units first
+!find : .my_name(N) & status(N,T,_,_) & status(E,A,_,H) & H > 0 & not T = A 										   <- .print("attempting to find"); !travel(E). //find any other units first
+!find : delay(D) & .my_name(N) & status(N,T,_,_) & status(_,T,_,_) 	     										   <- .print("there are no enemies currently alive"); tell(sim(over)); .kill_agent(N); !death_check. 

//initial check
+!check : .my_name(N) & status(N,_,_,X) & X > 0 <-  !find. 
+!check 										<- !death_check.
+!check. 

//travel to target
+!travel(E) 	<- !monitor; !move(E); !attack(E); !!death_check.

//attack target
+!attack(E) 	<- kill_agent(E).

//move towards target
+!move(E) : move(E). 
+!move(E) : .my_name(N) & pos(N,A,B) & pos(E,X,Y) & X = A & Y = B	<- .print("We are on top of the target").
+!move(E) : .my_name(N) & pos(N,A,B) & pos(E,X,Y) & X > A			<- .print("Moving on east"); move_east(N); !move(E).
+!move(E) : .my_name(N) & pos(N,A,B) & pos(E,X,Y) & X < A			<- .print("Moving on west"); move_west(N); !move(E).
+!move(E) : .my_name(N) & pos(N,A,B) & pos(E,X,Y) & X = A & B > Y 	<- .print("Moving on north"); move_north(N); !move(E).
+!move(E) : .my_name(N) & pos(N,A,B) & pos(E,X,Y) & X = A & B < Y 	<- .print("Moving on south"); move_south(N); !move(E).
+!move(E) 															<- .print("I can't figure out where to move'"). 

//check if should be dead
+!death_check : .my_name(N) & status(N,T,_,_) & status(_,T,b,H) & H = 0 <- .print("killing myself"); remove(N); .kill_agent(N).
+!death_check : .my_name(N) & status(N,_,_,H) & H = 0 					<- remove(N); .kill_agent(N).
+!death_check 															<- !check.

//monitor base 3x3 grid
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,0,0) & status(E,S,_,_) & not S = T & pos(E,0,0) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,0,0) & status(E,S,_,_) & not S = T & pos(E,0,1) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,0,0) & status(E,S,_,_) & not S = T & pos(E,0,2) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,0,0) & status(E,S,_,_) & not S = T & pos(E,1,0) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,0,0) & status(E,S,_,_) & not S = T & pos(E,1,1) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,0,0) & status(E,S,_,_) & not S = T & pos(E,1,2) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,0,0) & status(E,S,_,_) & not S = T & pos(E,2,0) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,0,0) & status(E,S,_,_) & not S = T & pos(E,2,1) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,0,0) & status(E,S,_,_) & not S = T & pos(E,2,2) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,0,19) & status(E,S,_,_) & not S = T & pos(E,0,17) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,0,19) & status(E,S,_,_) & not S = T & pos(E,1,18) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,0,19) & status(E,S,_,_) & not S = T & pos(E,2,19) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,0,19) & status(E,S,_,_) & not S = T & pos(E,0,17) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,0,19) & status(E,S,_,_) & not S = T & pos(E,1,18) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,0,19) & status(E,S,_,_) & not S = T & pos(E,2,19) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,0,19) & status(E,S,_,_) & not S = T & pos(E,0,17) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,0,19) & status(E,S,_,_) & not S = T & pos(E,1,18) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,0,19) & status(E,S,_,_) & not S = T & pos(E,2,19) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,19,19) & status(E,S,_,_) & not S = T & pos(E,17,17) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,19,19) & status(E,S,_,_) & not S = T & pos(E,17,18) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,19,19) & status(E,S,_,_) & not S = T & pos(E,17,19) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,19,19) & status(E,S,_,_) & not S = T & pos(E,18,17) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,19,19) & status(E,S,_,_) & not S = T & pos(E,18,18) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,19,19) & status(E,S,_,_) & not S = T & pos(E,18,19) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,19,19) & status(E,S,_,_) & not S = T & pos(E,19,17) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,19,19) & status(E,S,_,_) & not S = T & pos(E,19,18) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,19,19) & status(E,S,_,_) & not S = T & pos(E,19,19) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,19,0) & status(E,S,_,_) & not S = T & pos(E,17,0) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,19,0) & status(E,S,_,_) & not S = T & pos(E,17,1) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,19,0) & status(E,S,_,_) & not S = T & pos(E,17,2) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,19,0) & status(E,S,_,_) & not S = T & pos(E,18,0) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,19,0) & status(E,S,_,_) & not S = T & pos(E,18,1) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,19,0) & status(E,S,_,_) & not S = T & pos(E,18,2) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,19,0) & status(E,S,_,_) & not S = T & pos(E,19,0) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,19,0) & status(E,S,_,_) & not S = T & pos(E,19,1) <- travel(E).
+!monitor : .my_name(N) & status(N,T,_,_) & status(F,T,b,_) & pos(F,19,0) & status(E,S,_,_) & not S = T & pos(E,19,2) <- travel(E).
+!monitor.
