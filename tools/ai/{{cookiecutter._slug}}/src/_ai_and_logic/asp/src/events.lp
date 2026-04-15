% -*- mode:pasp; -*-
% Purpose:
%
%
% Outputs:

#external eventTypes(X).
#external eventType(E, I, Etype).

initiated.
terminated.
occurred.

event(null)                               :- 1  == 2.
eventType(null, null, null)               :- 1  == 2.
occurred(null, null)                      :- 1  == 2.
initiated(0, 0, 0)                        :- 1  == 2.
terminated(0, 0, 0)                       :- 1  == 2.

%% All Event Types define events:
event(Ev) :- eventType(Ev, _, _).

% All institutions have a null event type:
eventType(null, Ins, inst) :- institution(Ins).

% All Events are associated with institutions
eventInst(Ev, Ins) :- eventType(Ev, Ins, _).

%% Institutional null occurrence when nothing can be recognised:
{ occurred(null, In, I) } :- instant(I),
                             institution(In),
                             not occurred(_, I).


%% Reject any model with a faulty event type:
:- eventType(_, _, T), not eventTypes(T).
% Reject any model where nothing happens on a timestep
:- instant(I), institution(In), not occurred(_, In, I).

_events.
