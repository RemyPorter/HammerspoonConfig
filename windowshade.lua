shade = hs.menubar.new()
shade:setTitle("Shade")

shaded = {}

shade:setClickCallback(function()
    local win = hs.window.focusedWindow()
    local title = win:title()
    local img = win:snapshot(true)
    local frame = win:frame()
    local crop = hs.geometry(frame.x, frame.y, frame.w, 20)
    img = img:croppedImage(crop) --eventually, this will work, but the croppedImage function isn't available in the current release
    local draw = hs.drawing.image(frame, img)
    draw:bringToFront()
    draw:show()
    win:move(hs.geometry(-200,-200,0,0))
end)