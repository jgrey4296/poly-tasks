(*  monad.v -*- mode: coq -*-  *)
(*
Summary:
A Monad in rocq.

https://www.cs.cornell.edu/courses/cs3110/2018sp/l/25-monads/lab.html
Tags:
 *)

Set Implicit Arguments.
Unset Strict Implicit.
Unset Printing Implicit Defensive.

Set Universe Polymorphism.

From Corelib Require Import Program.Basics.
Open Scope program_scope.


Module MonadBasics.
  Declare Scope MonadScope.
  (* Delimit Scope MonadScope with Monad. *)
  Reserved Notation "m >>= f"
    (at level 49).
  Reserved Notation "'do' x <- m ; e"
    (at level 60, x name, m at level 200, e at level 60).
  Reserved Notation "'do' x : T <- m ; e"
    (at level 60, x name, m at level 200, e at level 60).

  Class Monad (m : Type -> Type) : Type :=
    {
      ret  : forall (t : Type),   t   -> m t ;
      bind : forall (t u : Type), m t -> (t -> m u) -> m u ;
    }.

  Notation "c >>= f" := (bind c f) : MonadScope.
  Notation "'do' x <- m ; e" := (bind m (fun x => e)) : MonadScope.

  (* Monad Laws: *)
  (* return a >>= k = k a *)
  (* m >>= return = m *)
  (* m >>= (\x -> k x >>= h) = (m >>= k) >>= h *)

End MonadBasics.


Module MaybeMonad.
  Export MonadBasics.
  Open Scope MonadScope.

  Print Monad.
  Instance Maybe : Monad option:=
    {
      ret _ x := Some x ;
      bind _ _ v f :=
        match v with
        | None => None
        | Some x => f x
        end
    }.
  Print bind.

End MaybeMonad.

Section MonadUse.
  Import MaybeMonad.

  Open Scope MonadScope.

  Definition value := ret 2 >>= (fun x => ret x).
  Definition value2 := ret 0 >>= (fun x => ret x).
  Check value.
  Compute match value2 with
          | None => 999
          | Some x => x
          end.


End MonadUse.
