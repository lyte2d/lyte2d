local hero_img = lyte.load_image("hero.png")

function lyte.frame()
    lyte.clear(0,0,0,1)
    lyte.push_matrix()
    lyte.scale(4,4)
    lyte.draw_image(hero_img, 10, 10)
    lyte.pop_matrix()
end
