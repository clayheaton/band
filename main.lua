--[[
  Middleclass class library: https://github.com/kikito/middleclass
]]

function love.load()
  love.window.setMode(600, 800)
  require('libraries/table_utils') -- Print tables

  class = require('libraries/middleclass-master/middleclass')
  ftcsv = require('libraries/ftcsv')

  events, headers = ftcsv.parse('data/events.csv', ",")
  char_gen_events, headers = ftcsv.parse('data/character_creation.csv', ",")

  -- print(table.tostring(events))

  require('TitleScene')
  require('CreateCharacterScene')
  require('Card')
  -- require('TextInputScreen')

  card = Card(events[2])

  title_scene = TitleScene("Title Scene")
  character_scene = CreateCharacterScene("Create Your Character", char_gen_events)

  active_scene = title_scene

  -- tis = TextInputScreen(char_gen_events[2])
  -- tis:load()

end

function love.update(dt)

end

function love.draw()

  -- tis:draw()
  -- card:draw()
  active_scene:draw()
end

function love.mousepressed(x, y, button, isTouch)
  active_scene:mousepressed(x, y, button, isTouch)
end

function love.keypressed(key, scancode, isrepeat)
  active_scene:keypressed(key, scancode, isrepeat)


  -- tis:keypressed(key, scancode, isrepeat)

  -- Reimplement as pass through to the scene with the card
  -- card:shiftPosition(key)

end

function love.textinput(t)
  active_scene:textinput(t)
  -- tis:textinput(t)
end
