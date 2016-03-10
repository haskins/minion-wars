// healer
//heals base first

/* Initial beliefs */
delay(0).

/* Initial goal */
!death_check. 

/* Plans */
//find a target
+!find : .my_name(N) & status(N,T,_,_) & status(E,T,b,H) & H < 100 & not H = 0  & not N = E  			<- .print("attempting to find"); !travel(E). //heal base first
+!find : .my_name(N) & status(N,T,_,_) & status(E,T,_,H) & H < 100 & not H = 0  & not N = E  			<- .print("attempting to find"); !travel(E).
+!find 																									<- .print("No one exists"); !!death_check. //if no enemy, prints out enemy is dead

//search for target
+!search <-  .print("searching"); !find.   
+!search. 
   
//travel to target
+!travel(E) <- !move(E); !heal(E); !!search.

//heal target
+!heal(E) <- .print("healing"); heal_agent(E).

//move towards target
+!move(E) : move(E). 
+!move(E) : .my_name(N) & status(N,T,_,_) & base_emer(T) 			<- ?status(A,T,b,_); !move(A). //moves to base if declared emergency state
+!move(E) : .my_name(N) & pos(N,A,B) & pos(E,X,Y) & X = A & Y = B	<- .print("We are on top of the target").
+!move(E) : .my_name(N) & pos(N,A,B) & pos(E,X,Y) & X > A			<- .print("Moving on east"); move_east(N); !move(E).
+!move(E) : .my_name(N) & pos(N,A,B) & pos(E,X,Y) & X < A			<- .print("Moving on west"); move_west(N); !move(E).
+!move(E) : .my_name(N) & pos(N,A,B) & pos(E,X,Y) & X = A & B > Y 	<- .print("Moving on north"); move_north(N); !move(E).
+!move(E) : .my_name(N) & pos(N,A,B) & pos(E,X,Y) & X = A & B < Y 	<- .print("Moving on south"); move_south(N); !move(E).
+!move(E) 															<- .print("I can't figure out where to move'").

//check my own health
+!death_check : .my_name(N) & status(N,T,_,_) & status(_,T,b,H) & H = 0 <- .print("killing myself"); remove(N); .kill_agent(N).
+!death_check : .my_name(N) & status(N,_,_,H) & H = 0 					<- remove(N); .kill_agent(N).
+!death_check 															<- !search.