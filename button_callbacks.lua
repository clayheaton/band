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

-- Callbacks for CreateCharacterScene
function CreateCharacterAdvanceStage()
  active_scene:advanceStage()
end

function CreateCharacterGoBackStage()
  active_scene:goBackStage()
end

function CreateCharacterFinish()
  active_scene:finishCharacter()
end
