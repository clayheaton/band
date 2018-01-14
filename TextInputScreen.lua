--[[
  For propting the player for text. Usage:

  tis = TextInputScreen(event_table)
  tis:load()

  love.textinput(t) must forward to this class
  love.keypressed(key, scancode, isrepeat) must forward to this class

  To clean up before transitioning out, call:
  tis:unload()

  More info: https://love2d.org/wiki/love.textinput

  TODO: Save the input text to the proper data store

]]

require('reference_tables')
require('colors')
local utf8 = require("utf8")

TextInputScreen = class('TextInputScreen')

TextInputScreen.static.titleFont = love.graphics.newFont(36)
TextInputScreen.static.bodyFont = love.graphics.newFont(18)
TextInputScreen.static.titleColor = {255, 255, 255}
TextInputScreen.static.bodyColor = {255, 255, 255}

function TextInputScreen:initialize(event_table, callback_on_commit)
  self.main_title = event_table['main_title']
  self.body_text = event_table['body_text']
  self.card_image = event_table['card_image']
  self.attr_to_set = event_table['attr_to_set']
  self.callback = callback_on_commit

  self.input_text = ""

end

function TextInputScreen:load()
  love.keyboard.setKeyRepeat(true)
end

function TextInputScreen:unload()
  love.keyboard.setKeyRepeat(false)
end

function TextInputScreen:update(dt)

end

function TextInputScreen:draw()
  -- Draw the title text for the stage
  love.graphics.setFont(TextInputScreen.titleFont)
  setColor(TextInputScreen.titleColor)
  love.graphics.printf(self.main_title, 0, 50, love.graphics:getWidth(), "center")

  -- Draw the descriptive text
  love.graphics.setFont(TextInputScreen.bodyFont)
  setColor(TextInputScreen.bodyColor)
  love.graphics.printf(self.body_text, 0, 100, love.graphics:getWidth(), "center")

  -- Draw the line where the text input appears
  love.graphics.line(50, love.graphics:getHeight() / 2, love.graphics:getWidth() - 50, love.graphics:getHeight() / 2)

  -- Draw the text input by the player
  love.graphics.printf(self.input_text, 0, love.graphics:getHeight() / 2 - 30, love.graphics:getWidth(), "center")

  -- Draw the "leave blank to randomize" text
  love.graphics.printf("(leave blank for random)", 0, love.graphics:getHeight() / 2 + 10, love.graphics:getWidth(), "center")
  love.graphics.printf("Press Return to Continue", 0, love.graphics:getHeight() / 2 + 40, love.graphics:getWidth(), "center")

end

function TextInputScreen:textinput(t)
  if string.len(self.input_text) <= 10 then
    self.input_text = self.input_text .. t
  end
end

function TextInputScreen:keypressed(key, scancode, isrepeat)
  if key == "return" then
    self.callback(self)
  end
  if key == "backspace" then
    -- get the byte offset to the last UTF-8 character in the string.
    local byteoffset = utf8.offset(self.input_text, - 1)

    if byteoffset then
      -- remove the last UTF-8 character.
      -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
      self.input_text = string.sub(self.input_text, 1, byteoffset - 1)
    end
  end
end
