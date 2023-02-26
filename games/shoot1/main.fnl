;; (c) mg

;; app state (generic stuff here)
(global A
  {:title "Untitled game";"Snek Hedd"
   ;; window size (actual window, not the game canvas) will be auto updated
   :width 0
   :height 0
   ;; initial scale factor. will change based on actual window size
   :scale 2
   :pixel_perfect false})

;; shortcuts
(global L lyte)

(global mathx (require "libs.mathx"))

;; game (sets up global "G" table)
(require "game")

;; local variables
(var game_canvas nil)

;; handle window resize, including rescaling and paddings
(fn adjust-scale [w h]
  (set A.width w)
  (set A.height h)
  (let [sc (math.min (/ w G.width)
                     (/ h G.height))]
    (if A.pixel_perfect
        (set A.scale (math.floor sc))
        (set A.scale sc)))
  (let [ww A.width
        hh A.height
        gw (* G.width A.scale)
        gh (* G.height A.scale)
        pw (/ (- ww gw) 2)
        ph (/ (- hh gh) 2)]
    (L.set_window_paddings  pw  pw  ph  ph) ;; TODO: order confusion
    (print "rescaled: " w ", " h)))

;; this will be set to lyte.tick to run every tick
(fn tick [dt w h resized]
  (when resized (adjust-scale w h))
  (set G.dt dt)
  (let [(mx my) (L.get_mouse_position)
        smx (/ mx A.scale)
        smy (/ my A.scale)]
    (set G.mx (math.ceil smx))
    (set G.my (math.ceil smy)))
  ;; update game
  (G.update)
  ;; draw game to canvas
  (L.set_canvas game_canvas)
  (L.cls 0 0 0 1)
  (G.draw)
  (L.reset_canvas)
  ;; draw canvas to screen
  (L.push_matrix)
  (L.scale A.scale A.scale) ;; TODO: second param to be optional
  (L.cls 0 0.20 0 1) ;; TODO: all optional
  (L.draw_image game_canvas.image 0 0)
  (L.pop_matrix)
  ;; draw any "debug" info
  (L.set_color 1 1 0 0.4) ;; TODO: alpha optional
  (L.draw_text (.. "App: " A.title) 0 -60)
  (L.draw_text (string.format "FPS:%3.1f | Mouse:(%d,%d)" (/ 1 G.dt) G.mx G.my) 0 -30)
  (each [i dbg_txt (ipairs (G.debug_list))]
    (L.draw_text (or dbg_txt "??") 0 (+ (* i 16) (- (* G.height A.scale) 20))))
  (L.reset_color))

;; entry poing
(fn start []
  ; (L.set_window_margins 50 50 20 20)
  (L.set_window_title A.title)
  (L.set_window_size  (* G.width A.scale) (+ 110 (* G.height A.scale)))
  (L.set_window_minsize G.width  G.height)
  (adjust-scale A.width A.height)
  (set game_canvas (L.Canvas G.width G.height))
  (G.init)
  (set L.tick tick))

(start)


