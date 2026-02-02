#!/usr/bin/env -S clips -f2
(load rules.clp)
(load facts.clp)

(assert (duck))
(facts)

(rules)

(exit)
