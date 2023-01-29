keyboard_controller = {}

-- initialize all the keycodes you care about in _state
function keyboard_controller.init()
  keyboard_controller._state = {
    ["UP"] = 0,
    ["RIGHT"] = 0,
    ["DOWN"] = 0,
    ["LEFT"] = 0,
  }
  keyboard_controller._clock_id = clock.run(keyboard_clock)
end

-- place your business logic here
function keyboard_controller:keyboard_handler()
  -- store the states more legible variables
  local UP    = self._state["UP"]
  local RIGHT = self._state["RIGHT"]
  local DOWN  = self._state["DOWN"]
  local LEFT  = self._state["LEFT"]

  -- handle the keyboard feedback arrows
  if (UP    > 0) then Soot:get("arrow_north"):turn_on() else Soot:get("arrow_north"):turn_off() end
  if (RIGHT > 0) then Soot:get("arrow_east"):turn_on()  else Soot:get("arrow_east"):turn_off()  end
  if (DOWN  > 0) then Soot:get("arrow_south"):turn_on() else Soot:get("arrow_south"):turn_off() end
  if (LEFT  > 0) then Soot:get("arrow_west"):turn_on()  else Soot:get("arrow_west"):turn_off()  end

  -- orientation
  local speed = 4
  if (UP > 0) then
    local lookahead = map.y + speed
    Soot:get("elephant"):heading("n")
    if (map:is_wall(map.x * map.scale, lookahead * map.scale)) then
      print("hit the wall")
    end
    map.y = lookahead
  end
  if (RIGHT > 0) then
    Soot:get("elephant"):heading("e")
    map.x = map.x - speed
  end
  if (DOWN > 0) then
    Soot:get("elephant"):heading("s")
    map.y = map.y - speed
  end
  if (LEFT > 0) then
    Soot:get("elephant"):heading("w")
    map.x = map.x + speed
  end

  -- movement
  if (UP > 0 or RIGHT > 0 or DOWN > 0 or LEFT > 0) then
    Soot:get("elephant"):start()
  else
    Soot:get("elephant"):stop()
  end

  
end

-- save all hid input codes + values to a table
function keyboard_controller:handle_code(code, value)
  keyboard_controller._state[code] = value
end

-- simple clock to drive polling
function keyboard_clock()
  while true do
    clock.sleep(1/15)
    keyboard_controller:keyboard_handler()
  end
end

function keyboard_controller:cleanup()
  clock.cancel(self._clock_id)
end

return keyboard_controller