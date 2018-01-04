--[[
  These functions are used as callbacks for the Button class
]]

require('main')

function startNewGame()
  print("startNewGame() called from buttonclick callback in TitleScene")
  active_scene = character_scene
end

-- Quit the game
-- Perform any necessary prompting or cleanup here.
-- Called when clicking on the Quit button
function quitGame()
  love.event.quit()
end
