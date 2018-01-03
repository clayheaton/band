require('colors')
require('convenience')

Button = class('Button')

function Button:initialize(name, label, color, text_color, button_font, action_function, x, y, w, h)
  self.name = name
  self.font = button_font
  self.label = label
  self.color = color
  self.text_color = text_color
  self.action_function = action_function
  self.x = x
  self.y = y
  self.w = w
  self.h = h

  self.x2 = self.x + self.w
  self.y2 = self.y + self.h
end

function Button:update(dt)

end

function Button:draw()
  rectFill(self.x, self.y, self.w, self.h, self.color)
  setColor({255, 255, 255})
  love.graphics.setFont(self.font)
  love.graphics.printf( self.label, self.x, self.y + (self.h / 3), self.w, "center" )
end

function Button:catchMousePressedEvent(x, y)
  if x >= self.x and x <= self.x2 and y >= self.y and y <= self.y2 then
    print(self.name, "clicked")
    self.action_function()
    return true
  end
  return false
end

-- Callbacks for button presses that affect scene transitions
-- This may need to move to be in the proper scope.
function startNewGame()
  print("startNewGame() called from buttonclick callback in TitleScene")
end
