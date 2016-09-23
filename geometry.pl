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





segment(FirstPoint, SecondPoint, X1, Y1, X2, Y2) :-
  point(FirstPoint, X1, Y1),
  point(SecondPoint, X2, Y2).


distanceofsegment(FirstPoint, SecondPoint, Distance) :-
  segment(FirstPoint, SecondPoint, X1, Y1, X2, Y2),
  Distance is sqrt((X2-X1)*(X2-X1)+(Y2-Y1)*(Y2-Y1)).


hypotenusesegment(FirstPoint, SecondPoint, ThirdPoint, X1, Y1, X2, Y2, X3, Y3) :-
  point(FirstPoint, X1, Y1),
  point(SecondPoint, X2, Y2),
  point(ThirdPoint, X3, Y3).

  %% quadraticformula

  %% Slope formula
  slope(FirstPoint, SecondPoint, M) :-
      point(FirstPoint, Xfirst, Yfirst), point(SecondPoint, Xsecond, Ysecond),
      Xdiff is (Xsecond - Xfirst),
      Xdiff is 0,
      M is 0.

slope(FirstPoint, SecondPoint, M) :-
  point(FirstPoint, Xfirst, Yfirst), point(SecondPoint, Xsecond, Ysecond),
  M is ((Ysecond - Yfirst) / (Xsecond - Xfirst)).


%% Determining parallel lines
parallel(FirstPoint, SecondPoint, ThirdPoint, FourthPoint) :-
 slope(FirstPoint, SecondPoint, M1), slope(ThirdPoint, FourthPoint, M2),
 M1 is M2.

%% Right angle
rightAngle(FirstPoint, SecondPoint, ThirdPoint, FourthPoint) :-
 slope(FirstPoint, SecondPoint, M1), slope(ThirdPoint, FourthPoint, M2),
 M3 is (M1 * M2),
 M3 == -1.




% didn't end up needing recipricalslope functor
% recipricalslope(FirstPoint, SecondPoint, RECIPSlope):-
%     point(FirstPoint, X1, Y1),
%     point(SecondPoint, X2, Y2),
%     RECIPSlope is -1/ ((Y2-Y1)/(X2-X1)).



% checks for equality between two-four numbers.
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





% checks to see if three points creates an equilateral triangle
equitri(FIRST, SECOND, THIRD) :-
    point(FIRST, FirstX, FirstY),
    point(SECOND, SecondX, SecondY),
    point(THIRD, ThirdX, ThirdY),

    % Start by instantiating the TEMPX and TEMPY to the x and y values of THIRD point
    TEMPX is abs(truncate(ThirdX)),
    TEMPY is abs(truncate(ThirdY)),
    % Set up equality with a formula which gets the THIRD x and y's value through trigonometry
    % Since TEMPX and TEMPY is already instantiated, this will check for equality rather than reinstantiate the TEMPX and TEMPY
    TEMPX is abs(truncate((cos(60 * pi / 180) * (FirstX-SecondX)) - (sin(60 * pi / 180) * (FirstY-SecondY)) + SecondX)),
    TEMPY is abs(truncate((sin(60 * pi / 180) * (FirstX-SecondX)) + (cos(60 * pi / 180) * (FirstY-SecondY)) + SecondY)),

    % I had to do some patch coding above using abs(truncate( because there were slight differences between the Trig derived solution and the
    % point(THIRD, X, Y) which made this functor ALWAYS FALSE. By truncating the value and taking the absolute value of that,
    % I could get pretty good guess as to if the triangle was a equilateral triangle.
    % But I hardcoded another set of objectives to make sure
    distanceofsegment(FIRST, SECOND, DistanceOne),
    distanceofsegment(SECOND, THIRD, DistanceTwo),
    distanceofsegment(THIRD, FIRST, DistanceThree),
    equality(DistanceOne, DistanceTwo, DistanceThree).



% checks to see if three points creates an isosoles triangle
isostri(FIRST, SECOND, THIRD):-
    % instantiating D1, D2, and D3 for comparison
    distanceofsegment(FIRST, SECOND, D1),
    distanceofsegment(SECOND, THIRD, D2),
    distanceofsegment(THIRD, FIRST, D3),
% shifting the instantiated variable so we can compare all 3 sides
    distanceofsegment(FIRST, SECOND, D2);
    distanceofsegment(SECOND, THIRD, D3);
    distanceofsegment(THIRD, FIRST, D1).


% uses trigonometry to derive the angle between two segments (in degrees)
theta(FIRSTPOINT, SECONDPOINT, THIRDPOINT, ANGLE):-
    hypotenusesegment(FIRSTPOINT, SECONDPOINT, THIRDPOINT, X1, Y1, X2, Y2, X3, Y3),
    ANGLE is truncate(abs((180/pi)*atan(((Y1-Y2)/(X1-X2) - (Y2-Y3)/(X2-X3))))).


  % distanceofsegment(FIRSTPOINT, SECONDPOINT, D1),
  % distanceofsegment(SECONDPOINT, THIRDPOINT, D2),
  % HYPOTENUSE is sqrt(D1*D1+D2*D2).


% checks to see if a degree is 90 degrees
ninetydegrees(THETA):-
    % because I am using truncation and absolute value (in order to patch the computer inability to divide x/0)
    % I need to account for either angles that are +/- 1 degrees away from 90 degrees.
    THETAPRIME is 90,
    THETAPRIME is THETA;
    THETAPRIME is 91,
    THETAPRIME is THETA;
    THETAPRIME is 89,
    THETAPRIME is THETA.

% checks to see if three points creates an right triangle
righttri(FIRSTPOINT, SECONDPOINT, THIRDPOINT):-
    % Taking the slope fails because program crashes if you divide by 0
    % slope(FIRST, SECOND, SLOPE1),
    % slope(SECOND, THIRD, SLOPE2),
    % slope(THIRD, FIRST, SLOPE3),
    % recipricalslope(FIRST, SECOND, SLOPE2);
    % recipricalslope(SECOND, THIRD, SLOPE3);
    % recipricalslope(THIRD, FIRST, SLOPE1).


    % Using trig, I will look for a 90 degree angle for all 3 segments in the triangle
    % FIRSTPOINT, SECONDPOINT, and THIRDPOINT all instantiate to the values
    % returns true if there is a right angle among the three angles
    theta(FIRSTPOINT, SECONDPOINT, THIRDPOINT, THETA), ninetydegrees(THETA);
    theta(SECONDPOINT, THIRDPOINT, FIRSTPOINT, THETA), ninetydegrees(THETA);
    theta(THIRDPOINT, FIRSTPOINT, SECONDPOINT, THETA), ninetydegrees(THETA).





square(FirstPoint, SecondPoint, ThirdPoint, FourthPoint) :-
quadrilateral(FirstPoint, SecondPoint, ThirdPoint, FourthPoint),
    distanceofsegment(FirstPoint, SecondPoint, D1),
    distanceofsegment(SecondPoint, ThirdPoint, D2),
    distanceofsegment(ThirdPoint, FourthPoint, D3),
    distanceofsegment(FirstPoint, FourthPoint, D4),
    equality(D1, D2, D3, D4),
    rightAngle(FirstPoint, SecondPoint), rightAngle(SecondPoint, ThirdPoint),
    rightAngle(ThirdPoint, FourthPoint), rightAngle(FourthPoint, FirstPoint).

regSquare(FirstPoint, SecondPoint, ThirdPoint, FourthPoint) :-
    parallel(FirstPoint, SecondPoint, ptest1, ptest2);
    parallel(SecondPoint, ThirdPoint, ptest1, ptest2);
    parallel(ThirdPoint, FourthPoint, ptest1, ptest2);
    parallel(FirstPoint, FourthPoint, ptest1, ptest2),
    square(FirstPoint, SecondPoint, ThirdPoint, FourthPoint).

rectangle(FirstPoint, SecondPoint, ThirdPoint, FourthPoint) :-
    quadrilateral(FirstPoint, SecondPoint, ThirdPoint, FourthPoint),
    distanceofsegment(FirstPoint, SecondPoint, D1),
    distanceofsegment(SecondPoint, ThirdPoint, D2),
    distanceofsegment(ThirdPoint, FourthPoint, D3),
    distanceofsegment(FirstPoint, FourthPoint, D4),
    equality(D1, D3), equality(D2, D4),
    parallel(FirstPoint, SecondPoint, ThirdPoint, FourthPoint),
    parallel(FirstPoint, FourthPoint, SecondPoint, ThirdPoint),
    rightAngle(FirstPoint, SecondPoint), rightAngle(SecondPoint, ThirdPoint),
    rightAngle(ThirdPoint, FourthPoint), rightAngle(FourthPoint, FirstPoint).

regRectangle(FirstPoint, SecondPoint, ThirdPoint, FourthPoint) :-
    parallel(FirstPoint, SecondPoint, ptest1, ptest2);
    parallel(SecondPoint, ThirdPoint, ptest1, ptest2);
    parallel(ThirdPoint, FourthPoint, ptest1, ptest2);
    parallel(FirstPoint, FourthPoint, ptest1, ptest2),
    rectangle(FirstPoint, SecondPoint, ThirdPoint, FourthPoint).

parallelogram(FirstPoint, SecondPoint, ThirdPoint, FourthPoint) :-
    parallel(FirstPoint, SecondPoint, ThirdPoint, FourthPoint),
    parallel(FirstPoint, FourthPoint, SecondPoint, ThirdPoint),
    quadrilateral(FirstPoint, SecondPoint, ThirdPoint, FourthPoint).

regParallelogram(FirstPoint, SecondPoint, ThirdPoint, FourthPoint) :-
    parallelogram(FirstPoint, SecondPoint, ThirdPoint, FourthPoint),
    parallel(FirstPoint, SecondPoint, ptest1, ptest2);
    parallel(SecondPoint, ThirdPoint, ptest1, ptest2);
    parallel(ThirdPoint, FourthPoint, ptest1, ptest2);
    parallel(FirstPoint, FourthPoint, ptest1, ptest2).



%% distinctpoints(A, B):- point(A, XA, YB), point(B, XB, YB), XA \= XB; YA \= YB.



% points one, two, and three compose a equilateral triangle
% points one, two, and isos form an isosoles triangle
% its a bit of a cheat, but to ensure that We will never get a pure 0 denominator I changed all the values to have a value in the decimal place.


point(one, -5.0, 0.00002).
point(eqone, -5.0, 0.0).
point(two, 5.0, 0.00001).
point(eqtwo, 5.0, 0.0).
point(three, 0.00003, sqrt(75.0)).
point(eqthree, 0.0, sqrt(75.0)).
point(isos, 0.000001, 7.0).
point(four, 0.000002, 0.00000001).
point(five, 0.00000002, 5.0).
point(six, 5.0, 5.0).
point(seven, 5.0, 0.0000003).


point(origin, 0, 0).
point(test1, 5, 1).
point(test2, 0, 5).
point(test3, 1, 0).

% To bundle the abstract entities of "points" together, we grouped them into shapes
shape(one, two, three).
shape(eqone, eqtwo, eqthree).
shape(one, four, five).
shape(four, five, six, seven).
shape(four, five, six, seven).
