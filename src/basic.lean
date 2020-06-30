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

/--
-/
structure Iff (X Y : Sort*)
    := (forward : X → Y)
       (reverse : Y → X)

notation X `←→` Y := Iff X Y

section basic_instances --———————————————————————————————————————————————————————————————--

/--
-/
instance pointwise.zero {X Y : Type*} [has_zero Y] : has_zero (X → Y)
    := ⟨↓0⟩

/--
-/
instance pointwise.one {X Y : Type*} [has_one Y] : has_one (X → Y)
    := ⟨↓1⟩

/--
-/
instance pointwise.lt {X Y : Type*} [has_lt Y] : has_lt (X → Y)
    := ⟨λ f g, (Π x, f x < g x)⟩

/--
-/
instance pointwise.le {X Y : Type*} [has_le Y] : has_le (X → Y)
    := ⟨λ f g, (Π x, f x ≤ g x)⟩

/--
-/
instance lt_has_le {Y : Type*} [has_lt Y] : has_le Y
    := ⟨λ p q, p < q ∨ p = q⟩

/--
-/
instance pointwise.sub {X Y : Type*} [has_sub Y] : has_sub (X → Y)
    := ⟨λ f g, (λ x, f x - g x)⟩

/--
-/
instance pointwise.mul {X Y : Type*} [has_mul Y] : has_mul (X → Y)
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

/--
-/
instance : has_coe (membership I) X
    := ⟨membership.elem⟩

section zero --——————————————————————————————————————————————————————————————————————————--
variables [has_zero X] {I} (m : 0 ~ I)

/--
-/
def zero : membership I
    := ⟨0, m⟩

/--
-/
instance : has_zero (membership I)
    := ⟨zero m⟩

end zero --——————————————————————————————————————————————————————————————————————————————--

section one --———————————————————————————————————————————————————————————————————————————--
variables [has_one X] {I} (m : 1 ~ I)

/--
-/
def one : membership I
    := ⟨1, m⟩

/--
-/
instance : has_one (membership I)
    := ⟨one m⟩

end one --———————————————————————————————————————————————————————————————————————————————--

end membership --————————————————————————————————————————————————————————————————————————--
