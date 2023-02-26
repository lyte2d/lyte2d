;; GAME
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global G
  {;; game area
   :width 440
   :height 248
   ;; delta tick time
   :dt 0
   ;; mouse coords (adjusted for scale and padding)
   :mx 0
   :my 0
   ;; mouse "world" coord, hero loc
   :mwx 0
   :mwy 0})




;; Assets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global RES
  {:hero nil
   :bullet nil})


;; DATA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global BULLET_LIFE 5) ;; secs

(global NUM_CIRCLES 56) ;; ground stuff

(global VSYNC true) ;;

(global BORDERS
  {:left -1000
   :right 1000
   :top -1000
   :bottom 1000})

;; hero
(global H
  {:x 0 :y 0
   :dir_x 0 :dir_y 0
   ;:shoot1 false
   :speed 60
   :radius 16})

(global D
  {:bullet_speed 130
   :bullets []
   :circles []})

;; DATA FUNCTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fn add_bullet [x y angle]
  (let [vx (* (math.cos (+ math.pi angle)) D.bullet_speed)
        vy (* (math.sin (+ math.pi angle)) D.bullet_speed)]
    (table.insert D.bullets {: x : y : vx : vy : angle :t 0 :rm false})))


(fn add_circle [x y r]
  (table.insert D.circles {: x : y : r}))

;; UPDATES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fn update_controls []
  (let [
        up (L.is_key_down "w")
        down (L.is_key_down "s")
        left (L.is_key_down "a")
        right (L.is_key_down "d")]
    (set H.dir_x 0) (set H.dir_y 0)
    (when up (set H.dir_y (- H.dir_y 1)))
    (when down (set H.dir_y (+ H.dir_y 1)))
    (when left (set H.dir_x (- H.dir_x 1)))
    (when right (set H.dir_x (+ H.dir_x 1))))
  (when (or (L.is_mouse_pressed "mb1") (L.is_mouse_down "mb2"))
    (let [angle (math.atan2 (- H.y G.mwy) (- H.x G.mwx))]
        (add_bullet H.x H.y angle)
        (when (L.is_key_down "left_shift")
         (add_bullet H.x H.y (+ angle 0.34))
         (add_bullet H.x H.y (- angle 0.34))
         (add_bullet H.x H.y (+ angle 0.17))
         (add_bullet H.x H.y (- angle 0.17))))))




(fn update_world_mouse []
  (set G.mwx (- (+ G.mx H.x) (/ G.width 2)))
  (set G.mwy (- (+ G.my H.y) (/ G.height 2))))


(fn update_hero []
  (when (or (~= H.dir_x 0) (~= H.dir_y 0))
    (local angle (math.atan2 H.dir_y H.dir_x))
    (local vx (* G.dt H.speed (math.cos angle)))
    (local vy (* G.dt H.speed (math.sin angle)))
    (set H.x (+ H.x vx))
    (set H.y (+ H.y vy))))

(fn update_bullets []
  (each [_ b (ipairs D.bullets)]
    (when (>= b.t BULLET_LIFE) (set b.rm true))
    (set b.t (+ b.t G.dt))
    (set b.x (+ b.x (* G.dt b.vx)))
    (set b.y (+ b.y (* G.dt b.vy))))
  ; remove marked ones.
  (for [i (length D.bullets) 1 -1]
    (when (. D :bullets i :rm)
      (table.remove D.bullets i))))


(fn G.update []
  (update_controls)
  (update_hero)
  (update_world_mouse)
  (update_bullets))

;; DRAWS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(fn draw_hero []
  ;; (L.set_color 1 0.6 0 0.6)
  ;(L.draw_circle H.x H.y H.radius)
  (let [x (mathx.round H.x)
        y (mathx.round H.y)]
    (L.draw_image RES.hero (- x 8) (- y 8))))

(fn draw_bullets []
  (L.set_color 1 0 0 1)
  (each [_ b (ipairs D.bullets)]
    ; (L.draw_rect b.x b.y 4 4)
    ; (L.draw_circle b.x b.y 8 8)
    (L.push_matrix)
    (L.translate (mathx.round (- b.x 0)) (mathx.round (- b.y 0)))
    (L.rotate b.angle)
    (L.translate -4 -2)
    (L.set_color 1 0 0 1)
    (L.draw_image RES.bullet 0 0)
    (L.pop_matrix)))

(fn draw_circle_lines []
  (L.set_color 0 1 0 0.3)
  (each [_ c (ipairs D.circles)]
    (L.draw_circle_line c.x c.y c.r))
  (L.draw_circle_line 0 0  40)
  (L.draw_circle_line 50 0  40)
  (L.draw_circle_line -50 0  40))


(fn G.draw []
  (L.push_matrix)
  (L.cls
    0 0 0 9)

  (L.translate (- (/ G.width 2) H.x) (- (/ G.height 2) H.y))
  (draw_circle_lines)
  (draw_bullets)
  (draw_hero)
  (L.pop_matrix))


;; DEBUG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fn G.debug_list []
    [(string.format "Hero:(%.0f,%.0f) | Hand:(%.0f,%.0f) | #Bullets:%d" H.x H.y G.mwx G.mwy (length D.bullets))
     ""])


;; INIT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fn init_sprites []
  ;; hero
  (let [c_hero (L.Canvas 16 16)]
    (L.set_canvas c_hero)
    (L.cls 0 0 0 0)
    (L.set_color 0.6 0.3 0.1 1)
    (L.draw_circle 8 8 16)
    (L.reset_canvas)
    (set RES._hero_canvas c_hero) ;; bug with GC
    (set RES.hero c_hero.image))

  ;; bullets
  (let [c_blt (L.Canvas 8 4)]
    (L.set_canvas c_blt)
    (L.cls 0 0 0 0)
    (L.set_color 0.5 0.7 0.6 1)
    (L.draw_rect 0 0 8 4)
    ; (L.draw_circle 4 4 7)
    ; (L.draw_line 4 0 4 8)
    ; (L.draw_line 0 4 8 4)
    (L.reset_canvas)
    (set RES._bullet_canvas c_blt) ;; bug with GC
    (set RES.bullet c_blt.image))
  nil)

(fn init_circles []
  (for [i 1 NUM_CIRCLES]
    (let [x (math.random BORDERS.left BORDERS.right)
          y (math.random BORDERS.top BORDERS.bottom)
          r 40]
        (add_circle x y r))))


(fn G.init []
  (print "App init")
  (lyte.set_window_vsync VSYNC) ;; TODO take back
  (init_sprites)
  (init_circles))

;; END
