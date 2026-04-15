% -*- mode:pasp; -*-
% Purpose:
%
%
% Outputs:

#external _time.
#external fluentTypes(T).
#external intertialFluentTypes(T).


inertialFluent(deontic(Power, ev(Source, Fluent, Sink), Bridge) :- bridge(Bridge Source, Sink),
                                                                   bridgeDeonticTypes(Power),
                                                                   inertialFluent(Fluent, Sink),
                                                                   rhs.

% All inertial and transient fluents are fluents
fluent(F) :- inertialfluent(F, I).
fluent(F) :- transientFluent(F, I).

% inertialFluentChange(fact, inst, time, type)
inertialFluentChange(P, In, I, initiated)    :- instant(I),
                                                institution(In),
                                                inertialFluent(P, In),
                                                initiated(P, In, I).

inertialFluentChange(P, In, I, terminated)   :- instant(I),
                                                institution(In),
                                                inertialFluent(P, In),
                                                terminated(P, In, I).

% Cross-institution fluent changes
inertialFluentChange(P, Sink, I, initiated)  :- instant(I),
                                                institution(Source),
                                                institution(Sink),
                                                inertialFluent(P, Sink),
                                                xInitiated(Source, P, Sink, I).


inertialFluentChange(P, Sink, I, terminated) :- instant(I),
                                                institution(Source),
                                                institution(Sink),
                                                inertialFluent(P, Sink),
                                                xTerminated(Source, P, Sink, I).


% Translate external fluent setting to holding at the start of the trace
holdsat(F, I, J)						:- extHoldsat(F, I), start(J), inertialFluent(F, I).

% Propagate inertial fluents across timesteps:
holdsat(P, In, J)						:- next(I, J),
                               institution(In),
                               inertialFluent(P, In),
                               inertialFluentChange(P, In, I, initiated).

holdsat(P, In, J)						:- next(I, J),
                               institution(In),
                               inertialFluent(P, In),
                               holdsat(P, In, I),
                               not inertialFluentChange(P, In, I, terminated).


% Institutions also hold by default at the start:
% (which includes bridges, because they are institutions)
inertialFluent(live(Ins), Ins) :- institution(Ins).
holdsat(live(Ins), Ins, I)     :- start(I), institution(Ins).

% Reject all inertialFluent changes that aren't well formed:
:- inertialFluentChange(_, _, _, T), not inertialFluentChangeTypes(T).
:- inertialFluentChange(F, _, _, _), not inertialFluent(F, _).

_fluents.
