(*  notations.v -*- mode: coq -*-  *)
(*
Summary:

Tags:
 *)


From Stdlib Require Import Lists.List.

Module GeneralNotations.
  Declare Scope JGScope.
  Notation "f $ x" := (f x) (at level 11, right associativity, only parsing) : JGScope.

  Notation "\lambda x '->' y" := (fun x => y) (at level 30, x at level 99, y at level 99) : JGScope.

  Notation "{{  x : A | P  }}" := (sig (fun x : A => P)) (at level 0, x at level 99) : JGScope.

End GeneralNotations.


Section NotationTests.
  Import GeneralNotations.
  Open Scope JGScope.

  Succeed Check ( 2 + 2 ).
  Succeed Check {{ x : nat | x=x }}.
  Fail Check {{ x : nat | x }}.
End NotationTests.

Module PrintAndParseControl.
  Declare Scope JG_MiscScope.
  Declare Scope JG_PrintScope.
  Declare Scope JG_ParseScope.

  Notation "||| x |||" := (fun _ => x) (at level 99, only printing) : JG_PrintScope.
  Notation "|<| x |>|" := (fun _ => x) (at level 99, only parsing) : JG_ParseScope.


  Open Scope JG_ParseScope.
  (* Parses, but is printed as a fun: *)
  Succeed Check |<| 2 |>|.
  Close Scope JG_ParseScope.

  Open Scope JG_PrintScope.
  (* Is printed as ||| 2 |||. Can't be parsed like that: *)
  Succeed Check (fun _ => 2).
  Close Scope JG_PrintScope.


  Notation "|.| x .. y > z |.|" := (fun x => .. (fun y => z) ..)
                                 (at level 200, x closed binder, y closed  binder, right associativity) : JG_MiscScope.

  Open Scope JG_MiscScope.
  Succeed Check |.| (x : nat) (y : nat) (z : nat) > 5 |.|.
  Succeed Check |.| x y z > 5 |.|.
  Succeed Compute |.| x y z > 10|.| 2 3 4.
  Close Scope JG_MiscScope.

End PrintAndParseControl.

Section NotationDelimiting.
  Import ListNotations.

  Close Scope list_scope.
  Fail Check [1;2;3].
  (* Where 'list' is the delimiting scope_key for the list_scope: *)
  Succeed Check [1;2;3]%list.

  Declare Scope JG_B_Scope.
  Bind Scope JG_B_Scope with bool.
  Notation "#" := true (only parsing): JG_B_Scope.

  Definition Testfn (x : bool) := false.
  Succeed Check Testfn true.
  Succeed Check Testfn #.

  Notation blah := 2.
  Succeed Check blah.
  (* section closes, 'blah' goes away. *)
End NotationDelimiting.


Section InspectingNotations.
  Import ListNotations.
  Print Notation "_ + _".
  Print Keywords.
  Print Grammar.
  (* Current Scope Stack: *)
  Print Visibility.
  Print Visibility list_scope.
  Print Scopes.
  (* Disable Notation "$" (all) : JGScope. *)
  (* Enable Notation "_ + _" (all) : type_scope. *)
  (* Enable Notation only parsing. *)
  (* Enable Notation only printing. *)

  (* Unset Printing Notations. *)
  (* Unset Printing Raw Literals. *)
  (* Unset Printing Parentheses. *)

End InspectingNotations.
