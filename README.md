# Geometry Micro World Project

### By | Kathryn Mechura and Andrew Lee

Using Prolog, we created a series of dictionary entries and defitions to create a universe of geometry.

We used two kinds of structures to carry this out. The point structure defines a name, the X coordinate, and the Y coordinate, while the shape structure bundles together different points as one cohesive unit.

## We have the following functions defined in our geometry.pl file.

Func Name | Definition
-------- | ---------------------------------------------------
equitri | Given 3 names within the point funcdor, it will try to unify with the defitions of the derived segment length (using a trigonometric function) and a distance function between the 3 points to determine if the length is the same for all.
isostri | Given 3 point values, it will return true if the values create an isosoles triangle, where two or more values of the segment are equal.
righttri | Given 3 point values, it will get the segment information, and using trigonometry, it will unify to any set to see whether any of the angles are 90 degrees.
square | Given 3 points, it will unify with the values which give a square
regSquare | (Similar)
rectangle | (Similar)
regRectangle | (Similar)
parallelogram | (Similar)
regParallelogram | (Similar)



##Here are some sample values that we created in order to test the function
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


    shape(one, two, three).
    shape(four, five, six, seven).
    shape(four, five, six, seven).
    shape(eqone, eqtwo, eqthree).
    shape(one, four, five)


The reason why there are some random numbers very close to 0 on some of them is because Prolog does not have the ability to compute a 0 deminator arithmetic operation. This was just a way to temporarily cheat the system to get the arithmetic to solve, but then to fix it later using truncations and absolute values.

Because the equilateral has a specific function definition that does not reuse funcdors from other funcdors, it needs non arbitrary decimal values in order to compute correctly.



In order to try it out, download the geometry.pl file, start a gnu-prolog

    gprolog
interpreter session, and load the document via the
    [geometry].
command. To test the functions, you need to use a specific named point, such as
    one
    two
    three
    four
    ...
or
    eqone
    eqtwo
    eqthree

in the case of an equilateral triangle.
