/- ------------------------------------------------------------------------- -\
| @project: riemann_hypothesis                                                |
| @file:    algebra.lean                                                      |
| @author:  Brandon H. Gomes                                                  |
| @affil:   Rutgers University                                                |
\- ------------------------------------------------------------------------- -/

import .basic

/-!
-/

--———————————————————————————————————————————————————————————————————————————————————————--
variables (S : Type*)

/--
-/
class DifferenceDomain extends has_zero S, has_sub S, has_mul S
    := (sub_cancel     : Π       s : S, s - s = 0)
       (sub_right_id   : Π       s : S, s - 0 = s)
       (sub_inner_swap : Π a b c d : S, (a - b) - (c - d) = (a - c) - (b - d))
       (sub_outer_swap : Π a b c d : S, (a - b) - (c - d) = (d - b) - (c - a))
       (left_distrib   : Π   x y z : S, x * (y - z) = (x * y) - (x * z))
       (right_distrib  : Π   x y z : S, (y - z) * x = (y * x) - (z * x))

namespace DifferenceDomain --————————————————————————————————————————————————————————————--
variables {S} [DifferenceDomain S]

/--
-/
def sub_right_left_swap (x y z : S) : (x - y) - z = (x - z) - y :=
    begin
        rw ←sub_right_id z,
        rw sub_inner_swap,
        rw sub_right_id,
        rw sub_right_id,
    end

/--
-/
def sub_left_right_swap (x y z : S) : x - (y - z) = z - (y - x) :=
    begin
        rw ←sub_right_id x,
        rw sub_outer_swap,
        rw sub_right_id,
        rw sub_right_id,
    end

end DifferenceDomain --——————————————————————————————————————————————————————————————————--

--———————————————————————————————————————————————————————————————————————————————————————--
variables {S} [has_zero S] [has_sub S] [has_mul S]

/--
-/
structure SubDomain (proj : S → S)
    := (idempotent   : Π   s, proj (proj s) = proj s)
       (respects_sub : Π x y, proj (x - y) = proj x - proj y)

namespace SubDomain --———————————————————————————————————————————————————————————————————--
variables {proj : S → S} (𝔇 : SubDomain proj)

/--
-/
def member (s) : membership proj
    := ⟨proj s, 𝔇.idempotent s⟩

end SubDomain --—————————————————————————————————————————————————————————————————————————--
