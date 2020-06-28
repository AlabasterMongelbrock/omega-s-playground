/- ------------------------------------------------------------------------- -\
| @project: riemann_hypothesis                                                |
| @file:    reduction.lean                                                    |
| @author:  Brandon H. Gomes                                                  |
| @affil:   Rutgers University                                                |
\- ------------------------------------------------------------------------- -/

import .basic

/-!
-/

--———————————————————————————————————————————————————————————————————————————————————————--
variables {X : Type*} {Y : Type*} (ℱ : 𝒫 (X → Y))

/--
-/
def Reduction
    := Π f, ℱ f → Y

/--
-/
class PointFamily
    := (has_constants : Π y, ℱ ↓y)

/--
-/
class DifferenceFamily [has_sub Y]
    := (closure : Π f g (fℱ : ℱ f) (gℱ : ℱ g), ℱ (f - g))

namespace Reduction --———————————————————————————————————————————————————————————————————--

/--
-/
def left_closed_at (f : X → Y) (g : Y → Y)
    := ℱ f → ℱ (g ∘ f)

/--
-/
def left_closed (g : Y → Y)
    := Π f, left_closed_at ℱ f g

/--
-/
def right_closed_at (f : X → Y) (g : X → X)
    := ℱ f → ℱ (f ∘ g)

/--
-/
def right_closed (g : X → X)
    := Π f, right_closed_at ℱ f g

--———————————————————————————————————————————————————————————————————————————————————————--
variables (𝒮 : Reduction ℱ)

/--
-/
def left_factors (β : Y → Y) (lcβ : left_closed ℱ β)
    := Π f (fℱ : ℱ f), 𝒮 (β ∘ f) (lcβ f fℱ) = β (𝒮 f fℱ)

/--
-/
class Unital [PointFamily ℱ]
    := (constant_reduction : Π y, 𝒮 ↓y (PointFamily.has_constants ℱ y) = y)

/--
-/
class Monotonic [has_le Y]
    := (monotonicity : Π f g {fℱ gℱ}, (f ≤ g) → (𝒮 f fℱ ≤ 𝒮 g gℱ))

section translative --———————————————————————————————————————————————————————————————————--
variables [has_le Y] [has_zero Y] [has_sub Y] [PointFamily ℱ] [DifferenceFamily ℱ]

open PointFamily DifferenceFamily

/--
-/
def constant_difference_property
    := Π f k {fℱ},
         𝒮 (f - ↓k) (closure f ↓k fℱ (has_constants ℱ k))
       = 𝒮 f fℱ - 𝒮 ↓k (has_constants ℱ k)

/--
-/
def translation_invariance_property
    := Π f g {fℱ gℱ}, 0 ≤ 𝒮 (g - f) (closure g f gℱ fℱ) → 𝒮 f fℱ ≤ 𝒮 g gℱ

/--
-/
class Translative
    := (constant_difference    : constant_difference_property ℱ 𝒮)
       (translation_invariance : translation_invariance_property ℱ 𝒮)

end translative --———————————————————————————————————————————————————————————————————————--

end Reduction --—————————————————————————————————————————————————————————————————————————--
