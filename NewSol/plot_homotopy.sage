#!/usr/bin/env sage

import itertools

f1 = x^3 - 1

f2 = (8*x^3 - 4*x^2 - 18*x + 9)/20

solutions = []

for i in range(101):
    f = (1-(i/100)) * f1 + (i/100) * f2;
    unsorted_solutions = [N(sol[0]) for sol in f.roots()]
    if i == 0:
        sorted_solutions = unsorted_solutions
    else:
        difference = 1
        for permutation in itertools.permutations(unsorted_solutions):
            candidate_difference = sum(abs(a-b) for a,b
                                         in zip(permutation, last_solutions))
            if candidate_difference < difference:
                difference = candidate_difference
                sorted_solutions = permutation
    last_solutions = sorted_solutions
    solutions.append(sorted_solutions)

for j in range(3):
    for i,solution in enumerate(solutions):
        sol = solution[j]
        print ("(", real(sol), ",", imag(sol), ",", RR(4*i/100), ")")
    print()
    print()
