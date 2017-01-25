hs.grid.setGrid("8x6")
hs.grid.setMargins("0x0")
mod = {"cmd", "ctrl"}

-- Tile all the windows from the frontmost application
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "G", function()
    local app = hs.application.frontmostApplication();
    local windows = app:visibleWindows()
    local grid = hs.grid.getGrid()
    local n = #windows
    local t1 = grid.w / 2
    local t2 = grid.w
    if n == 0 then return end
    if n == 1 then
        hs.grid.set(windows[1], hs.geometry(0,0,grid.w,grid.h))
    elseif n < t1 then
        for i=1,n do
            local offset = (grid.w / n) * (i - 1)
            hs.grid.set(windows[i], hs.geometry(offset, 0, grid.w/n, grid.h))
        end
    else
        local perRow = math.sqrt(n)
        local width = math.ceil(grid.w / perRow)
        local height = math.floor(grid.h / perRow)
        local row = 0
        local col = 0
        for i=1,n do
            if (col * width + 1) > grid.w then
                row = row + 1
                col = 0
            end
            hs.grid.set(windows[i], hs.geometry(col * width, row * height, width, height))
            col = col + 1
        end
    end

end)

--quadrants
for i=1,4 do
    hs.hotkey.bind(mod, tostring(i), function()
        local win = hs.window.focusedWindow()
        if (i <= 2) then
            hs.grid.set(win, hs.geometry(4*(i-1),0,4*i,3))
        else
            hs.grid.set(win, hs.geometry(4*(i-3),3,4*(i-2),3))
        end
    end)
end

-- center screen
hs.hotkey.bind(mod, "5", function()
    local win = hs.window.focusedWindow()
    hs.grid.set(win, hs.geometry(2,1,4,4))
end)

-- "Main" view- left 3/4 of the screen
hs.hotkey.bind(mod, "M", function()
    local win = hs.window.focusedWindow()
    hs.grid.set(win, hs.geometry(0,0,6,6))
end)

-- "Side" view- right 1/4 of the screen
hs.hotkey.bind(mod, "S", function()
    local win = hs.window.focusedWindow()
    hs.grid.set(win, hs.geometry(6,0,2,6))
end)

-- Full screen
hs.hotkey.bind(mod, "0", function()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    local frame = screen:frame()
    win:setFrame(frame)
end)

-- Show the grid, for debugging
hs.hotkey.bind(mod, "T", function()
    hs.grid.toggleShow()
end)