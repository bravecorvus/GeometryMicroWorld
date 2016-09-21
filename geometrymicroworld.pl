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
  triangle(FirstPoint, SecondPoint, ThirdPoint), point(FirstPoint, X1, Y1), point(SecondPoint, X2, Y2).


%% GETTING THE SEGMENT OF TWO POINTS OF A QUADRILATERAL
segment(FirstPoint, SecondPoint, X1, Y1, X2, Y2) :-
  quadrilateral(FirstPoint, SecondPoint, ThirdPoint, FourthPoint),
  point(FirstPoint, X1, Y1),
  point(SecondPoint, X2, Y2).

distanceofsegment(FirstPoint, SecondPoint, Distance) :-
  segment(FirstPoint, SecondPoint, X1, Y1, X2, Y2),
  Distance is sqrt((X2-X1)*(X2-X1)+(Y2-Y1)*(Y2-Y1)).
  
  %% Distance is sqrt(DistanceSquared).

equality(ELEM1, ELEM2) :-
  ELEM1 is ELEM2; ELEM2 is ELEM1.

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



%% square(FirstPoint, SecondPoint, ThirdPoint, FourthPoint) :-
%%     quadrilateral(FirstPoint, SecondPoint, ThirdPoint, FourthPoint),
%%     point(FirstPoint, X, Yfirst), point(SecondPoint, )








%% int main() {
point(one, -5.0, 0.0).
point(two, 5.0, 0.0).
point(three, 0.0, sqrt(75.0)).
shape(one, two, three).
shape(four, five, six, seven).
point(four, 0, 0).
point(five, 0, 5).
point(six, 5, 5).
point(seven, 5, 0).
%% }


%% (testing a hardcode version of the trig function used in the equilateraltriangle definition)
%% TEMPX is ((cos(60 * pi / 180) * (-5.0-5.0)) - (sin(60 * pi / 180) * (0)) + 5.0) 
%% TEMPY is ((sin(60 * pi / 180) * (-5-5)) + (cos(60 * pi / 180) * (0)) + 0)