%% Definitions
triangle(A, B, C) :- shape(A, B, C);
                    shape(A, C, B);
                    shape(B, A, C);
                    shape(B, C, A);
                    shape(C, A, B);
                    shape(C, B, A).
                    
                    
                    


quadrilateral(A, B, C, D) :- shape(A, B, C, D);
                              shape(A, B, D, C);
                              shape(A, C, B, D);
                              shape(A, C, D, B);
                              shape(A, D, C, B);
                              shape(A, D, B, C);
                              shape(B, A, C, D);
                              shape(B, A, D, C);
                              shape(B, C, A, D);
                              shape(B, C, D, A);
                              shape(B, D, A, C);
                              shape(B, D, C, A);
                              shape(C, A, B, D);
                              shape(C, A, D, B);
                              shape(C, B, A, D);
                              shape(C, B, D, A);
                              shape(C, D, A, B);
                              shape(C, D, B, A);
                              shape(D, A, B, C);
                              shape(D, A, C, B);
                              shape(D, B, A, C);
                              shape(D, B, C, A);
                              shape(D, C, A, B);
                              shape(D, C, B, A).


%% distinctpoints(A, B):- point(A, XA, YB), point(B, XB, YB), XA \= XB; YA \= YB.


%% GETTING THE SEGMENT OF A TWO POINTS OF A TRIANGLE
segment(FirstPoint, SecondPoint, X1, Y1, X2, Y2) :-
  point(FirstPoint, X1, Y1), point(SecondPoint, X2, Y2).



distanceofsegment(FirstPoint, SecondPoint, Distance) :-
  segment(FirstPoint, SecondPoint, X1, Y1, X2, Y2),
  Distance is sqrt((X2-X1)*(X2-X1)+(Y2-Y1)*(Y2-Y1)).
  
  %% Distance is sqrt(DistanceSquared).

equality(ELEM1, ELEM2) :-
  ELEM1 is ELEM2; ELEM2 is ELEM1.


%% equalitydist(DISTANCE1, DISTANCE2):-
%%   point(POINT1, X1, Y1),
%%   point(POINT2, X2, Y2),
%%   distanceofsegment

%% point(one, -5.0, 0.0).
%% point(two, 5.0, 0.0).


equality(ELEM1, ELEM2, ELEM3) :-
  ELEM1 is ELEM2; ELEM2 is ELEM1,
  ELEM2 is ELEM3; ELEM3 is ELEM2,
  ELEM3 is ELEM1; ELEM1 is ELEM3.

equality(ELEM1, ELEM2, ELEM3, ELEM4) :-
  ELEM1 is ELEM2; ELEM2 is ELEM1,
  ELEM2 is ELEM3; ELEM3 is ELEM2,
  ELEM3 is ELEM4; ELEM4 is ELEM3,
  ELEM4 is ELEM1; ELEM1 is ELEM4.

%% quadraticformula

%%Slope formula
slope(FirstPoint, SecondPoint, M) :-
	point(FirstPoint, Xfirst, Yfirst), point(SecondPoint, Xsecond, Ysecond),
	M is ((Ysecond - Yfirst) / (Xsecond - Xfirst)).

%%Determining parallel lines
parallel(FirstPoint, SecondPoint, ThirdPoint, FourthPoint) :-
	slope(FirstPoint, SecondPoint, M1), slope(ThirdPoint, FourthPoint, M2),
	M1 is M2.

equilateraltriangle(FIRST, SECOND, THIRD) :-
%% Part 1: Using Trigonometry to Find exact Location of the (x, y) coordinates for the THIRD option
    %% triangle(FIRST, SECOND, THIRD),
    point(FIRST, FirstX, FirstY),
    point(SECOND, SecondX, SecondY),
    point(THIRD, ThirdX, ThirdY),
    %% THERES NOT AN EFFICIENT WAY TO HAVE THE INTERPRETER CHECK FOR A RANGE, SO I TRUNCATED THE NUMBERS AND GOT THE ABSOLUTE VALUE
    TEMPX is abs(truncate(ThirdX)),
    TEMPX is abs(truncate((cos(60 * pi / 180) * (FirstX-SecondX)) - (sin(60 * pi / 180) * (FirstY-SecondY)) + SecondX)),
    TEMPY is abs(truncate(ThirdY)),
    TEMPY is abs(truncate((sin(60 * pi / 180) * (FirstX-SecondX)) + (cos(60 * pi / 180) * (FirstY-SecondY)) + SecondY)),
    %% BECAUSE I LOST ACCURACY AT THE POINT I ADDED THE abs(truncate(...)) COMMAND, I ADDED SEPARATE METHOD TO DOUBLE CHECK THE 
    %% LENGTHS OF ALL THE SEGMENTS, BECAUSE EQUALATERAL BY DEFINITION HAS 3 EQUAL SIDES
    distanceofsegment(FIRST, SECOND, DistanceOne),
    distanceofsegment(SECOND, THIRD, DistanceTwo),
    distanceofsegment(THIRD, FIRST, DistanceThree),
    equality(DistanceOne, DistanceTwo, DistanceThree).


isosolestriangle(FIRST, SECOND, THIRD):-
    triangle(FIRST, SECOND, THIRD),
    distanceofsegment(FIRST, SECOND, DistanceOne),
    distanceofsegment(SECOND, THIRD, DistanceTwo),
    distanceofsegment(THIRD, FIRST, DistanceThree),

    %% DistanceOne is DistanceTwo;
    %% DistanceTwo is DistanceThree.
    %% DistanceThree is DistanceOne.

    %% DistanceOne is DistanceTwo; DistanceTwo is DistanceOne;
    %% DistanceTwo is DistanceThree; DistanceThree is DistanceTwo;
    %% DistanceThree is DistanceOne; DistanceOne is DistanceThree.
    

    equality(DistanceOne, DistanceTwo),
    equality(DistanceTwo, DistanceThree),
    equality(DistanceThree, DistanceOne).

%%     switch(equality(D1, D2, D3), [
%%     equality(D2, D2),
%%     b : writeln(case2),
%%     c : writeln(case3)
%% ])



square(FirstPoint, SecondPoint, ThirdPoint, FourthPoint) :-
    quadrilateral(FirstPoint, SecondPoint, ThirdPoint, FourthPoint),
    distanceofsegment(FirstPoint, SecondPoint, D1), 
    distanceofsegment(SecondPoint, ThirdPoint, D2), 
    distanceofsegment(ThirdPoint, FourthPoint, D3),
    distanceofsegment(FirstPoint, FourthPoint, D4),
    equality(D1, D2, D3, D4).

regSquare(FirstPoint, SecondPoint, ThirdPoint, FourthPoint) :-
	square(FirstPoint, SecondPoint, ThirdPoint, FourthPoint),
	parallel(FirstPoint, SecondPoint, ptest1, ptest2);
	parallel(SecondPoint, ThirdPoint, ptest1, ptest2);
	parallel(ThirdPoint, FourthPoint, ptest1, ptest2);
	parallel(FirstPoint, FourthPoint, ptest1, ptest2).

%%rectangle(FirstPoint, SecondPoint, ThirdPoint, FourthPoint) :-
%%	quadrilateral(FirstPoint, SecondPoint, ThirdPoint, FourthPoint),
%%	distanceofsegment(FirstPoint, SecondPoint, D1),
%%	distanceofsegment(SecondPoint, ThirdPoint, D2), 
%%  distanceofsegment(ThirdPoint, FourthPoint, D3),
%%    distanceofsegment(FirstPoint, FourthPoint, D4),
%%    equality(D1, D3), equality(D2, D4),
%%    parallel(FirstPoint, SecondPoint), 


%% int main() {
point(ptest1, 1, 0).
point(ptest2, 5, 0).
point(one, -5.0, 0.0).
point(two, 5.0, 0.0).
point(three, 0.0, sqrt(75.0)).
point(isos, 0.0, 7.0).

point(four, 0, 0).
point(five, 0, 5).
point(six, 5, 5).
point(seven, 5, 0).

shape(one, two, three).
shape(one, two, isos).
shape(four, five, six, seven).

%% }


%% (testing a hardcode version of the trig function used in the equilateraltriangle definition)
%% TEMPX is ((cos(60 * pi / 180) * (-5.0-5.0)) - (sin(60 * pi / 180) * (0)) + 5.0)
%% TEMPY is ((sin(60 * pi / 180) * (-5-5)) + (cos(60 * pi / 180) * (0)) + 0)
