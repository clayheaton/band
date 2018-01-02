--[[
  Middleclass class library: https://github.com/kikito/middleclass
]]

function love.load()
  love.window.setMode(600, 800)
  require('libraries/table_utils') -- Print tables

  class = require('libraries/middleclass-master/middleclass')
  ftcsv = require('libraries/ftcsv')

  events, headers = ftcsv.parse('data/events.csv', ",")

  -- print(table.tostring(events))

  require('TitleScene')
  require('DecisionCard')

  card = DecisionCard(events[1])

  title_scene = TitleScene("Title Scene")

  active_scene = title_scene
end

function love.update(dt)

end

function love.draw()
  -- card:draw()
  active_scene:draw()
end

function love.mousepressed(x, y, button, isTouch)
  active_scene:mousepressed(x, y, button, isTouch)
end

function love.keypressed(key, scancode, isrepeat)

  active_scene:keypressed(key, scancode, isrepeat)

  -- if key == "right" then
  --   card:shiftPosition("right")
  -- elseif key == "left" then
  --   card:shiftPosition("left")
  -- end

end
