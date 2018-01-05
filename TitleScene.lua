require('states')
require('colors')
require('Scene')
require('Button')
require('button_callbacks')

TitleScene = class('TitleScene', Scene)

function TitleScene:initialize(scene_name)
  Scene.initialize(self, scene_name)
  print(self.name .. " TitleScene initialized.")

  self.game_name = "Band"
  self.title_font = love.graphics.newFont(60)

  self.buttons = {}

  local winW = love.graphics.getWidth()
  local winH = love.graphics.getHeight()

  print(winW .. ", " .. winH)

  local button_font = love.graphics.newFont(18)
  local button_start = Button("button_start", "Play", {80, 80, 255}, color_white, button_font, startNewGame, winW * 0.75, winH * 0.9, winW * 0.2, winH * 0.08)
  table.insert(self.buttons, button_start)

  local button_quit = Button("button_quit", "Quit", {255, 80, 80}, color_white, button_font, quitGame, winW * 0.25 - winW * 0.2, winH * 0.9, winW * 0.2, winH * 0.08)
  table.insert(self.buttons, button_quit)
end

function TitleScene:update(dt)

end

function TitleScene:draw()
  setColor(color_white)
  love.graphics.setFont(self.title_font)
  love.graphics.printf(self.game_name, 0, 75, love.graphics.getWidth(), "center")

  for i = 1, #self.buttons do
    self.buttons[i]:draw()
  end
end

function TitleScene:keypressed(key, scancode, isrepeat)
  print(key .. " pressed: TitleScene default behavior")
end

function TitleScene:mousepressed(x, y, button, isTouch)
  print("Mouse button " .. button .. " pressed in TitleScene")
  if button == 1 then
    for i = 1, #self.buttons do
      local hit = self.buttons[i]:catchMousePressedEvent(x, y)
      if hit then
        return
      end
    end
  end
end
