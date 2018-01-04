require('states')
require('colors')
require('Scene')
require('Button')

CreateCharacterScene = class('CreateCharacterScene', Scene)

function CreateCharacterScene:initialize(scene_name)
  Scene.initialize(self, scene_name)
  print(self.name .. " CreateCharacterScene initialized.")

  self.scene_name = scene_name
  self.buttons = {}
  self.title_font = love.graphics.newFont(18)
end

function CreateCharacterScene:update(dt)

end

function CreateCharacterScene:draw()
  setColor(color_white)
  love.graphics.setFont(self.title_font)
  love.graphics.printf(self.scene_name, 0, 75, love.graphics.getWidth(), "center")

  for i = 1, #self.buttons do
    self.buttons[i]:draw()
  end
end

function CreateCharacterScene:keypressed(key, scancode, isrepeat)
  print(key .. " pressed: CreateCharacterScene default behavior")
end

function CreateCharacterScene:mousepressed(x, y, button, isTouch)
  print("Mouse button " .. button .. " pressed in CreateCharacterScene")
  if button == 1 then
    for i = 1, #self.buttons do
      local hit = self.buttons[i]:catchMousePressedEvent(x, y)
      if hit then
        return
      end
    end
  end
end
