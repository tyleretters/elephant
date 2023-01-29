-- shield ye eyes, very ugly first draft...
map = {}

function map.init()
  map.x = 0
  map.y = 0
  map.file = "/home/we/dust/code/elephant/map.txt"
  map.raw = {}
  map.scale = 4 -- pixels == 1 ascii character
  map.starting_x = 0
  map.starting_y = 0
  map:read()
end

function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

function lines_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

function string_split(input_string, split_character)
  local s = split_character ~= nil and split_character or "%s"
  local t = {}
  if split_character == "" then
    for str in string.gmatch(input_string, ".") do
      table.insert(t, str)
    end
  else
    for str in string.gmatch(input_string, "([^" .. s .. "]+)") do
      table.insert(t, str)
    end
  end
  return t
end

function map:read()
  local lines = lines_from(self.file)
  for row_k, row_v in pairs(lines) do
    map.raw[row_k] = {}
    local characters = string_split(row_v, "")
    for col_k, col_v in pairs(characters) do
      map.raw[row_k][col_k] = col_v
      if (col_v == "@") then
        map.starting_x = (col_k - 1) * map.scale
        map.starting_y = (row_k - 1) * map.scale
      end
    end
  end
end

function map:preview()
  print("START MAP PREVIEW")
  for row_k, row_v in pairs(self.raw) do
    local row = ''
    for col_k, col_v in pairs(row_v) do
      row = row .. col_v 
    end
  end
  print("END MAP PREIVEW")
end

function map:redraw()
  local row_counter = 0
  for row_k, row_v in pairs(self.raw) do
    local col_counter = 0
    local row = ''
    for col_k, col_v in pairs(row_v) do
      if (col_v == '#') then
        Soot:rect((col_counter * map.scale) + self.x, (row_counter * map.scale) + map.y, map.scale, map.scale, 15)
      end
      if (col_v == '1') then
        Soot:circle((col_counter * map.scale) + self.x, (row_counter * map.scale) + map.y, 4, 15)
        Soot:circle((col_counter * map.scale) + self.x, (row_counter * map.scale) + map.y, 3, 0)
      end
      col_counter = col_counter + 1
    end
    row_counter = row_counter + 1
  end
end

function map:is_wall(x, y)
  print(x, y)
  local is_wall = false
  local row_counter = 0
  for row_k, row_v in pairs(self.raw) do
    local col_counter = 0
    local row = ''
    for col_k, col_v in pairs(row_v) do
      if (x == col_k and y == row_k and col_v == '#') then
        is_wall = true
      end
      col_counter = col_counter + 1
    end
    row_counter = row_counter + 1
  end
  return is_wall
end

return map