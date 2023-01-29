-- elephant
tabutil = require("tabutil")
keyboard_controller = include "lib/keyboard_controller"
map = include "lib/map"
Soot = include "lib/Soot"


function init()
  keyboard_controller.init()
  map.init()
  Soot.init("/home/we/dust/code/elephant/sprites/", 15)

  -- elephant
  Soot:name_cardinal_sprite("elephant")
    :x(map.starting_x)
    :y(map.starting_y)
    :width(16)
    :height(16)

  -- arrows
  Soot:name_toggle_sprite("arrow_north")
    :x(112)
    :y(48)
    :width(8)
    :height(8)
    :hide()

  Soot:name_toggle_sprite("arrow_east")
    :x(120)
    :y(56)
    :width(8)
    :height(8)
    :hide()

  Soot:name_toggle_sprite("arrow_west")
    :x(104)
    :y(56)
    :width(8)
    :height(8)
    :hide()

  Soot:name_toggle_sprite("arrow_south")
    :x(112)
    :y(56)
    :width(8)
    :height(8)
    :hide()

end

function keyboard.code(code, value)
  keyboard_controller:handle_code(code, value)
end

function redraw()
  screen.clear()
  screen.ping()
  -- screen.display_png(map.image, map.x, map.y)
  map:redraw()
  Soot:redraw()
  screen.update()
end

function cleanup()
  Soot:cleanup()
  hid:cleanup()
end
