/- ------------------------------------------------------------------------- -\
| @project: riemann_hypothesis                                                |
| @file:    basic.lean                                                        |
| @author:  Brandon H. Gomes                                                  |
| @affil:   Rutgers University                                                |
\- ------------------------------------------------------------------------- -/

/-!
-/

--———————————————————————————————————————————————————————————————————————————————————————--

/--
`Power X` (`𝒫 X`) The powerset of a type.

Sadly this has to be Sort* and not Type*.
-/
def Power (X : Sort*)
    := X → Sort*
notation `𝒫` X := Power X

/--
`const b` (`↓b`) The constant function at a point.

Sadly this has to be Sort* and not Type*.
-/
def const {X Y : Sort*}
    := λ b : Y, (λ x : X, b)
notation `↓`:max y:max := const y

section basic_instances --———————————————————————————————————————————————————————————————--

/--
-/
instance pointwise_lt {X Y : Type*} [has_lt Y] : has_lt (X → Y)
    := ⟨λ f g, (Π x, f x < g x)⟩

/--
-/
instance pointwise_le {X Y : Type*} [has_le Y] : has_le (X → Y)
    := ⟨λ f g, (Π x, f x ≤ g x)⟩

/--
-/
instance lt_has_le {Y : Type*} [has_lt Y] : has_le Y
    := ⟨λ p q, p < q ∨ p = q⟩

/--
-/
instance pointwise_sub {X Y : Type*} [has_sub Y] : has_sub (X → Y)
    := ⟨λ f g, (λ x, f x - g x)⟩

/--
-/
instance pointwise_mul {X Y : Type*} [has_mul Y] : has_mul (X → Y)
    := ⟨λ f g, (λ x, f x * g x)⟩

end basic_instances --———————————————————————————————————————————————————————————————————--

/--
-/
def is_same {X : Type*} (I : X → X)
    := λ x, I x = x
notation x `~` I := is_same I x

/--
-/
structure membership {X : Type*} (I : X → X)
    := (elem      : X)
       (is_member : elem ~ I)

namespace membership --——————————————————————————————————————————————————————————————————--
variables {X : Type*} (I : X → X)

/- --- -/

end membership --————————————————————————————————————————————————————————————————————————--
