% -*- mode:pasp; -*-
% Purpose:
%
%
% Outputs:

#external institution(I).

% The null event:
eventType(null, Ins, ex) :- institution(Ins).
% Generate 1 event per timestep, except steps where an event has been externally set/queried
1 {genObserved(E, J) : eventType(E, In, ex), institution(In)} 1 :- instant(J),
                                                                   not final(J),
                                                                   not extObserved(_, J).

% Observe events set externally if they are valid, or register the conflict
recEvent(I) :- instant(I),
               event(E),
               extObserved(E, I),
               not final(I).

extObserved(_unrecognisedEvent, I) :- _eventSet(I), not recEvent(I).

% Flatten external and generated events into one type.
observed(E, I)     :- extObserved(E, I), not final(I).
observed(E, I)     :- genObserved(E, I), not final(I).

% If multiple events are observed, they are the same but in different institutions
:- instant(J),
   institution(InX;InY),
   eventType(E, InX, ex),
   eventType(F, InY, ex),
   observed(E, J),
   observed(F, J),
   E!=F.

% All Instants have an observed event, even if its just null
observed(I) :- observed(_, I), instant(I).
:- instant(I), institution(In), not observed(I), not final(I).


_observation.
