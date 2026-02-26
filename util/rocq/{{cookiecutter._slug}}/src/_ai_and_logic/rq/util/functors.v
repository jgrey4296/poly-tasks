(*  functors.v -*- mode: coq -*-  *)
(*
Summary:

Tags:
 *)
Set Implicit Arguments.
Set Strict Implicit.

Module Functors.

  Polymorphic Class Functor (F: Type -> Type) : Type := {
      fmap : forall {A B : Type}, (A -> B) -> F A -> F B
    }.

  Check Functor.
  About Functor.

  Check Functor (fun x => x).

End Functors.
