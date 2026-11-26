module

public import Std

@[expose] public section

namespace MathLab.Packing

/-- Positive integers up to n in the reduced residue classes modulo 30 and 6. -/
def count30 (n : Nat) : Nat :=
  (n+29)/30 + (n+23)/30 + (n+19)/30 + (n+17)/30 +
  (n+13)/30 + (n+11)/30 + (n+7)/30 + (n+1)/30

def count6 (n : Nat) : Nat := (n+5)/6 + (n+1)/6

/-- The threshold table uses units of 24 original runners. -/
def gains (k : Nat) : Nat :=
  count30 (k/4) + count30 (k/5) + count30 (k/9) + count30 (k/25) +
  count30 (k/45) + count30 (k/81) + count6 (k/81) + count6 (k/243) + count6 (k/405)

private theorem count30_mono {a b : Nat} (h : a ≤ b) : count30 a ≤ count30 b := by
  unfold count30
  repeat first | apply Nat.add_le_add | apply Nat.div_le_div_right | omega

private theorem count6_mono {a b : Nat} (h : a ≤ b) : count6 a ≤ count6 b := by
  unfold count6
  repeat first | apply Nat.add_le_add | apply Nat.div_le_div_right | omega

private theorem gains_mono {a b : Nat} (h : a ≤ b) : gains a ≤ gains b := by
  have h30 (d : Nat) := @count30_mono (a/d) (b/d) (Nat.div_le_div_right h)
  have h6 (d : Nat) := @count6_mono (a/d) (b/d) (Nat.div_le_div_right h)
  exact (Nat.add_le_add (Nat.add_le_add (Nat.add_le_add (Nat.add_le_add (Nat.add_le_add (Nat.add_le_add (Nat.add_le_add (Nat.add_le_add (h30 4)
    (h30 5))
    (h30 9))
    (h30 25))
    (h30 45))
    (h30 81))
    (h6 81))
    (h6 243))
    (h6 405))

private def upper (k : Nat) := 8011*(24*k+23)
private def lower (k : Nat) := 1093500*gains k + 4335269

/-- A monotone lower bound at the left endpoint can certify an entire block. -/
private def check (a : Nat) : Nat → Bool
  | 0 => Nat.ble (upper a) (lower a)
  | n+1 => Nat.ble (upper (a+2^(n+1)-1)) (lower a) ||
    (check a n && check (a+2^n) n)

private theorem check_sound {a n k : Nat} (hc : check a n = true)
    (hl : a ≤ k) (hr : k < a+2^n) : upper k ≤ lower k := by
  induction n generalizing a with
  | zero =>
    have hk : k = a := by simp at hr; omega
    subst k
    exact Nat.le_of_ble_eq_true hc
  | succ n ih =>
    simp only [check, Bool.or_eq_true, Bool.and_eq_true, Nat.ble_eq] at hc
    rcases hc with hc | ⟨h1, h2⟩
    · have hmon := gains_mono hl
      unfold upper lower at *
      omega
    · rw [Nat.pow_succ] at hr
      by_cases hk : k < a+2^n
      · exact ih h1 hl hk
      · exact ih h2 (by omega) (by omega)

private theorem join_check {a n : Nat} (left : check a n = true)
    (right : check (a+2^n) n = true) : check a (n+1) = true := by
  simp [check, left, right]

set_option maxRecDepth 8192
set_option maxHeartbeats 0
set_option Elab.async false

-- Check separate blocks so each kernel reduction uses bounded working memory.
private theorem chunk0 : check 0 12 = true := by decide +kernel
private theorem chunk1 : check 4096 12 = true := by decide +kernel
private theorem chunk2 : check 8192 12 = true := by decide +kernel
private theorem chunk3 : check 12288 12 = true := by decide +kernel
private theorem chunk4 : check 16384 12 = true := by decide +kernel
private theorem chunk5 : check 20480 12 = true := by decide +kernel
private theorem chunk6 : check 24576 12 = true := by decide +kernel
private theorem chunk7 : check 28672 12 = true := by decide +kernel
private theorem chunk8 : check 32768 12 = true := by decide +kernel
private theorem chunk9 : check 36864 12 = true := by decide +kernel
private theorem chunk10 : check 40960 12 = true := by decide +kernel
private theorem chunk11 : check 45056 12 = true := by decide +kernel
private theorem chunk12 : check 49152 12 = true := by decide +kernel
private theorem chunk13 : check 53248 12 = true := by decide +kernel
private theorem chunk14 : check 57344 12 = true := by decide +kernel
private theorem chunk15 : check 61440 12 = true := by decide +kernel
private theorem chunk16 : check 65536 12 = true := by decide +kernel
private theorem chunk17 : check 69632 12 = true := by decide +kernel
private theorem chunk18 : check 73728 12 = true := by decide +kernel
private theorem chunk19 : check 77824 12 = true := by decide +kernel
private theorem chunk20 : check 81920 12 = true := by decide +kernel
private theorem chunk21 : check 86016 12 = true := by decide +kernel
private theorem chunk22 : check 90112 12 = true := by decide +kernel
private theorem chunk23 : check 94208 12 = true := by decide +kernel
private theorem chunk24 : check 98304 12 = true := by decide +kernel
private theorem chunk25 : check 102400 12 = true := by decide +kernel
private theorem chunk26 : check 106496 12 = true := by decide +kernel
private theorem chunk27 : check 110592 12 = true := by decide +kernel
private theorem chunk28 : check 114688 12 = true := by decide +kernel
private theorem chunk29 : check 118784 12 = true := by decide +kernel
private theorem chunk30 : check 122880 12 = true := by decide +kernel
private theorem chunk31 : check 126976 12 = true := by decide +kernel
private theorem chunk32 : check 131072 12 = true := by decide +kernel
private theorem chunk33 : check 135168 12 = true := by decide +kernel
private theorem chunk34 : check 139264 12 = true := by decide +kernel
private theorem chunk35 : check 143360 12 = true := by decide +kernel
private theorem chunk36 : check 147456 12 = true := by decide +kernel
private theorem chunk37 : check 151552 12 = true := by decide +kernel
private theorem chunk38 : check 155648 12 = true := by decide +kernel
private theorem chunk39 : check 159744 12 = true := by decide +kernel
private theorem chunk40 : check 163840 12 = true := by decide +kernel
private theorem chunk41 : check 167936 12 = true := by decide +kernel
private theorem chunk42 : check 172032 12 = true := by decide +kernel
private theorem chunk43 : check 176128 12 = true := by decide +kernel
private theorem chunk44 : check 180224 12 = true := by decide +kernel
private theorem chunk45 : check 184320 12 = true := by decide +kernel
private theorem chunk46 : check 188416 12 = true := by decide +kernel
private theorem chunk47 : check 192512 12 = true := by decide +kernel
private theorem chunk48 : check 196608 12 = true := by decide +kernel
private theorem chunk49 : check 200704 12 = true := by decide +kernel
private theorem chunk50 : check 204800 12 = true := by decide +kernel
private theorem chunk51 : check 208896 12 = true := by decide +kernel
private theorem chunk52 : check 212992 12 = true := by decide +kernel
private theorem chunk53 : check 217088 12 = true := by decide +kernel
private theorem chunk54 : check 221184 12 = true := by decide +kernel
private theorem chunk55 : check 225280 12 = true := by decide +kernel
private theorem chunk56 : check 229376 12 = true := by decide +kernel
private theorem chunk57 : check 233472 12 = true := by decide +kernel
private theorem chunk58 : check 237568 12 = true := by decide +kernel
private theorem chunk59 : check 241664 12 = true := by decide +kernel
private theorem chunk60 : check 245760 12 = true := by decide +kernel
private theorem chunk61 : check 249856 12 = true := by decide +kernel
private theorem chunk62 : check 253952 12 = true := by decide +kernel
private theorem chunk63 : check 258048 12 = true := by decide +kernel
private theorem chunk64 : check 262144 12 = true := by decide +kernel
private theorem chunk65 : check 266240 12 = true := by decide +kernel
private theorem chunk66 : check 270336 12 = true := by decide +kernel
private theorem chunk67 : check 274432 12 = true := by decide +kernel
private theorem chunk68 : check 278528 12 = true := by decide +kernel
private theorem chunk69 : check 282624 12 = true := by decide +kernel
private theorem chunk70 : check 286720 12 = true := by decide +kernel
private theorem chunk71 : check 290816 12 = true := by decide +kernel
private theorem chunk72 : check 294912 12 = true := by decide +kernel
private theorem chunk73 : check 299008 12 = true := by decide +kernel
private theorem chunk74 : check 303104 12 = true := by decide +kernel
private theorem chunk75 : check 307200 12 = true := by decide +kernel
private theorem chunk76 : check 311296 12 = true := by decide +kernel
private theorem chunk77 : check 315392 12 = true := by decide +kernel
private theorem chunk78 : check 319488 12 = true := by decide +kernel
private theorem chunk79 : check 323584 12 = true := by decide +kernel
private theorem chunk80 : check 327680 12 = true := by decide +kernel
private theorem chunk81 : check 331776 12 = true := by decide +kernel
private theorem chunk82 : check 335872 12 = true := by decide +kernel
private theorem chunk83 : check 339968 12 = true := by decide +kernel
private theorem chunk84 : check 344064 12 = true := by decide +kernel
private theorem chunk85 : check 348160 12 = true := by decide +kernel
private theorem chunk86 : check 352256 12 = true := by decide +kernel
private theorem chunk87 : check 356352 12 = true := by decide +kernel
private theorem chunk88 : check 360448 12 = true := by decide +kernel
private theorem chunk89 : check 364544 12 = true := by decide +kernel
private theorem chunk90 : check 368640 12 = true := by decide +kernel
private theorem chunk91 : check 372736 12 = true := by decide +kernel
private theorem chunk92 : check 376832 12 = true := by decide +kernel
private theorem chunk93 : check 380928 12 = true := by decide +kernel
private theorem chunk94 : check 385024 12 = true := by decide +kernel
private theorem chunk95 : check 389120 12 = true := by decide +kernel
private theorem chunk96 : check 393216 12 = true := by decide +kernel
private theorem chunk97 : check 397312 12 = true := by decide +kernel
private theorem chunk98 : check 401408 12 = true := by decide +kernel
private theorem chunk99 : check 405504 12 = true := by decide +kernel
private theorem chunk100 : check 409600 12 = true := by decide +kernel
private theorem chunk101 : check 413696 12 = true := by decide +kernel
private theorem chunk102 : check 417792 12 = true := by decide +kernel
private theorem chunk103 : check 421888 12 = true := by decide +kernel
private theorem chunk104 : check 425984 12 = true := by decide +kernel
private theorem chunk105 : check 430080 12 = true := by decide +kernel
private theorem chunk106 : check 434176 12 = true := by decide +kernel
private theorem chunk107 : check 438272 12 = true := by decide +kernel
private theorem chunk108 : check 442368 12 = true := by decide +kernel
private theorem chunk109 : check 446464 12 = true := by decide +kernel
private theorem chunk110 : check 450560 12 = true := by decide +kernel
private theorem chunk111 : check 454656 12 = true := by decide +kernel
private theorem chunk112 : check 458752 12 = true := by decide +kernel
private theorem chunk113 : check 462848 12 = true := by decide +kernel
private theorem chunk114 : check 466944 12 = true := by decide +kernel
private theorem chunk115 : check 471040 12 = true := by decide +kernel
private theorem chunk116 : check 475136 12 = true := by decide +kernel
private theorem chunk117 : check 479232 12 = true := by decide +kernel
private theorem chunk118 : check 483328 12 = true := by decide +kernel
private theorem chunk119 : check 487424 12 = true := by decide +kernel
private theorem chunk120 : check 491520 12 = true := by decide +kernel
private theorem chunk121 : check 495616 12 = true := by decide +kernel
private theorem chunk122 : check 499712 12 = true := by decide +kernel
private theorem chunk123 : check 503808 12 = true := by decide +kernel
private theorem chunk124 : check 507904 12 = true := by decide +kernel
private theorem chunk125 : check 512000 12 = true := by decide +kernel
private theorem chunk126 : check 516096 12 = true := by decide +kernel
private theorem chunk127 : check 520192 12 = true := by decide +kernel
private theorem chunk128 : check 524288 12 = true := by decide +kernel
private theorem chunk129 : check 528384 12 = true := by decide +kernel
private theorem chunk130 : check 532480 12 = true := by decide +kernel
private theorem chunk131 : check 536576 12 = true := by decide +kernel
private theorem chunk132 : check 540672 12 = true := by decide +kernel
private theorem chunk133 : check 544768 12 = true := by decide +kernel
private theorem chunk134 : check 548864 12 = true := by decide +kernel
private theorem chunk135 : check 552960 12 = true := by decide +kernel
private theorem chunk136 : check 557056 12 = true := by decide +kernel
private theorem chunk137 : check 561152 12 = true := by decide +kernel
private theorem chunk138 : check 565248 12 = true := by decide +kernel
private theorem chunk139 : check 569344 12 = true := by decide +kernel
private theorem chunk140 : check 573440 12 = true := by decide +kernel
private theorem chunk141 : check 577536 12 = true := by decide +kernel
private theorem chunk142 : check 581632 12 = true := by decide +kernel
private theorem chunk143 : check 585728 12 = true := by decide +kernel
private theorem chunk144 : check 589824 12 = true := by decide +kernel
private theorem chunk145 : check 593920 12 = true := by decide +kernel
private theorem chunk146 : check 598016 12 = true := by decide +kernel
private theorem chunk147 : check 602112 12 = true := by decide +kernel
private theorem chunk148 : check 606208 12 = true := by decide +kernel
private theorem chunk149 : check 610304 12 = true := by decide +kernel
private theorem chunk150 : check 614400 12 = true := by decide +kernel
private theorem chunk151 : check 618496 12 = true := by decide +kernel
private theorem chunk152 : check 622592 12 = true := by decide +kernel
private theorem chunk153 : check 626688 12 = true := by decide +kernel
private theorem chunk154 : check 630784 12 = true := by decide +kernel
private theorem chunk155 : check 634880 12 = true := by decide +kernel
private theorem chunk156 : check 638976 12 = true := by decide +kernel
private theorem chunk157 : check 643072 12 = true := by decide +kernel
private theorem chunk158 : check 647168 12 = true := by decide +kernel
private theorem chunk159 : check 651264 12 = true := by decide +kernel
private theorem chunk160 : check 655360 12 = true := by decide +kernel
private theorem chunk161 : check 659456 12 = true := by decide +kernel
private theorem chunk162 : check 663552 12 = true := by decide +kernel
private theorem chunk163 : check 667648 12 = true := by decide +kernel
private theorem chunk164 : check 671744 12 = true := by decide +kernel
private theorem chunk165 : check 675840 12 = true := by decide +kernel
private theorem chunk166 : check 679936 12 = true := by decide +kernel
private theorem chunk167 : check 684032 12 = true := by decide +kernel
private theorem chunk168 : check 688128 12 = true := by decide +kernel
private theorem chunk169 : check 692224 12 = true := by decide +kernel
private theorem chunk170 : check 696320 12 = true := by decide +kernel
private theorem chunk171 : check 700416 12 = true := by decide +kernel
private theorem chunk172 : check 704512 12 = true := by decide +kernel
private theorem chunk173 : check 708608 12 = true := by decide +kernel
private theorem chunk174 : check 712704 12 = true := by decide +kernel
private theorem chunk175 : check 716800 12 = true := by decide +kernel
private theorem chunk176 : check 720896 12 = true := by decide +kernel
private theorem chunk177 : check 724992 12 = true := by decide +kernel
private theorem chunk178 : check 729088 12 = true := by decide +kernel
private theorem chunk179 : check 733184 12 = true := by decide +kernel
private theorem chunk180 : check 737280 12 = true := by decide +kernel
private theorem chunk181 : check 741376 12 = true := by decide +kernel
private theorem chunk182 : check 745472 12 = true := by decide +kernel
private theorem chunk183 : check 749568 12 = true := by decide +kernel
private theorem chunk184 : check 753664 12 = true := by decide +kernel
private theorem chunk185 : check 757760 12 = true := by decide +kernel
private theorem chunk186 : check 761856 12 = true := by decide +kernel
private theorem chunk187 : check 765952 12 = true := by decide +kernel
private theorem chunk188 : check 770048 12 = true := by decide +kernel
private theorem chunk189 : check 774144 12 = true := by decide +kernel
private theorem chunk190 : check 778240 12 = true := by decide +kernel
private theorem chunk191 : check 782336 12 = true := by decide +kernel
private theorem chunk192 : check 786432 12 = true := by decide +kernel
private theorem chunk193 : check 790528 12 = true := by decide +kernel
private theorem chunk194 : check 794624 12 = true := by decide +kernel
private theorem chunk195 : check 798720 12 = true := by decide +kernel
private theorem chunk196 : check 802816 12 = true := by decide +kernel
private theorem chunk197 : check 806912 12 = true := by decide +kernel
private theorem chunk198 : check 811008 12 = true := by decide +kernel
private theorem chunk199 : check 815104 12 = true := by decide +kernel
private theorem chunk200 : check 819200 12 = true := by decide +kernel
private theorem chunk201 : check 823296 12 = true := by decide +kernel
private theorem chunk202 : check 827392 12 = true := by decide +kernel
private theorem chunk203 : check 831488 12 = true := by decide +kernel
private theorem chunk204 : check 835584 12 = true := by decide +kernel
private theorem chunk205 : check 839680 12 = true := by decide +kernel
private theorem chunk206 : check 843776 12 = true := by decide +kernel
private theorem chunk207 : check 847872 12 = true := by decide +kernel
private theorem chunk208 : check 851968 12 = true := by decide +kernel
private theorem chunk209 : check 856064 12 = true := by decide +kernel
private theorem chunk210 : check 860160 12 = true := by decide +kernel
private theorem chunk211 : check 864256 12 = true := by decide +kernel
private theorem chunk212 : check 868352 12 = true := by decide +kernel
private theorem chunk213 : check 872448 12 = true := by decide +kernel
private theorem chunk214 : check 876544 12 = true := by decide +kernel
private theorem chunk215 : check 880640 12 = true := by decide +kernel
private theorem chunk216 : check 884736 12 = true := by decide +kernel
private theorem chunk217 : check 888832 12 = true := by decide +kernel
private theorem chunk218 : check 892928 12 = true := by decide +kernel
private theorem chunk219 : check 897024 12 = true := by decide +kernel
private theorem chunk220 : check 901120 12 = true := by decide +kernel
private theorem chunk221 : check 905216 12 = true := by decide +kernel
private theorem chunk222 : check 909312 12 = true := by decide +kernel
private theorem chunk223 : check 913408 12 = true := by decide +kernel
private theorem chunk224 : check 917504 12 = true := by decide +kernel
private theorem chunk225 : check 921600 12 = true := by decide +kernel
private theorem chunk226 : check 925696 12 = true := by decide +kernel
private theorem chunk227 : check 929792 12 = true := by decide +kernel
private theorem chunk228 : check 933888 12 = true := by decide +kernel
private theorem chunk229 : check 937984 12 = true := by decide +kernel
private theorem chunk230 : check 942080 12 = true := by decide +kernel
private theorem chunk231 : check 946176 12 = true := by decide +kernel
private theorem chunk232 : check 950272 12 = true := by decide +kernel
private theorem chunk233 : check 954368 12 = true := by decide +kernel
private theorem chunk234 : check 958464 12 = true := by decide +kernel
private theorem chunk235 : check 962560 12 = true := by decide +kernel
private theorem chunk236 : check 966656 12 = true := by decide +kernel
private theorem chunk237 : check 970752 12 = true := by decide +kernel
private theorem chunk238 : check 974848 12 = true := by decide +kernel
private theorem chunk239 : check 978944 12 = true := by decide +kernel
private theorem chunk240 : check 983040 12 = true := by decide +kernel
private theorem chunk241 : check 987136 12 = true := by decide +kernel
private theorem chunk242 : check 991232 12 = true := by decide +kernel
private theorem chunk243 : check 995328 12 = true := by decide +kernel
private theorem chunk244 : check 999424 12 = true := by decide +kernel
private theorem chunk245 : check 1003520 12 = true := by decide +kernel
private theorem chunk246 : check 1007616 12 = true := by decide +kernel
private theorem chunk247 : check 1011712 12 = true := by decide +kernel
private theorem chunk248 : check 1015808 12 = true := by decide +kernel
private theorem chunk249 : check 1019904 12 = true := by decide +kernel
private theorem chunk250 : check 1024000 12 = true := by decide +kernel
private theorem chunk251 : check 1028096 12 = true := by decide +kernel
private theorem chunk252 : check 1032192 12 = true := by decide +kernel
private theorem chunk253 : check 1036288 12 = true := by decide +kernel
private theorem chunk254 : check 1040384 12 = true := by decide +kernel
private theorem chunk255 : check 1044480 12 = true := by decide +kernel

private theorem finite_check : check 0 20 = true :=
  join_check
    (join_check
      (join_check
        (join_check
          (join_check
            (join_check
              (join_check
                (join_check chunk0 chunk1)
                (join_check chunk2 chunk3))
              (join_check
                (join_check chunk4 chunk5)
                (join_check chunk6 chunk7)))
            (join_check
              (join_check
                (join_check chunk8 chunk9)
                (join_check chunk10 chunk11))
              (join_check
                (join_check chunk12 chunk13)
                (join_check chunk14 chunk15))))
          (join_check
            (join_check
              (join_check
                (join_check chunk16 chunk17)
                (join_check chunk18 chunk19))
              (join_check
                (join_check chunk20 chunk21)
                (join_check chunk22 chunk23)))
            (join_check
              (join_check
                (join_check chunk24 chunk25)
                (join_check chunk26 chunk27))
              (join_check
                (join_check chunk28 chunk29)
                (join_check chunk30 chunk31)))))
        (join_check
          (join_check
            (join_check
              (join_check
                (join_check chunk32 chunk33)
                (join_check chunk34 chunk35))
              (join_check
                (join_check chunk36 chunk37)
                (join_check chunk38 chunk39)))
            (join_check
              (join_check
                (join_check chunk40 chunk41)
                (join_check chunk42 chunk43))
              (join_check
                (join_check chunk44 chunk45)
                (join_check chunk46 chunk47))))
          (join_check
            (join_check
              (join_check
                (join_check chunk48 chunk49)
                (join_check chunk50 chunk51))
              (join_check
                (join_check chunk52 chunk53)
                (join_check chunk54 chunk55)))
            (join_check
              (join_check
                (join_check chunk56 chunk57)
                (join_check chunk58 chunk59))
              (join_check
                (join_check chunk60 chunk61)
                (join_check chunk62 chunk63))))))
      (join_check
        (join_check
          (join_check
            (join_check
              (join_check
                (join_check chunk64 chunk65)
                (join_check chunk66 chunk67))
              (join_check
                (join_check chunk68 chunk69)
                (join_check chunk70 chunk71)))
            (join_check
              (join_check
                (join_check chunk72 chunk73)
                (join_check chunk74 chunk75))
              (join_check
                (join_check chunk76 chunk77)
                (join_check chunk78 chunk79))))
          (join_check
            (join_check
              (join_check
                (join_check chunk80 chunk81)
                (join_check chunk82 chunk83))
              (join_check
                (join_check chunk84 chunk85)
                (join_check chunk86 chunk87)))
            (join_check
              (join_check
                (join_check chunk88 chunk89)
                (join_check chunk90 chunk91))
              (join_check
                (join_check chunk92 chunk93)
                (join_check chunk94 chunk95)))))
        (join_check
          (join_check
            (join_check
              (join_check
                (join_check chunk96 chunk97)
                (join_check chunk98 chunk99))
              (join_check
                (join_check chunk100 chunk101)
                (join_check chunk102 chunk103)))
            (join_check
              (join_check
                (join_check chunk104 chunk105)
                (join_check chunk106 chunk107))
              (join_check
                (join_check chunk108 chunk109)
                (join_check chunk110 chunk111))))
          (join_check
            (join_check
              (join_check
                (join_check chunk112 chunk113)
                (join_check chunk114 chunk115))
              (join_check
                (join_check chunk116 chunk117)
                (join_check chunk118 chunk119)))
            (join_check
              (join_check
                (join_check chunk120 chunk121)
                (join_check chunk122 chunk123))
              (join_check
                (join_check chunk124 chunk125)
                (join_check chunk126 chunk127)))))))
    (join_check
      (join_check
        (join_check
          (join_check
            (join_check
              (join_check
                (join_check chunk128 chunk129)
                (join_check chunk130 chunk131))
              (join_check
                (join_check chunk132 chunk133)
                (join_check chunk134 chunk135)))
            (join_check
              (join_check
                (join_check chunk136 chunk137)
                (join_check chunk138 chunk139))
              (join_check
                (join_check chunk140 chunk141)
                (join_check chunk142 chunk143))))
          (join_check
            (join_check
              (join_check
                (join_check chunk144 chunk145)
                (join_check chunk146 chunk147))
              (join_check
                (join_check chunk148 chunk149)
                (join_check chunk150 chunk151)))
            (join_check
              (join_check
                (join_check chunk152 chunk153)
                (join_check chunk154 chunk155))
              (join_check
                (join_check chunk156 chunk157)
                (join_check chunk158 chunk159)))))
        (join_check
          (join_check
            (join_check
              (join_check
                (join_check chunk160 chunk161)
                (join_check chunk162 chunk163))
              (join_check
                (join_check chunk164 chunk165)
                (join_check chunk166 chunk167)))
            (join_check
              (join_check
                (join_check chunk168 chunk169)
                (join_check chunk170 chunk171))
              (join_check
                (join_check chunk172 chunk173)
                (join_check chunk174 chunk175))))
          (join_check
            (join_check
              (join_check
                (join_check chunk176 chunk177)
                (join_check chunk178 chunk179))
              (join_check
                (join_check chunk180 chunk181)
                (join_check chunk182 chunk183)))
            (join_check
              (join_check
                (join_check chunk184 chunk185)
                (join_check chunk186 chunk187))
              (join_check
                (join_check chunk188 chunk189)
                (join_check chunk190 chunk191))))))
      (join_check
        (join_check
          (join_check
            (join_check
              (join_check
                (join_check chunk192 chunk193)
                (join_check chunk194 chunk195))
              (join_check
                (join_check chunk196 chunk197)
                (join_check chunk198 chunk199)))
            (join_check
              (join_check
                (join_check chunk200 chunk201)
                (join_check chunk202 chunk203))
              (join_check
                (join_check chunk204 chunk205)
                (join_check chunk206 chunk207))))
          (join_check
            (join_check
              (join_check
                (join_check chunk208 chunk209)
                (join_check chunk210 chunk211))
              (join_check
                (join_check chunk212 chunk213)
                (join_check chunk214 chunk215)))
            (join_check
              (join_check
                (join_check chunk216 chunk217)
                (join_check chunk218 chunk219))
              (join_check
                (join_check chunk220 chunk221)
                (join_check chunk222 chunk223)))))
        (join_check
          (join_check
            (join_check
              (join_check
                (join_check chunk224 chunk225)
                (join_check chunk226 chunk227))
              (join_check
                (join_check chunk228 chunk229)
                (join_check chunk230 chunk231)))
            (join_check
              (join_check
                (join_check chunk232 chunk233)
                (join_check chunk234 chunk235))
              (join_check
                (join_check chunk236 chunk237)
                (join_check chunk238 chunk239))))
          (join_check
            (join_check
              (join_check
                (join_check chunk240 chunk241)
                (join_check chunk242 chunk243))
              (join_check
                (join_check chunk244 chunk245)
                (join_check chunk246 chunk247)))
            (join_check
              (join_check
                (join_check chunk248 chunk249)
                (join_check chunk250 chunk251))
              (join_check
                (join_check chunk252 chunk253)
                (join_check chunk254 chunk255)))))))

theorem period (k : Nat) : gains (k+729000) = gains k + 128176 := by
  have translate (n m b l : Nat) (hm : 0 < m) :
      ((n + m*l) + b) / m = (n+b)/m + l := by
    rw [show (n + m*l) + b = (n+b) + m*l by omega, Nat.add_mul_div_left _ _ hm]
  have c30 (n l : Nat) : count30 (n+30*l) = count30 n + 8*l := by
    unfold count30
    simp only [translate _ 30 _ _ (by decide)]
    omega
  have c6 (n l : Nat) : count6 (n+6*l) = count6 n + 2*l := by
    unfold count6
    simp only [translate _ 6 _ _ (by decide)]
    omega
  unfold gains
  rw [show (k+729000)/4 = k/4 + 182250 from Nat.add_mul_div_left k 182250 (by decide : 0 < 4)]
  rw [show (k+729000)/5 = k/5 + 145800 from Nat.add_mul_div_left k 145800 (by decide : 0 < 5)]
  rw [show (k+729000)/9 = k/9 + 81000 from Nat.add_mul_div_left k 81000 (by decide : 0 < 9)]
  rw [show (k+729000)/25 = k/25 + 29160 from Nat.add_mul_div_left k 29160 (by decide : 0 < 25)]
  rw [show (k+729000)/45 = k/45 + 16200 from Nat.add_mul_div_left k 16200 (by decide : 0 < 45)]
  rw [show (k+729000)/81 = k/81 + 9000 from Nat.add_mul_div_left k 9000 (by decide : 0 < 81)]
  rw [show (k+729000)/243 = k/243 + 3000 from Nat.add_mul_div_left k 3000 (by decide : 0 < 243)]
  rw [show (k+729000)/405 = k/405 + 1800 from Nat.add_mul_div_left k 1800 (by decide : 0 < 405)]
  rw [c30 (k/4) 6075]
  rw [c30 (k/5) 4860]
  rw [c30 (k/9) 2700]
  rw [c30 (k/25) 972]
  rw [c30 (k/45) 540]
  rw [c30 (k/81) 300]
  rw [c6 (k/81) 1500]
  rw [c6 (k/243) 500]
  rw [c6 (k/405) 300]
  omega

theorem discrepancy (N : Nat) :
    8011*N ≤ 1093500*gains (N/24) + 4335269 := by
  suffices hall : ∀ k, upper k ≤ lower k by
    have h := hall (N/24)
    unfold upper lower at h
    omega
  intro k
  induction k using Nat.strongRecOn with
  | ind k ih =>
    by_cases h : k < 729000
    · exact check_sound finite_check (Nat.zero_le _) (by omega)
    · have hk := ih (k-729000) (by omega)
      have hp := period (k-729000)
      rw [Nat.sub_add_cancel (by omega : 729000 ≤ k)] at hp
      unfold upper lower at *
      omega

/-- The maximum discrepancy is attained in the first period. -/
theorem sharp_discrepancy :
    8011*8139479 = 1093500*gains (8139479/24) + 4335269 := by decide +kernel

/-- Sufficient saving in the initial system of n+h runners. -/
theorem saving_at_target (n h : Nat) (hbound : 1085489*h + 3241770 ≤ 8011*n) :
    h ≤ gains ((n+h)/24) := by
  have hcert := discrepancy (n+h)
  omega

end MathLab.Packing
