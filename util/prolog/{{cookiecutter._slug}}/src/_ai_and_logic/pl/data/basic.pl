% basic.pl -*- mode: Prolog -*-

%% people
person(bob).
person(bill).
person(jill).

%% food
food(curry).
food(salad).
food(burger).

%% places
place(london).
place(ny).
place(cairo).

%% relations
likes(bob, curry).
likes(bill, salad).
likes(jill, burger).
likes(jill, salad).

%% lives_in
lives_in(bob, london).
lives_in(bill, ny).
lives_in(jill, cairo).
