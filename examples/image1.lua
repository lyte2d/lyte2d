local hero_img = load_image("hero.png")

function frame()
    clear(0,0,0,1)
    push_matrix()
    scale(4,4)
    draw_image(hero_img, 10, 10)
    pop_matrix()
end