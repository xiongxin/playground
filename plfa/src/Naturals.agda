module Naturals where

data ℕ : Set where
  zero : ℕ
  suc  : ℕ → ℕ

-- suc (suc (suc (suc (suc (suc (suc zero))))))

{-# BUILTIN NATURAL ℕ #-}

import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl)
open Eq.≡-Reasoning using (begin_; _≡⟨⟩_; _∎)

_+_ : ℕ → ℕ → ℕ
zero + n  = n           -- 0 + n       ≡ n
suc m + n = suc (m + n) -- (1 + m) + n ≡ 1 + (m + n)

_ : 1 + 1 ≡ 2
_ = refl


_ : 3 + 4 ≡ 7
_ =
  begin
    3 + 4
  ≡⟨⟩
    suc 1 + 4
  ∎