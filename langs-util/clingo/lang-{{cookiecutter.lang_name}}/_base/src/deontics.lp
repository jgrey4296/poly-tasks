% -*- mode:pasp; -*-
% Purpose:
%
%
% Outputs:

#external deonticTypes(T).
#external eventType(E, I, Inst).


% All Institutions have norm fluents for all institution events
inertialFluent(deontic(D, Ev), Ins) :- institution(Ins), deonticTypes(D), eventType(Ev, Ins, inst).

% Null permissions hold from the start
inertialFluent(deontic(D, null), Ins) :- institution(Ins), deonticTypes(D), eventType(Ev, Ins, inst).

holdsat(deontic(D, null), Ins, I) :- start(I), institution(Ins), deonticTypes(D).

% every insitutional action has a (potential) violation:
eventType(violation(Ev), Ins, viol)    :- eventType(Ev, Ins, inst).

% convert an event that lacks the permission for its performance,
% into an occurrence of a violation event
occurred(violation(E), In, I):- instant(I),
                                institution(In),
                                eventType(E, In, inst),
                                holdsat(live(In), In, I),
                                occurred(E, In, I),
                                not holdsat(deontic(permitted, E), In, I).

_deontics.
