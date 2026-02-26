(*  list.v -*- mode: coq -*-  *)
(*
Summary:

Tags:
 *)
From Stdlib Require Export Lists.List.
Export ListNotations.
From Stdlib Require Export Strings.String.
Export StringSyntax.
From Stdlib Require Relations.
Export Relations.

Open Scope string_scope.

Check [1;2] : list nat.

(* About list. *)
(* Show Match list. *)
(* Print Scopes. *)


Fixpoint contains (xs : list string) (x : string) : bool :=
  match xs return bool with
  | nil => false
  | cons x' xs' => if x =? x' then true else contains xs' x
  end.

Notation "X 'isin' Y" := (contains Y X) (at level 50) : list_scope.

Section Testing.
  Compute ["a" ; "b"].
  Compute contains ["a"; "b"] "a".
  Compute "c" isin ["a";"b"].
End Testing.
