% -*- mode:pasp; -*-
% Purpose:
%
%
% Outputs:



% obligation completion is an institutional event itself:
% ie: doneRequirement != doneObligationOf(doneRequirement).
eventType(obligation(N, requirement, R), Ins, inst) :- obligationFluent(obligation(N, R, _, _), Ins).
eventType(obligation(N, deadline,    D), Ins, inst) :- obligationFluent(obligation(N, _, D, _), Ins).
eventType(obligation(N, violation,   V), Ins, inst) :- obligationFluent(obligation(N, _, _, V), Ins).

% obligation fluents are also inertial:
inertialFluent(F, I) :- obligationFluent(F, I).

% the obligation violation is a general violation
eventType(violation(V), Ins, viol) :- obligationFluent(obligation(_, _, _, V), Ins).
occurred(violation(V),  Ins, I)    :- instant(I),
                                      institution(Ins),
                                      eventType(obligation(N, violation, V), Ins, inst),
                                      holdsat(obligation(N, _, _, V), Ins, I),
                                      occurred(obligation(N, violation, V), Ins, I).

% to perform the obligation requirement:
occurred(obligation(N, requirement, R), Ins, I) :- instant(I),
                                                   institution(Ins),
                                                   event(R),
                                                   eventType(obligation(N, requirement, R), Ins, inst),
                                                   holdsat(obligation(N, R, _, _), Ins, I),
                                                   occurred(R, Ins, I).

% trigger an obligation violation if the violating event occurs:
occurred(obligation(N, violation, V), Ins, I) :- instant(I),
                                                 institution(Ins),
                                                 event(V),
                                                 eventType(obligation(N, violation, V), Ins, inst),
                                                 holdsat(obligation(N, _, _, V), Ins, I),
                                                 occurred(V, Ins, I).

% trigger a deadline event:
occurred(obligation(N, deadline, D), Ins, I) :- instant(I),
                                                institution(Ins),
                                                event(D),
                                                eventType(obligation(N, deadline, D), Ins, inst),
                                                holdsat(obligation(N, _, D, _), Ins, I),
                                                occurred(D, Ins, I).


% An obligation terminates if it holds when it reaches its deadline
% regardless of if its an achievement or maintenance obligation
terminated(obligation(N, R, D, V), Ins, I) :- instant(I),
                                              institution(Ins),
                                              event(obligation(N, deadline, D)),
                                              holdsat(obligation(N, R, D, V), Ins, I),
                                              occurred(obligation(N, deadline, D), Ins, I).


% An obligation terminates once its requirement is completed before the deadline
% *if* it is an achievement obligation
terminated(obligation(N, R, D, V), Ins, I) :- instant(I),
                                              institution(Ins),
                                              event(obligation(N, requirement, R)),
                                              obligationType(N, achievement, Ins),
                                              holdsat(obligation(N, R, D, V), Ins, I),
                                              occurred(obligation(N, requirement, R), Ins, I).

% or an obligation terminates if it is violated,
% *if* it is an achievement obligation
terminated(obligation(N, R, D, V), Ins, I) :- instant(I),
                                              institution(Ins),
                                              obligationType(N, achievement, Ins),
                                              event(obligation(N, violation, V)),
                                              holdsat(obligation(N, R, D, V), Ins, I),
                                              occurred(obligation(N, violation, V), Ins, I).


% reject all obligations that aren't well formed
:- obligationType(N, T, _), not obligationTypes(T).
% reject same named obligations of different types in the same institution
:- obligationType(N, T, I), obligation(N, T2, I), institution(I), T != T2.

_obligation.
