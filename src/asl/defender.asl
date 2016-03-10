// defender
// looks for injured team mates, moves on top to protect if dying

/* Initial beliefs */
delay(1000).

/* Initial goal */
!death_check. 

/* Plans */
+!find : .my_name(N) & status(N,T,_,_) & status(E,T,h,H) & H < 100 & not N = E 				<- .print("blocking base first"); !travel(E). //defend base first
+!find : .my_name(N) & status(N,T,_,_) & status(E,T,_,H) & H < 10 & not H = 0 & not N = E   <- .print("attempting to find"); !travel(E).
+!find : .my_name(N) & status(N,T,_,_) & status(E,T,_,H) & H < 20 & not N = E   			<- .print("attempting to find"); !travel(E). 
+!find : .my_name(N) & status(N,T,_,_) & status(E,T,_,H) & H < 30 & not N = E   			<- .print("attempting to find"); !travel(E).
+!find : .my_name(N) & status(N,T,_,_) & status(E,T,_,H) & H < 40 & not N = E   			<- .print("attempting to find"); !travel(E).
+!find : .my_name(N) & status(N,T,_,_) & status(E,T,_,H) & H < 50 & not N = E 				<- .print("attempting to find"); !travel(E).
+!find : .my_name(N) & status(N,T,_,_) & status(E,T,_,H) & H < 60 & not N = E  				<- .print("attempting to find"); !travel(E).
+!find : .my_name(N) & status(N,T,_,_) & status(E,T,_,H) & H < 70 & not N = E  				<- .print("attempting to find"); !travel(E).
+!find : .my_name(N) & status(N,T,_,_) & status(E,T,_,H) & H < 80 & not N = E  				<- .print("attempting to find"); !travel(E).
+!find : .my_name(N) & status(N,T,_,_) & status(E,T,_,H) & H < 90 & not N = E  				<- .print("attempting to find"); !travel(E).
+!find : .my_name(N) & status(N,T,_,_) & status(E,T,_,H) & H < 100 & not N = E  			<- .print("attempting to find"); !travel(E).
+!find : delay(D) & .my_name(N) & status(N,T,_,_) & status(_,T,_,_)  & not N = T    		<- .print("searching for more people to heal"); .kill_agent(N); !!death_check. //find more people to heal

+!find 																						<- .print("No one exists"). //if no enemy, prints out enemy is dead

+!search <- !base_check; !find.   
+!search. 
   
+!travel(E) <- !move(E); !block(E); !!death_check.

+!block(E) <- ?.my_name(N); ?pos(N,X,Y); ?status(N,T,_,_); .print(blocking); tell(block(T,X,Y)).

+!move(E) : move(E). 
+!move(E) : .my_name(N) & status(N,T,_,_) & base_emer(T) 			<- ?status(A,T,b,_); !move(A). //moves to base if declared emergency state
+!move(E) : .my_name(N) & pos(N,A,B) & pos(E,X,Y) & X = A & Y = B	<- .print("We are on top of the target").
+!move(E) : .my_name(N) & pos(N,A,B) & pos(E,X,Y) & X > A			<- .print("Moving on east"); move_east(N); !move(E).
+!move(E) : .my_name(N) & pos(N,A,B) & pos(E,X,Y) & X < A			<- .print("Moving on west"); move_west(N); !move(E).
+!move(E) : .my_name(N) & pos(N,A,B) & pos(E,X,Y) & X = A & B > Y 	<- .print("Moving on north"); move_north(N); !move(E).
+!move(E) : .my_name(N) & pos(N,A,B) & pos(E,X,Y) & X = A & B < Y 	<- .print("Moving on south"); move_south(N); !move(E).
+!move(E) 															<- .print("I can't figure out where to move'").

+!death_check : .my_name(N) & status(N,_,_,H) & H = 0 <- remove(N); .kill_agent(N).
+!death_check <- !search.

+!base_check : .my_name(N) & status(N,T,_,_) & base_heal(T) <- ?pos(X,T,_,_); !travel(X).
+!base_check.

+!emer_check : .my_name(N) & status(N,T,_,_) & base_emer(T) <- ?pos(X,T,_,_); !travel(X).
+!emer_check.