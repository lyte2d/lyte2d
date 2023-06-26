; shortcuts
(local Kp lyte.is_key_pressed)
(local Dt lyte.draw_text)

(var max_dt 0)

(fn reset [] (set max_dt 0))

(fn controls []
  (if (Kp "f3") (reset))
  (if (Kp "f4") (lyte.quit)))


(fn lyte.tick [dt]
  (controls)
  (if (> dt max_dt) (set max_dt dt))
  (Dt (.. "max: " max_dt) 10 10)
  (Dt (.. "cur: " dt) 10 40))
