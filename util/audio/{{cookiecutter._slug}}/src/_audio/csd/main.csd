;;  main.csd -*- mode: csound -*-
;;  Combined orchestra and score
;; .csd
<CsoundSynthesizer>
<CsOptions>
;; -o main.wav
-o dac
+rtaudio=jack
;; --realtime
</CsOptions>
<CsInstruments>
#include "opcodes/example.op"
#include "instruments/example.inst"

sr      = 48000
ksmps   = 64
nchnls  = 2
0dbfs   = 1


</CsInstruments>
<CsScore>
i "JGInst" 0 2 400
i "JGInst" 2 2 500
</CsScore>
</CsoundSynthesizer>
