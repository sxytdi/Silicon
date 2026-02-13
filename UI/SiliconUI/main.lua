--[[─────────────────────────────────────────────
    ███████╗██╗██╗     ██╗ ██████╗ ██████╗ ███╗   ██╗
    ██╔════╝██║██║     ██║██╔════╝██╔═══██╗████╗  ██║
    ███████╗██║██║     ██║██║     ██║   ██║██╔██╗ ██║
    ╚════██║██║██║     ██║██║     ██║   ██║██║╚██╗██║
    ███████║██║███████╗██║╚██████╗╚██████╔╝██║ ╚████║
    ╚══════╝╚═╝╚══════╝╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝
    SiliconUI  •  v1.0.0
    Modern dark UI library for Roblox
─────────────────────────────────────────────]]

local SiliconUI  = { Flags = {} }

----------------------------------------------------------------
-- SERVICES
----------------------------------------------------------------
local TweenService    = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players         = game:GetService("Players")
local CoreGui         = game:GetService("CoreGui")
local LocalPlayer     = Players.LocalPlayer

----------------------------------------------------------------
-- THEME
----------------------------------------------------------------
local Theme = {
    Bg              = Color3.fromRGB(14, 14, 20),
    Bg2             = Color3.fromRGB(19, 19, 27),
    Bg3             = Color3.fromRGB(24, 24, 34),
    Element         = Color3.fromRGB(28, 28, 40),
    ElementHover    = Color3.fromRGB(34, 34, 48),
    Accent          = Color3.fromRGB(108, 92, 231),
    AccentDark      = Color3.fromRGB(82, 68, 190),
    Text            = Color3.fromRGB(230, 230, 240),
    SubText         = Color3.fromRGB(148, 148, 168),
    DimText         = Color3.fromRGB(90, 90, 108),
    Divider         = Color3.fromRGB(38, 38, 52),
    Border          = Color3.fromRGB(44, 44, 60),
    ToggleOff       = Color3.fromRGB(55, 55, 70),
    Success         = Color3.fromRGB(46, 213, 115),
    Warning         = Color3.fromRGB(255, 165, 2),
    Error           = Color3.fromRGB(255, 71, 87),
}

----------------------------------------------------------------
-- UTILITY HELPERS
----------------------------------------------------------------
local function Tween(obj, props, dur, style, dir)
    local t = TweenService:Create(
        obj,
        TweenInfo.new(dur or 0.28, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out),
        props
    )
    t:Play()
    return t
end

local function Make(class, props, kids)
    local i = Instance.new(class)
    for k, v in pairs(props or {}) do
        if k ~= "Parent" then i[k] = v end
    end
    for _, c in ipairs(kids or {}) do c.Parent = i end
    if props and props.Parent then i.Parent = props.Parent end
    return i
end

local function Corner(p, r)
    return Make("UICorner", { CornerRadius = UDim.new(0, r or 8), Parent = p })
end

local function Stroke(p, col, thick, trans)
    return Make("UIStroke", {
        Color = col or Theme.Border,
        Thickness = thick or 1,
        Transparency = trans or 0.55,
        Parent = p,
    })
end

local function Pad(p, t, b, l, r)
    return Make("UIPadding", {
        PaddingTop    = UDim.new(0, t or 8),
        PaddingBottom = UDim.new(0, b or 8),
        PaddingLeft   = UDim.new(0, l or 8),
        PaddingRight  = UDim.new(0, r or 8),
        Parent = p,
    })
end

local function List(p, gap, dir, hAlign, vAlign)
    return Make("UIListLayout", {
        Padding             = UDim.new(0, gap or 6),
        FillDirection       = dir or Enum.FillDirection.Vertical,
        HorizontalAlignment = hAlign or Enum.HorizontalAlignment.Center,
        VerticalAlignment   = vAlign or Enum.VerticalAlignment.Top,
        SortOrder           = Enum.SortOrder.LayoutOrder,
        Parent = p,
    })
end

local function Ripple(btn)
    btn.ClipsDescendants = true
    btn.MouseButton1Click:Connect(function()
        local mx = UserInputService:GetMouseLocation()
        local ap = btn.AbsolutePosition
        local sz = btn.AbsoluteSize
        local r  = Make("Frame", {
            BackgroundColor3       = Color3.new(1,1,1),
            BackgroundTransparency = 0.82,
            Position               = UDim2.new(0, mx.X - ap.X, 0, mx.Y - ap.Y - 36),
            Size                   = UDim2.new(0,0,0,0),
            AnchorPoint            = Vector2.new(0.5,0.5),
            ZIndex                 = btn.ZIndex + 1,
            Parent = btn,
        })
        Corner(r, 999)
        local d = math.max(sz.X, sz.Y) * 2.2
        Tween(r, {Size = UDim2.fromOffset(d,d), BackgroundTransparency = 1}, 0.45)
        task.delay(0.5, function() r:Destroy() end)
    end)
end

----------------------------------------------------------------
-- CREATE WINDOW
----------------------------------------------------------------
function SiliconUI:CreateWindow(cfg)
    cfg = cfg or {}
    local winName     = cfg.Name            or "SiliconUI"
    local loadTitle   = cfg.LoadingTitle     or "Silicon"
    local loadSub     = cfg.LoadingSubtitle  or "Loading…"
    local toggleKey   = cfg.ToggleKey        or Enum.KeyCode.RightShift
    local accentColor = cfg.AccentColor      or Theme.Accent

    Theme.Accent    = accentColor
    Theme.AccentDark = Color3.fromRGB(
        math.clamp(accentColor.R*255 - 26, 0, 255),
        math.clamp(accentColor.G*255 - 26, 0, 255),
        math.clamp(accentColor.B*255 - 26, 0, 255)
    )

    local WIN_W, WIN_H    = 560, 380
    local TAB_W, TOP_H    = 148, 44
    local ELEM_H           = 38

    local Window = { _tabs = {}, _activeTab = nil, _minimized = false }

    -- ScreenGui ------------------------------------------------
    local gui = Make("ScreenGui", {
        Name              = "SiliconUI",
        ZIndexBehavior    = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn      = false,
        IgnoreGuiInset    = true,
    })
    local ok, _ = pcall(function() gui.Parent = CoreGui end)
    if not gui.Parent then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    -- Main frame -----------------------------------------------
    local main = Make("Frame", {
        Name                   = "Main",
        BackgroundColor3       = Theme.Bg,
        Size                   = UDim2.fromOffset(WIN_W, WIN_H),
        Position               = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint            = Vector2.new(0.5, 0.5),
        ClipsDescendants       = true,
        Parent = gui,
    })
    Corner(main, 10)
    Stroke(main, Theme.Border, 1, 0.5)

    -- Drop shadow (image) --------------------------------------
    Make("ImageLabel", {
        BackgroundTransparency = 1,
        Position  = UDim2.new(0.5,0,0.5,0),
        Size      = UDim2.new(1,47,1,47),
        AnchorPoint = Vector2.new(0.5,0.5),
        Image     = "rbxassetid://5554236805",
        ImageColor3 = Color3.new(0,0,0),
        ImageTransparency = 0.35,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(23,23,277,277),
        ZIndex = -1,
        Parent = main,
    })

    ------------------------------------------------
    -- TOP BAR
    ------------------------------------------------
    local topBar = Make("Frame", {
        Name = "TopBar",
        BackgroundColor3 = Theme.Bg2,
        Size = UDim2.new(1,0,0,TOP_H),
        BorderSizePixel = 0,
        Parent = main,
    })
    Corner(topBar, 10)
    -- fill bottom corners of topbar
    Make("Frame", {
        BackgroundColor3 = Theme.Bg2,
        Size = UDim2.new(1,0,0,14),
        Position = UDim2.new(0,0,1,-14),
        BorderSizePixel = 0,
        Parent = topBar,
    })
    -- divider
    Make("Frame", {
        BackgroundColor3 = Theme.Divider,
        Size = UDim2.new(1,0,0,1),
        Position = UDim2.new(0,0,0,TOP_H),
        BorderSizePixel = 0,
        Parent = main,
    })

    -- accent dot
    Make("Frame", {
        BackgroundColor3 = Theme.Accent,
        Size = UDim2.fromOffset(8,8),
        Position = UDim2.new(0,14,0.5,0),
        AnchorPoint = Vector2.new(0,0.5),
        Parent = topBar,
    }, { Make("UICorner", {CornerRadius = UDim.new(1,0)}) })

    -- title
    Make("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0,28,0,0),
        Size     = UDim2.new(0.55,0,1,0),
        Font     = Enum.Font.GothamBold,
        Text     = winName,
        TextColor3 = Theme.Text,
        TextSize   = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = topBar,
    })

    -- controls
    local ctrls = Make("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.new(1,-82,0,0),
        Size     = UDim2.new(0,78,1,0),
        Parent   = topBar,
    })

    local function CtrlBtn(txt, order, hoverCol)
        local b = Make("TextButton", {
            BackgroundTransparency = 1,
            Size = UDim2.new(0,TOP_H-8, 1, 0),
            LayoutOrder = order,
            Font = Enum.Font.GothamBold,
            Text = txt,
            TextColor3 = Theme.SubText,
            TextSize = 13,
            AutoButtonColor = false,
            Parent = ctrls,
        })
        b.MouseEnter:Connect(function() Tween(b,{TextColor3=hoverCol},0.18) end)
        b.MouseLeave:Connect(function() Tween(b,{TextColor3=Theme.SubText},0.18) end)
        return b
    end
    List(ctrls, 0, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)

    local minBtn   = CtrlBtn("—", 1, Theme.Text)
    local closeBtn = CtrlBtn("✕", 2, Theme.Error)

    -- minimise
    minBtn.MouseButton1Click:Connect(function()
        Window._minimized = not Window._minimized
        Tween(main, { Size = Window._minimized
            and UDim2.fromOffset(WIN_W, TOP_H+1)
            or  UDim2.fromOffset(WIN_W, WIN_H)
        }, 0.35, Enum.EasingStyle.Back)
    end)

    -- close
    closeBtn.MouseButton1Click:Connect(function()
        Tween(main, {Size=UDim2.fromOffset(0,0), BackgroundTransparency=1}, 0.38)
        task.delay(0.4, function() gui:Destroy() end)
    end)

    ------------------------------------------------
    -- DRAGGING
    ------------------------------------------------
    do
        local dragging, dragInput, dragStart, startPos
        topBar.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = inp.Position
                startPos  = main.Position
                inp.Changed:Connect(function()
                    if inp.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        topBar.InputChanged:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
                dragInput = inp
            end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if inp == dragInput and dragging then
                local d = inp.Position - dragStart
                main.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + d.X,
                    startPos.Y.Scale, startPos.Y.Offset + d.Y
                )
            end
        end)
    end

    ------------------------------------------------
    -- CONTENT AREA
    ------------------------------------------------
    local content = Make("Frame", {
        Name = "Content",
        BackgroundTransparency = 1,
        Position = UDim2.new(0,0,0,TOP_H+1),
        Size     = UDim2.new(1,0,1,-(TOP_H+1)),
        ClipsDescendants = true,
        Parent   = main,
    })

    -- tab sidebar
    local sidebar = Make("Frame", {
        BackgroundColor3 = Theme.Bg2,
        Size = UDim2.new(0, TAB_W, 1, 0),
        BorderSizePixel = 0,
        Parent = content,
    })
    -- divider
    Make("Frame", {
        BackgroundColor3 = Theme.Divider,
        Size = UDim2.new(0,1,1,0),
        Position = UDim2.fromOffset(TAB_W, 0),
        BorderSizePixel = 0,
        Parent = content,
    })

    -- tab buttons scroll
    local tabScroll = Make("ScrollingFrame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1,0,1,0),
        CanvasSize = UDim2.new(0,0,0,0),
        ScrollBarThickness = 0,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Parent = sidebar,
    })
    Pad(tabScroll, 8, 8, 8, 8)
    local tabList = List(tabScroll, 4)
    tabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabScroll.CanvasSize = UDim2.fromOffset(0, tabList.AbsoluteContentSize.Y + 16)
    end)

    -- page area
    local pageArea = Make("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(TAB_W+1, 0),
        Size     = UDim2.new(1, -(TAB_W+1), 1, 0),
        ClipsDescendants = true,
        Parent   = content,
    })

    ------------------------------------------------
    -- NOTIFICATIONS
    ------------------------------------------------
    local notifHolder = Make("Frame", {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1,1),
        Position    = UDim2.new(1,-12,1,-12),
        Size        = UDim2.fromOffset(290, 600),
        Parent      = gui,
    })
    List(notifHolder, 8, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Bottom)

    function Window:Notify(cfg2)
        cfg2 = cfg2 or {}
        local title   = cfg2.Title    or "Notice"
        local body    = cfg2.Content  or ""
        local dur     = cfg2.Duration or 5
        local ntype   = cfg2.Type     or "Info"
        local colors  = { Info=Theme.Accent, Success=Theme.Success, Warning=Theme.Warning, Error=Theme.Error }
        local accent  = colors[ntype] or Theme.Accent

        local nf = Make("Frame", {
            BackgroundColor3       = Theme.Bg2,
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(290, 74),
            ClipsDescendants = true,
            Parent = notifHolder,
        })
        Corner(nf, 8); Stroke(nf, Theme.Border, 1, 0.55)

        -- accent bar
        local bar = Make("Frame", {
            BackgroundColor3 = accent,
            Size = UDim2.new(0,3,0.65,0),
            Position = UDim2.new(0,8,0.175,0),
            BorderSizePixel = 0,
            Parent = nf,
        }); Corner(bar, 2)

        Make("TextLabel", {
            BackgroundTransparency=1,
            Position=UDim2.fromOffset(20,10),
            Size=UDim2.new(1,-30,0,16),
            Font=Enum.Font.GothamBold,
            Text=title, TextColor3=Theme.Text, TextSize=13,
            TextXAlignment=Enum.TextXAlignment.Left,
            Parent=nf,
        })
        Make("TextLabel", {
            BackgroundTransparency=1,
            Position=UDim2.fromOffset(20,30),
            Size=UDim2.new(1,-30,0,30),
            Font=Enum.Font.Gotham,
            Text=body, TextColor3=Theme.SubText, TextSize=12,
            TextXAlignment=Enum.TextXAlignment.Left,
            TextYAlignment=Enum.TextYAlignment.Top,
            TextWrapped=true,
            Parent=nf,
        })

        -- progress
        local pbg = Make("Frame", {
            BackgroundColor3=Theme.Divider,
            Size=UDim2.new(0.88,0,0,2),
            Position=UDim2.new(0.06,0,1,-9),
            BorderSizePixel=0, Parent=nf,
        }); Corner(pbg,1)
        local pf = Make("Frame", {
            BackgroundColor3=accent,
            Size=UDim2.new(1,0,1,0),
            BorderSizePixel=0, Parent=pbg,
        }); Corner(pf,1)

        Tween(nf,{BackgroundTransparency=0},0.3)
        Tween(pf,{Size=UDim2.new(0,0,1,0)},dur,Enum.EasingStyle.Linear)
        task.delay(dur, function()
            Tween(nf,{BackgroundTransparency=1, Size=UDim2.fromOffset(290,0)},0.3)
            task.delay(0.35, function() nf:Destroy() end)
        end)
    end

    ------------------------------------------------
    -- TAB FACTORY
    ------------------------------------------------
    function Window:CreateTab(tcfg)
        tcfg = tcfg or {}
        local tabName = tcfg.Name or "Tab"
        local tabIcon = tcfg.Icon or nil

        local Tab = {}

        -- button
        local tBtn = Make("TextButton", {
            BackgroundColor3       = Theme.Element,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 34),
            Text = "", AutoButtonColor = false,
            Parent = tabScroll,
        })
        Corner(tBtn, 6)

        local txOff = tabIcon and 32 or 12
        local iconImg
        if tabIcon then
            iconImg = Make("ImageLabel", {
                BackgroundTransparency=1,
                Position=UDim2.new(0,10,0.5,0),
                Size=UDim2.fromOffset(16,16),
                AnchorPoint=Vector2.new(0,0.5),
                Image=tabIcon, ImageColor3=Theme.SubText,
                Parent=tBtn,
            })
        end

        local tLbl = Make("TextLabel", {
            BackgroundTransparency=1,
            Position=UDim2.fromOffset(txOff, 0),
            Size=UDim2.new(1,-txOff-8,1,0),
            Font=Enum.Font.GothamMedium,
            Text=tabName, TextColor3=Theme.SubText, TextSize=13,
            TextXAlignment=Enum.TextXAlignment.Left,
            Parent=tBtn,
        })

        local indicator = Make("Frame", {
            BackgroundColor3=Theme.Accent,
            Size=UDim2.new(0,3,0,0),
            Position=UDim2.new(0,0,0.5,0),
            AnchorPoint=Vector2.new(0,0.5),
            BorderSizePixel=0, Parent=tBtn,
        }); Corner(indicator,2)

        -- page
        local page = Make("ScrollingFrame", {
            BackgroundTransparency=1,
            Size=UDim2.new(1,0,1,0),
            CanvasSize=UDim2.new(0,0,0,0),
            ScrollBarThickness=2,
            ScrollBarImageColor3=Theme.Accent,
            ScrollingDirection=Enum.ScrollingDirection.Y,
            Visible=false,
            Parent=pageArea,
        })
        Pad(page,10,10,12,12)
        local pgList = List(page, 6)
        pgList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            page.CanvasSize = UDim2.fromOffset(0, pgList.AbsoluteContentSize.Y + 24)
        end)

        local info = { Btn=tBtn, Lbl=tLbl, Page=page, Ind=indicator, Icon=iconImg }
        table.insert(Window._tabs, info)

        local function Select()
            for _, t in ipairs(Window._tabs) do
                t.Page.Visible = false
                Tween(t.Btn, {BackgroundTransparency=1}, 0.2)
                Tween(t.Lbl, {TextColor3=Theme.SubText}, 0.2)
                Tween(t.Ind, {Size=UDim2.new(0,3,0,0)}, 0.2)
                if t.Icon then Tween(t.Icon,{ImageColor3=Theme.SubText},0.2) end
            end
            page.Visible = true
            Tween(tBtn, {BackgroundTransparency=0.55}, 0.2)
            Tween(tLbl, {TextColor3=Theme.Text}, 0.2)
            Tween(indicator, {Size=UDim2.new(0,3,0,18)}, 0.25, Enum.EasingStyle.Back)
            if iconImg then Tween(iconImg,{ImageColor3=Theme.Accent},0.2) end
            Window._activeTab = Tab
        end

        tBtn.MouseButton1Click:Connect(Select)
        tBtn.MouseEnter:Connect(function()
            if Window._activeTab ~= Tab then Tween(tBtn,{BackgroundTransparency=0.7},0.18) end
        end)
        tBtn.MouseLeave:Connect(function()
            if Window._activeTab ~= Tab then Tween(tBtn,{BackgroundTransparency=1},0.18) end
        end)

        if #Window._tabs == 1 then Select() end

        --------------------------------------------------------
        -- SECTION
        --------------------------------------------------------
        function Tab:CreateSection(name)
            local sf = Make("Frame", {
                BackgroundTransparency=1,
                Size=UDim2.new(1,0,0,22),
                Parent=page,
            })
            Make("TextLabel", {
                BackgroundTransparency=1,
                Size=UDim2.new(1,0,1,0),
                Font=Enum.Font.GothamBold,
                Text=(name or "Section"):upper(),
                TextColor3=Theme.DimText,
                TextSize=11,
                TextXAlignment=Enum.TextXAlignment.Left,
                Parent=sf,
            })
        end

        --------------------------------------------------------
        -- LABEL
        --------------------------------------------------------
        function Tab:CreateLabel(text)
            local lf = Make("Frame",{BackgroundColor3=Theme.Element,Size=UDim2.new(1,0,0,ELEM_H),Parent=page})
            Corner(lf,6)
            local ll = Make("TextLabel",{
                BackgroundTransparency=1,Position=UDim2.fromOffset(12,0),
                Size=UDim2.new(1,-24,1,0),Font=Enum.Font.Gotham,
                Text=text or"Label",TextColor3=Theme.Text,TextSize=13,
                TextXAlignment=Enum.TextXAlignment.Left,Parent=lf,
            })
            local obj={}
            function obj:Set(t) ll.Text=t end
            return obj
        end

        --------------------------------------------------------
        -- PARAGRAPH
        --------------------------------------------------------
        function Tab:CreateParagraph(pcfg)
            pcfg=pcfg or {}
            local pf = Make("Frame",{BackgroundColor3=Theme.Element,Size=UDim2.new(1,0,0,62),ClipsDescendants=true,Parent=page})
            Corner(pf,6)
            local pt = Make("TextLabel",{
                BackgroundTransparency=1,Position=UDim2.fromOffset(12,8),
                Size=UDim2.new(1,-24,0,18),Font=Enum.Font.GothamBold,
                Text=pcfg.Title or"",TextColor3=Theme.Text,TextSize=14,
                TextXAlignment=Enum.TextXAlignment.Left,Parent=pf,
            })
            local pc = Make("TextLabel",{
                BackgroundTransparency=1,Position=UDim2.fromOffset(12,28),
                Size=UDim2.new(1,-24,1,-36),Font=Enum.Font.Gotham,
                Text=pcfg.Content or"",TextColor3=Theme.SubText,TextSize=12,
                TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,
                TextWrapped=true,Parent=pf,
            })
            task.defer(function()
                task.wait()
                pf.Size=UDim2.new(1,0,0,math.max(62,pc.TextBounds.Y+42))
            end)
            local obj={}
            function obj:Set(c)
                if c.Title then pt.Text=c.Title end
                if c.Content then
                    pc.Text=c.Content
                    task.defer(function() task.wait()
                        pf.Size=UDim2.new(1,0,0,math.max(62,pc.TextBounds.Y+42))
                    end)
                end
            end
            return obj
        end

        --------------------------------------------------------
        -- BUTTON
        --------------------------------------------------------
        function Tab:CreateButton(bcfg)
            bcfg=bcfg or {}
            local bf = Make("TextButton",{
                BackgroundColor3=Theme.Element,
                Size=UDim2.new(1,0,0,ELEM_H),
                Text="",AutoButtonColor=false,
                Parent=page,
            })
            Corner(bf,6); Ripple(bf)

            Make("TextLabel",{
                BackgroundTransparency=1,Position=UDim2.fromOffset(12,0),
                Size=UDim2.new(1,-44,1,0),Font=Enum.Font.GothamMedium,
                Text=bcfg.Name or"Button",TextColor3=Theme.Text,TextSize=13,
                TextXAlignment=Enum.TextXAlignment.Left,Parent=bf,
            })
            local arrow=Make("TextLabel",{
                BackgroundTransparency=1,Position=UDim2.new(1,-28,0,0),
                Size=UDim2.fromOffset(18,38),Font=Enum.Font.GothamBold,
                Text="›",TextColor3=Theme.SubText,TextSize=18,Parent=bf,
            })

            bf.MouseEnter:Connect(function()
                Tween(bf,{BackgroundColor3=Theme.ElementHover},0.18)
                Tween(arrow,{TextColor3=Theme.Accent},0.18)
            end)
            bf.MouseLeave:Connect(function()
                Tween(bf,{BackgroundColor3=Theme.Element},0.18)
                Tween(arrow,{TextColor3=Theme.SubText},0.18)
            end)
            bf.MouseButton1Click:Connect(bcfg.Callback or function()end)
        end

        --------------------------------------------------------
        -- TOGGLE
        --------------------------------------------------------
        function Tab:CreateToggle(tcfg2)
            tcfg2=tcfg2 or {}
            local toggled = tcfg2.CurrentValue or false
            local cb      = tcfg2.Callback or function()end

            local tf = Make("TextButton",{
                BackgroundColor3=Theme.Element,
                Size=UDim2.new(1,0,0,ELEM_H),
                Text="",AutoButtonColor=false,Parent=page,
            })
            Corner(tf,6)

            Make("TextLabel",{
                BackgroundTransparency=1,Position=UDim2.fromOffset(12,0),
                Size=UDim2.new(1,-62,1,0),Font=Enum.Font.GothamMedium,
                Text=tcfg2.Name or"Toggle",TextColor3=Theme.Text,TextSize=13,
                TextXAlignment=Enum.TextXAlignment.Left,Parent=tf,
            })

            local swBg = Make("Frame",{
                BackgroundColor3=toggled and Theme.Accent or Theme.ToggleOff,
                Position=UDim2.new(1,-52,0.5,0),Size=UDim2.fromOffset(40,22),
                AnchorPoint=Vector2.new(0,0.5),Parent=tf,
            }); Corner(swBg,11)

            local swC = Make("Frame",{
                BackgroundColor3=Color3.new(1,1,1),
                Position=toggled and UDim2.new(1,-19,0.5,0) or UDim2.new(0,3,0.5,0),
                Size=UDim2.fromOffset(16,16),
                AnchorPoint=Vector2.new(0,0.5),Parent=swBg,
            }); Corner(swC,8)

            local function upd()
                Tween(swBg,{BackgroundColor3=toggled and Theme.Accent or Theme.ToggleOff},0.22)
                Tween(swC,{Position=toggled and UDim2.new(1,-19,0.5,0) or UDim2.new(0,3,0.5,0)},0.22,Enum.EasingStyle.Back)
            end

            tf.MouseButton1Click:Connect(function() toggled=not toggled; upd(); cb(toggled) end)
            tf.MouseEnter:Connect(function() Tween(tf,{BackgroundColor3=Theme.ElementHover},0.18) end)
            tf.MouseLeave:Connect(function() Tween(tf,{BackgroundColor3=Theme.Element},0.18) end)

            local obj={}
            function obj:Set(v) toggled=v; upd(); cb(v) end
            if tcfg2.Flag then SiliconUI.Flags[tcfg2.Flag]=obj end
            return obj
        end

        --------------------------------------------------------
        -- SLIDER
        --------------------------------------------------------
        function Tab:CreateSlider(scfg)
            scfg=scfg or {}
            local sName = scfg.Name or"Slider"
            local mn    = scfg.Range and scfg.Range[1] or 0
            local mx    = scfg.Range and scfg.Range[2] or 100
            local inc   = scfg.Increment or 1
            local cur   = scfg.CurrentValue or mn
            local suf   = scfg.Suffix or ""
            local cb    = scfg.Callback or function()end

            local sf = Make("Frame",{BackgroundColor3=Theme.Element,Size=UDim2.new(1,0,0,52),Parent=page})
            Corner(sf,6)

            Make("TextLabel",{
                BackgroundTransparency=1,Position=UDim2.fromOffset(12,0),
                Size=UDim2.new(0.6,0,0,30),Font=Enum.Font.GothamMedium,
                Text=sName,TextColor3=Theme.Text,TextSize=13,
                TextXAlignment=Enum.TextXAlignment.Left,Parent=sf,
            })
            local vl = Make("TextLabel",{
                BackgroundTransparency=1,Position=UDim2.new(1,-70,0,0),
                Size=UDim2.new(0,58,0,30),Font=Enum.Font.GothamMedium,
                Text=tostring(cur)..suf,TextColor3=Theme.Accent,TextSize=13,
                TextXAlignment=Enum.TextXAlignment.Right,Parent=sf,
            })

            local track = Make("Frame",{
                BackgroundColor3=Theme.Divider,
                Position=UDim2.new(0,12,0,34),Size=UDim2.new(1,-24,0,6),
                Parent=sf,
            }); Corner(track,3)

            local fill = Make("Frame",{
                BackgroundColor3=Theme.Accent,
                Size=UDim2.new((cur-mn)/(mx-mn),0,1,0),
                Parent=track,
            }); Corner(fill,3)

            local knob = Make("Frame",{
                BackgroundColor3=Color3.new(1,1,1),
                Size=UDim2.fromOffset(14,14),
                Position=UDim2.new((cur-mn)/(mx-mn),0,0.5,0),
                AnchorPoint=Vector2.new(0.5,0.5),Parent=track,
            }); Corner(knob,7)

            local sliding = false

            local function snap(v)
                v = math.clamp(v, mn, mx)
                v = math.floor(v/inc+0.5)*inc
                if inc >= 1 then v = math.floor(v)
                else
                    local dec = tostring(inc):match("%.(.+)")
                    if dec then v = tonumber(string.format("%."..#dec.."f",v)) end
                end
                return v
            end

            local function updSlider(inp)
                local r = math.clamp((inp.Position.X - track.AbsolutePosition.X)/track.AbsoluteSize.X,0,1)
                cur = snap(mn + r*(mx-mn))
                local s = (cur-mn)/(mx-mn)
                Tween(fill,{Size=UDim2.new(s,0,1,0)},0.04)
                Tween(knob,{Position=UDim2.new(s,0,0.5,0)},0.04)
                vl.Text = tostring(cur)..suf
                cb(cur)
            end

            track.InputBegan:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                    sliding=true; updSlider(i)
                end
            end)
            knob.InputBegan:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sliding=true end
            end)
            UserInputService.InputChanged:Connect(function(i)
                if sliding and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then updSlider(i) end
            end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sliding=false end
            end)

            local obj={}
            function obj:Set(v)
                cur=snap(v)
                local s=(cur-mn)/(mx-mn)
                Tween(fill,{Size=UDim2.new(s,0,1,0)},0.2)
                Tween(knob,{Position=UDim2.new(s,0,0.5,0)},0.2)
                vl.Text=tostring(cur)..suf; cb(cur)
            end
            if scfg.Flag then SiliconUI.Flags[scfg.Flag]=obj end
            return obj
        end

        --------------------------------------------------------
        -- DROPDOWN
        --------------------------------------------------------
        function Tab:CreateDropdown(dcfg)
            dcfg=dcfg or {}
            local dName  = dcfg.Name or"Dropdown"
            local opts   = dcfg.Options or {}
            local multi  = dcfg.MultiSelect or false
            local cb     = dcfg.Callback or function()end
            local sel    = multi and {} or (dcfg.CurrentOption or (opts[1] or ""))
            local opened = false

            if multi and type(dcfg.CurrentOption)=="table" then
                for _,v in ipairs(dcfg.CurrentOption) do sel[v]=true end
            end

            local df = Make("Frame",{
                BackgroundColor3=Theme.Element,
                Size=UDim2.new(1,0,0,ELEM_H),
                ClipsDescendants=true,Parent=page,
            }); Corner(df,6)

            local db = Make("TextButton",{
                BackgroundTransparency=1,
                Size=UDim2.new(1,0,0,ELEM_H),
                Text="",AutoButtonColor=false,Parent=df,
            })

            Make("TextLabel",{
                BackgroundTransparency=1,Position=UDim2.fromOffset(12,0),
                Size=UDim2.new(0.45,0,1,0),Font=Enum.Font.GothamMedium,
                Text=dName,TextColor3=Theme.Text,TextSize=13,
                TextXAlignment=Enum.TextXAlignment.Left,Parent=db,
            })

            local function selText()
                if multi then
                    local t={}
                    for k in pairs(sel) do t[#t+1]=k end
                    return #t>0 and table.concat(t,", ") or "None"
                end
                return tostring(sel)
            end

            local selLbl = Make("TextLabel",{
                BackgroundTransparency=1,Position=UDim2.new(0.45,0,0,0),
                Size=UDim2.new(0.55,-30,1,0),Font=Enum.Font.Gotham,
                Text=selText(),TextColor3=Theme.SubText,TextSize=12,
                TextXAlignment=Enum.TextXAlignment.Right,
                TextTruncate=Enum.TextTruncate.AtEnd,Parent=db,
            })
            local arrow = Make("TextLabel",{
                BackgroundTransparency=1,Position=UDim2.new(1,-24,0,0),
                Size=UDim2.fromOffset(18, ELEM_H),Font=Enum.Font.GothamBold,
                Text="▾",TextColor3=Theme.SubText,TextSize=14,Rotation=0,Parent=db,
            })

            local oc = Make("Frame",{
                BackgroundTransparency=1,
                Position=UDim2.fromOffset(0,ELEM_H+2),
                Size=UDim2.new(1,0,0,0),
                ClipsDescendants=true,Parent=df,
            })
            Pad(oc,0,6,6,6)
            local ol = List(oc,3)

            local function resize()
                local h = ol.AbsoluteContentSize.Y + 10
                Tween(df,{Size=UDim2.new(1,0,0,opened and (ELEM_H+h+4) or ELEM_H)},0.25)
                Tween(arrow,{Rotation=opened and 180 or 0},0.25)
            end

            local function makeOpt(n)
                local ob = Make("TextButton",{
                    Name=n,BackgroundColor3=Theme.Bg3,
                    Size=UDim2.new(1,0,0,28),Text="",AutoButtonColor=false,Parent=oc,
                }); Corner(ob,4)
                local olbl = Make("TextLabel",{
                    BackgroundTransparency=1,Position=UDim2.fromOffset(10,0),
                    Size=UDim2.new(1,-20,1,0),Font=Enum.Font.Gotham,
                    Text=n,TextColor3=Theme.SubText,TextSize=12,
                    TextXAlignment=Enum.TextXAlignment.Left,Parent=ob,
                })

                local function markSel(s)
                    Tween(olbl,{TextColor3=s and Theme.Accent or Theme.SubText},0.15)
                    Tween(ob,{BackgroundColor3=s and Theme.ElementHover or Theme.Bg3},0.15)
                end

                -- init highlight
                if multi then if sel[n] then markSel(true) end
                else if sel==n then markSel(true) end end

                ob.MouseEnter:Connect(function() Tween(ob,{BackgroundColor3=Theme.ElementHover},0.12) end)
                ob.MouseLeave:Connect(function()
                    local s = multi and sel[n] or (sel==n)
                    if not s then Tween(ob,{BackgroundColor3=Theme.Bg3},0.12) end
                end)

                ob.MouseButton1Click:Connect(function()
                    if multi then
                        sel[n]=not sel[n] or nil
                        for _,c in ipairs(oc:GetChildren()) do
                            if c:IsA("TextButton") then
                                markSel(sel[c.Name] and true or false)
                            end
                        end
                        selLbl.Text=selText()
                        local r={} for k in pairs(sel) do r[#r+1]=k end
                        cb(r)
                    else
                        sel=n
                        for _,c in ipairs(oc:GetChildren()) do
                            if c:IsA("TextButton") then
                                local s2=c.Name==n
                                local l2=c:FindFirstChildWhichIsA("TextLabel")
                                Tween(l2,{TextColor3=s2 and Theme.Accent or Theme.SubText},0.15)
                                Tween(c,{BackgroundColor3=s2 and Theme.ElementHover or Theme.Bg3},0.15)
                            end
                        end
                        selLbl.Text=selText(); cb(sel)
                        opened=false; resize()
                    end
                end)
            end

            for _,o in ipairs(opts) do makeOpt(o) end

            db.MouseButton1Click:Connect(function() opened=not opened; resize() end)
            db.MouseEnter:Connect(function() if not opened then Tween(df,{BackgroundColor3=Theme.ElementHover},0.15) end end)
            db.MouseLeave:Connect(function() Tween(df,{BackgroundColor3=Theme.Element},0.15) end)

            local obj={}
            function obj:Set(v)
                if multi then sel={}; if type(v)=="table" then for _,x in ipairs(v) do sel[x]=true end end
                else sel=v end
                selLbl.Text=selText()
                for _,c in ipairs(oc:GetChildren()) do
                    if c:IsA("TextButton") then
                        local s2=multi and sel[c.Name] or (sel==c.Name)
                        local l2=c:FindFirstChildWhichIsA("TextLabel")
                        l2.TextColor3=s2 and Theme.Accent or Theme.SubText
                        c.BackgroundColor3=s2 and Theme.ElementHover or Theme.Bg3
                    end
                end
            end
            function obj:Refresh(newOpts)
                for _,c in ipairs(oc:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
                opts=newOpts
                for _,o in ipairs(newOpts) do makeOpt(o) end
                if opened then task.defer(function() task.wait(); resize() end) end
            end
            if dcfg.Flag then SiliconUI.Flags[dcfg.Flag]=obj end
            return obj
        end

        --------------------------------------------------------
        -- INPUT
        --------------------------------------------------------
        function Tab:CreateInput(icfg)
            icfg=icfg or {}
            local cb=icfg.Callback or function()end

            local ifr = Make("Frame",{BackgroundColor3=Theme.Element,Size=UDim2.new(1,0,0,ELEM_H),Parent=page})
            Corner(ifr,6)
            Make("TextLabel",{
                BackgroundTransparency=1,Position=UDim2.fromOffset(12,0),
                Size=UDim2.new(0.42,0,1,0),Font=Enum.Font.GothamMedium,
                Text=icfg.Name or"Input",TextColor3=Theme.Text,TextSize=13,
                TextXAlignment=Enum.TextXAlignment.Left,Parent=ifr,
            })

            local tbc = Make("Frame",{
                BackgroundColor3=Theme.Bg3,
                Position=UDim2.new(0.42,8,0.5,0),Size=UDim2.new(0.58,-20,0,26),
                AnchorPoint=Vector2.new(0,0.5),Parent=ifr,
            }); Corner(tbc,5); local stk=Stroke(tbc,Theme.Border,1,0.65)

            local tb = Make("TextBox",{
                BackgroundTransparency=1,Position=UDim2.fromOffset(8,0),
                Size=UDim2.new(1,-16,1,0),Font=Enum.Font.Gotham,
                Text=icfg.CurrentValue or"",PlaceholderText=icfg.PlaceholderText or"Type…",
                PlaceholderColor3=Theme.DimText,TextColor3=Theme.Text,TextSize=12,
                ClearTextOnFocus=false,Parent=tbc,
            })

            tb.Focused:Connect(function()
                Tween(tbc,{BackgroundColor3=Theme.ElementHover},0.2)
                Tween(stk,{Color=Theme.Accent,Transparency=0.25},0.2)
            end)
            tb.FocusLost:Connect(function(enter)
                Tween(tbc,{BackgroundColor3=Theme.Bg3},0.2)
                Tween(stk,{Color=Theme.Border,Transparency=0.65},0.2)
                if enter then
                    cb(tb.Text)
                    if icfg.RemoveTextAfterFocusLost then tb.Text="" end
                end
            end)

            local obj={}
            function obj:Set(v) tb.Text=v end
            if icfg.Flag then SiliconUI.Flags[icfg.Flag]=obj end
            return obj
        end

        --------------------------------------------------------
        -- KEYBIND
        --------------------------------------------------------
        function Tab:CreateKeybind(kcfg)
            kcfg=kcfg or {}
            local curKey   = kcfg.CurrentKeybind or "None"
            local cb       = kcfg.Callback or function()end
            local listening= false

            local kf = Make("Frame",{BackgroundColor3=Theme.Element,Size=UDim2.new(1,0,0,ELEM_H),Parent=page})
            Corner(kf,6)
            Make("TextLabel",{
                BackgroundTransparency=1,Position=UDim2.fromOffset(12,0),
                Size=UDim2.new(0.6,0,1,0),Font=Enum.Font.GothamMedium,
                Text=kcfg.Name or"Keybind",TextColor3=Theme.Text,TextSize=13,
                TextXAlignment=Enum.TextXAlignment.Left,Parent=kf,
            })

            local kb = Make("TextButton",{
                BackgroundColor3=Theme.Bg3,
                Position=UDim2.new(1,-82,0.5,0),Size=UDim2.fromOffset(70,24),
                AnchorPoint=Vector2.new(0,0.5),Font=Enum.Font.GothamMedium,
                Text=curKey,TextColor3=Theme.SubText,TextSize=11,
                AutoButtonColor=false,Parent=kf,
            }); Corner(kb,5); Stroke(kb,Theme.Border,1,0.65)

            kb.MouseButton1Click:Connect(function()
                listening=true; kb.Text="…"
                Tween(kb,{BackgroundColor3=Theme.Accent,TextColor3=Theme.Text},0.18)
            end)

            UserInputService.InputBegan:Connect(function(i,gpe)
                if gpe then return end
                if listening then
                    if i.UserInputType==Enum.UserInputType.Keyboard then
                        curKey=i.KeyCode.Name; kb.Text=curKey; listening=false
                        Tween(kb,{BackgroundColor3=Theme.Bg3,TextColor3=Theme.SubText},0.18)
                    end
                else
                    if i.UserInputType==Enum.UserInputType.Keyboard and i.KeyCode.Name==curKey then
                        cb(curKey)
                    end
                end
            end)

            local obj={}
            function obj:Set(k) curKey=k; kb.Text=k end
            if kcfg.Flag then SiliconUI.Flags[kcfg.Flag]=obj end
            return obj
        end

        --------------------------------------------------------
        -- COLOR PICKER
        --------------------------------------------------------
        function Tab:CreateColorPicker(ccfg)
            ccfg=ccfg or {}
            local col = ccfg.Color or Color3.new(1,1,1)
            local cb  = ccfg.Callback or function()end
            local h,s,v = col:ToHSV()
            local opened = false

            local cf = Make("Frame",{
                BackgroundColor3=Theme.Element,
                Size=UDim2.new(1,0,0,ELEM_H),
                ClipsDescendants=true,Parent=page,
            }); Corner(cf,6)

            local cpBtn = Make("TextButton",{
                BackgroundTransparency=1,Size=UDim2.new(1,0,0,ELEM_H),
                Text="",AutoButtonColor=false,Parent=cf,
            })
            Make("TextLabel",{
                BackgroundTransparency=1,Position=UDim2.fromOffset(12,0),
                Size=UDim2.new(0.7,0,1,0),Font=Enum.Font.GothamMedium,
                Text=ccfg.Name or"Color",TextColor3=Theme.Text,TextSize=13,
                TextXAlignment=Enum.TextXAlignment.Left,Parent=cpBtn,
            })

            local preview = Make("Frame",{
                BackgroundColor3=col,
                Position=UDim2.new(1,-42,0.5,0),Size=UDim2.fromOffset(28,18),
                AnchorPoint=Vector2.new(0,0.5),Parent=cpBtn,
            }); Corner(preview,4); Stroke(preview,Theme.Border,1,0.5)

            -- SV canvas
            local svCanvas = Make("Frame",{
                BackgroundColor3=Color3.fromHSV(h,1,1),
                Position=UDim2.fromOffset(12,ELEM_H+6),
                Size=UDim2.new(1,-52,0,100),
                ClipsDescendants=true,Parent=cf,
            }); Corner(svCanvas,4)

            -- white → transparent (saturation)
            Make("UIGradient",{
                Color=ColorSequence.new(Color3.new(1,1,1),Color3.new(1,1,1)),
                Transparency=NumberSequence.new({
                    NumberSequenceKeypoint.new(0,0),
                    NumberSequenceKeypoint.new(1,1),
                }),
                Parent=svCanvas,
            })
            -- transparent → black (value)  overlay
            local darkOverlay = Make("Frame",{
                BackgroundColor3=Color3.new(0,0,0),
                BackgroundTransparency=0,
                Size=UDim2.new(1,0,1,0),
                Parent=svCanvas,
            }); Corner(darkOverlay,4)
            Make("UIGradient",{
                Color=ColorSequence.new(Color3.new(0,0,0),Color3.new(0,0,0)),
                Transparency=NumberSequence.new({
                    NumberSequenceKeypoint.new(0,1),
                    NumberSequenceKeypoint.new(1,0),
                }),
                Rotation=90,
                Parent=darkOverlay,
            })

            local svCur = Make("Frame",{
                BackgroundColor3=Color3.new(1,1,1),
                Size=UDim2.fromOffset(12,12),
                Position=UDim2.new(s,0,1-v,0),
                AnchorPoint=Vector2.new(0.5,0.5),
                ZIndex=3,Parent=svCanvas,
            }); Corner(svCur,6); Stroke(svCur,Color3.new(0,0,0),1.5,0)

            -- hue bar
            local hueBar = Make("Frame",{
                BackgroundColor3=Color3.new(1,1,1),
                Position=UDim2.new(1,-32,0,ELEM_H+6),
                Size=UDim2.fromOffset(18,100),
                Parent=cf,
            }); Corner(hueBar,5)
            Make("UIGradient",{
                Color=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,   Color3.fromRGB(255,0,0)),
                    ColorSequenceKeypoint.new(0.17,Color3.fromRGB(255,255,0)),
                    ColorSequenceKeypoint.new(0.33,Color3.fromRGB(0,255,0)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,255,255)),
                    ColorSequenceKeypoint.new(0.67,Color3.fromRGB(0,0,255)),
                    ColorSequenceKeypoint.new(0.83,Color3.fromRGB(255,0,255)),
                    ColorSequenceKeypoint.new(1,   Color3.fromRGB(255,0,0)),
                }),
                Rotation=90,Parent=hueBar,
            })
            local hueCur = Make("Frame",{
                BackgroundColor3=Color3.new(1,1,1),
                Size=UDim2.new(1,4,0,5),
                Position=UDim2.new(0.5,0,h,0),
                AnchorPoint=Vector2.new(0.5,0.5),
                ZIndex=3,Parent=hueBar,
            }); Corner(hueCur,2); Stroke(hueCur,Color3.new(0,0,0),1,0)

            local function updColor()
                local c=Color3.fromHSV(h,s,v)
                preview.BackgroundColor3=c
                svCanvas.BackgroundColor3=Color3.fromHSV(h,1,1)
                svCur.Position=UDim2.new(s,0,1-v,0)
                hueCur.Position=UDim2.new(0.5,0,h,0)
                cb(c)
            end

            local svD,hD = false,false
            svCanvas.InputBegan:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                    svD=true
                    s=math.clamp((i.Position.X-svCanvas.AbsolutePosition.X)/svCanvas.AbsoluteSize.X,0,1)
                    v=1-math.clamp((i.Position.Y-svCanvas.AbsolutePosition.Y)/svCanvas.AbsoluteSize.Y,0,1)
                    updColor()
                end
            end)
            hueBar.InputBegan:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                    hD=true
                    h=math.clamp((i.Position.Y-hueBar.AbsolutePosition.Y)/hueBar.AbsoluteSize.Y,0,1)
                    updColor()
                end
            end)
            UserInputService.InputChanged:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then
                    if svD then
                        s=math.clamp((i.Position.X-svCanvas.AbsolutePosition.X)/svCanvas.AbsoluteSize.X,0,1)
                        v=1-math.clamp((i.Position.Y-svCanvas.AbsolutePosition.Y)/svCanvas.AbsoluteSize.Y,0,1)
                        updColor()
                    end
                    if hD then
                        h=math.clamp((i.Position.Y-hueBar.AbsolutePosition.Y)/hueBar.AbsoluteSize.Y,0,1)
                        updColor()
                    end
                end
            end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then svD=false; hD=false end
            end)

            cpBtn.MouseButton1Click:Connect(function()
                opened=not opened
                Tween(cf,{Size=UDim2.new(1,0,0,opened and (ELEM_H+114) or ELEM_H)},0.28)
            end)

            local obj={}
            function obj:Set(c) h,s,v=c:ToHSV(); updColor() end
            if ccfg.Flag then SiliconUI.Flags[ccfg.Flag]=obj end
            return obj
        end

        return Tab
    end -- CreateTab

    ------------------------------------------------
    -- LOADING SCREEN
    ------------------------------------------------
    local lo = Make("Frame",{
        Name="Loading",BackgroundColor3=Theme.Bg,
        Size=UDim2.new(1,0,1,0),ZIndex=50,Parent=main,
    }); Corner(lo,10)

    Make("TextLabel",{
        BackgroundTransparency=1,
        Position=UDim2.new(0.5,0,0.34,0),Size=UDim2.new(0.8,0,0,28),
        AnchorPoint=Vector2.new(0.5,0.5),Font=Enum.Font.GothamBold,
        Text=loadTitle,TextColor3=Theme.Text,TextSize=22,ZIndex=51,Parent=lo,
    })
    Make("TextLabel",{
        BackgroundTransparency=1,
        Position=UDim2.new(0.5,0,0.34,22),Size=UDim2.new(0.8,0,0,18),
        AnchorPoint=Vector2.new(0.5,0),Font=Enum.Font.Gotham,
        Text=loadSub,TextColor3=Theme.SubText,TextSize=13,ZIndex=51,Parent=lo,
    })
    local lbg = Make("Frame",{
        BackgroundColor3=Theme.Divider,
        Position=UDim2.new(0.5,0,0.55,0),Size=UDim2.new(0.42,0,0,4),
        AnchorPoint=Vector2.new(0.5,0.5),ZIndex=51,Parent=lo,
    }); Corner(lbg,2)
    local lfl = Make("Frame",{
        BackgroundColor3=Theme.Accent,Size=UDim2.new(0,0,1,0),
        ZIndex=52,Parent=lbg,
    }); Corner(lfl,2)

    task.spawn(function()
        Tween(lfl,{Size=UDim2.new(1,0,1,0)},1.4,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut)
        task.wait(1.7)
        for _,d in ipairs(lo:GetDescendants()) do
            if d:IsA("TextLabel") then Tween(d,{TextTransparency=1},0.3) end
        end
        Tween(lbg,{BackgroundTransparency=1},0.3)
        Tween(lfl,{BackgroundTransparency=1},0.3)
        Tween(lo,{BackgroundTransparency=1},0.4)
        task.wait(0.45)
        lo:Destroy()
    end)

    ------------------------------------------------
    -- OPEN ANIMATION
    ------------------------------------------------
    main.Size = UDim2.fromOffset(0,0)
    main.BackgroundTransparency = 1
    Tween(main,{Size=UDim2.fromOffset(WIN_W,WIN_H),BackgroundTransparency=0},0.5,Enum.EasingStyle.Back)

    ------------------------------------------------
    -- TOGGLE KEY
    ------------------------------------------------
    UserInputService.InputBegan:Connect(function(i,gpe)
        if gpe then return end
        if i.KeyCode == toggleKey then
            main.Visible = not main.Visible
        end
    end)

    ------------------------------------------------
    -- DESTROY
    ------------------------------------------------
    function Window:Destroy()
        Tween(main,{Size=UDim2.fromOffset(0,0),BackgroundTransparency=1},0.38)
        task.delay(0.4, function() gui:Destroy() end)
    end

    return Window
end

return SiliconUI
