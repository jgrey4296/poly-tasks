;;; {{cookiecutter.proj_name}}.z3 -*- z3 -*-
;;; z3 {filename}

(echo "Starting {{cookiecutter.proj_name}} z3 ")

(declare-const a Int)
(declare-const b Int)
(declare-const c Int)
(declare-fun val (Int Int) Int)

(assert (> a 5))
(assert (> b a))
(assert (> 10 b))
(assert (= (val a b) 13))

(check-sat)
(get-model)
