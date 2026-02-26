(*  tree.v -*- mode: coq -*-  *)
(*
Summary:

Tags:
 *)
Set Implicit Arguments.

From Stdlib Require Export Lists.List.
From Stdlib Require Export Strings.String.
From Stdlib Require Relations.

From JG.util Require Import notations.

Module Tree.

  Inductive tree (A : Set) : Set :=
  | Leaf : A -> tree A
  | Node : (tree A) -> (tree A) -> tree A
  .

  Inductive tree_b (A:Set) : Set :=
  | LeafB (_ : A) (_ : tree_b A)
  | NodeB (_:tree_b A) (_:tree_b A)
  .

  Declare Scope TreeScope.
  Notation "A |>" := (Leaf A) (at level 81, left associativity) : TreeScope.
  Notation "<| A" := (Leaf A) (at level 82, right associativity) : TreeScope.
  Notation "<> B C " := (Node B C) (at level 80, B at next level, C at next level) : TreeScope.

End Tree.

Module TreeFns.
  Import Tree.


End TreeFns.


Section TreeUsage.
  Import Tree.

  Check Leaf.
  Check Leaf true.
  Check Node (Leaf true) (Leaf true).
  Check Leaf 2.
  Check Node (Leaf 2) (Node (Leaf 3) (Leaf 4)).

  Check LeafB 2.
  Check LeafB true.
End TreeUsage.


Section TreeNotationUsage.
  Import Tree.
  Open Scope TreeScope.
  Check true |>.
  Check <| false.
  Check (<| true).
  Check <> (<| true) (true |>).

  Unset Printing Notations.
  Check >| 2 <> >| 3
        <> >| 4.
  Check (>| 2) <> >| 3
        <> >| 4.
  Check >| 2 <>
          (>| 3 <> >| 4).

End TreeUsage.
