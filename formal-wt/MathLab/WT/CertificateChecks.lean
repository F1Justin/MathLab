import MathLab.WT.CertificateArithmetic

namespace MathLab.WT.Certificate

set_option maxRecDepth 30000
set_option maxHeartbeats 0

private theorem auto0 : Segment w 0 w 0 96 :=
  segment_of_scans (by decide +kernel)

private theorem auto96 : Segment w 0 w 96 96 :=
  segment_of_scans (by decide +kernel)

private theorem auto192 : Segment w 0 w 192 96 :=
  segment_of_scans (by decide +kernel)

private theorem auto288 : Segment w 0 w 288 96 :=
  segment_of_scans (by decide +kernel)

private theorem auto384 : Segment w 0 w 384 96 :=
  segment_of_scans (by decide +kernel)

private theorem auto480 : Segment w 0 w 480 96 :=
  segment_of_scans (by decide +kernel)

private theorem auto576 : Segment w 0 w 576 96 :=
  segment_of_scans (by decide +kernel)

private theorem auto672 : Segment w 0 w 672 96 :=
  segment_of_scans (by decide +kernel)

private theorem auto768 : Segment w 0 w 768 96 :=
  segment_of_scans (by decide +kernel)

private theorem auto864 : Segment w 0 w 864 96 :=
  segment_of_scans (by decide +kernel)

private theorem auto960 : Segment w 0 w 960 96 :=
  segment_of_scans (by decide +kernel)

private theorem auto1056 : Segment w 0 w 1056 96 :=
  segment_of_scans (by decide +kernel)

private theorem auto1152 : Segment w 0 w 1152 96 :=
  segment_of_scans (by decide +kernel)

private theorem auto1248 : Segment w 0 w 1248 51 :=
  segment_of_scans (by decide +kernel)

theorem autoChecked : Segment w 0 w 0 1299 :=
  segment_join auto0 (segment_join auto96 (segment_join auto192 (segment_join auto288 (segment_join auto384 (segment_join auto480 (segment_join auto576 (segment_join auto672 (segment_join auto768 (segment_join auto864 (segment_join auto960 (segment_join auto1056 (segment_join auto1152 (auto1248)))))))))))))

private theorem cover0 : Segment w (dw*dt) rows 0 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover96 : Segment w (dw*dt) rows 96 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover192 : Segment w (dw*dt) rows 192 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover288 : Segment w (dw*dt) rows 288 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover384 : Segment w (dw*dt) rows 384 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover480 : Segment w (dw*dt) rows 480 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover576 : Segment w (dw*dt) rows 576 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover672 : Segment w (dw*dt) rows 672 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover768 : Segment w (dw*dt) rows 768 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover864 : Segment w (dw*dt) rows 864 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover960 : Segment w (dw*dt) rows 960 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover1056 : Segment w (dw*dt) rows 1056 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover1152 : Segment w (dw*dt) rows 1152 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover1248 : Segment w (dw*dt) rows 1248 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover1344 : Segment w (dw*dt) rows 1344 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover1440 : Segment w (dw*dt) rows 1440 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover1536 : Segment w (dw*dt) rows 1536 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover1632 : Segment w (dw*dt) rows 1632 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover1728 : Segment w (dw*dt) rows 1728 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover1824 : Segment w (dw*dt) rows 1824 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover1920 : Segment w (dw*dt) rows 1920 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover2016 : Segment w (dw*dt) rows 2016 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover2112 : Segment w (dw*dt) rows 2112 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover2208 : Segment w (dw*dt) rows 2208 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover2304 : Segment w (dw*dt) rows 2304 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover2400 : Segment w (dw*dt) rows 2400 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover2496 : Segment w (dw*dt) rows 2496 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover2592 : Segment w (dw*dt) rows 2592 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover2688 : Segment w (dw*dt) rows 2688 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover2784 : Segment w (dw*dt) rows 2784 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover2880 : Segment w (dw*dt) rows 2880 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover2976 : Segment w (dw*dt) rows 2976 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover3072 : Segment w (dw*dt) rows 3072 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover3168 : Segment w (dw*dt) rows 3168 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover3264 : Segment w (dw*dt) rows 3264 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover3360 : Segment w (dw*dt) rows 3360 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover3456 : Segment w (dw*dt) rows 3456 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover3552 : Segment w (dw*dt) rows 3552 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover3648 : Segment w (dw*dt) rows 3648 96 :=
  segment_of_scans (by decide +kernel)

private theorem cover3744 : Segment w (dw*dt) rows 3744 5 :=
  segment_of_scans (by decide +kernel)

theorem coverChecked : Segment w (dw*dt) rows 0 3749 :=
  segment_join cover0 (segment_join cover96 (segment_join cover192 (segment_join cover288 (segment_join cover384 (segment_join cover480 (segment_join cover576 (segment_join cover672 (segment_join cover768 (segment_join cover864 (segment_join cover960 (segment_join cover1056 (segment_join cover1152 (segment_join cover1248 (segment_join cover1344 (segment_join cover1440 (segment_join cover1536 (segment_join cover1632 (segment_join cover1728 (segment_join cover1824 (segment_join cover1920 (segment_join cover2016 (segment_join cover2112 (segment_join cover2208 (segment_join cover2304 (segment_join cover2400 (segment_join cover2496 (segment_join cover2592 (segment_join cover2688 (segment_join cover2784 (segment_join cover2880 (segment_join cover2976 (segment_join cover3072 (segment_join cover3168 (segment_join cover3264 (segment_join cover3360 (segment_join cover3456 (segment_join cover3552 (segment_join cover3648 (cover3744)))))))))))))))))))))))))))))))))))))))

end MathLab.WT.Certificate
