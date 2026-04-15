; test.clips -*- mode: Clips -*- 

;;;======================================================
;;; Ruleset:
;;;
;;;
;;;
;;;
;;;======================================================

(defmodule RULES
  (export deftemplate example)
  )

;;-- templates
(deftemplate RULES::example
  (slot name (type STRING))
  )

;;-- end templates

;;-- inital state
(deffacts RULES::initial-positions
  (example (name "bob")
           )
  )
;;-- end inital state

;;-- rules
(defrule RULES::test-rule
  ?node <- (example (name ?name))
 =>
  (retract ?node)
  )
;;-- end rules
