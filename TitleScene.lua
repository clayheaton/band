require('states')
require('colors')
require('Scene')

TitleScene = class('TitleScene', Scene)

function TitleScene:initialize(scene_name)
  Scene.initialize(self, scene_name)
  print(self.name .. " TitleScene initialized.")

  self.game_name = "Band"
  self.title_font = love.graphics.newFont(60)
end

function TitleScene:update(dt)

end

function TitleScene:draw()
  setColor(color_white)
  love.graphics.setFont(self.title_font)
  love.graphics.printf(self.game_name, 0, 75, love.graphics.getWidth(), "center")
end

function TitleScene:keypressed(key, scancode, isrepeat)
  print(key .. " pressed: TitleScene default behavior")
end

function TitleScene:mousepressed(x, y, button, isTouch)
  print("Mouse button " .. button .. " pressed: TitleScene default behavior")
end
