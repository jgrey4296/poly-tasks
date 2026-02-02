% rules.pl -*- mode: Prolog -*-
:- module({{cookiecutter.proj_name}}_rules,
          [
              getPairedPerson/2
          ]).

getPairedPerson(X, Y) :- person(X),
                         place(Y),
                         food(Z),
                         likes(X, Z),
                         lives_in(X, Y).
