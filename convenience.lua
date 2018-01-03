require('colors')

function rectFill(x, y, w, h, color)
  setColor(color)
  love.graphics.rectangle("fill", x, y, w, h)
end

function rectStroke(x, y, w, h, color)
  setColor(color)
  love.graphics.rectangle("line", x, y, w, h)
end
