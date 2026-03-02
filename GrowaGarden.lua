--[[
    ╔══════════════════════════════════════════╗
    ║        MOON HUB | SUPER CHEAT           ║
    ║         Grow A Garden  •  v1.0          ║
    ║     Loadstring 1 — KEYLESS (Main)       ║
    ╚══════════════════════════════════════════╝
    
    CARA PAKAI:
    Paste script ini langsung ke executor (Delta dll)
    Tidak perlu key untuk GUI utama ini.
    
    Untuk fitur Special GaG → buka Tab "Special"
    di dalam GUI, lalu input key untuk spawn GUI kedua.
]]

-- ═══════════════════════════════════════════
--              SERVICES
-- ═══════════════════════════════════════════
local Players         = game:GetService("Players")
local TweenService    = game:GetService("TweenService")
local UserInputService= game:GetService("UserInputService")
local RunService      = game:GetService("RunService")
local LocalPlayer     = Players.LocalPlayer

-- ═══════════════════════════════════════════
--            COLOR PALETTE (Dark Blue Moon)
-- ═══════════════════════════════════════════
local C = {
    BG_Main    = Color3.fromRGB(8,  12, 28),
    BG_Side    = Color3.fromRGB(12, 18, 40),
    BG_Content = Color3.fromRGB(15, 22, 50),
    BG_Card    = Color3.fromRGB(20, 30, 65),
    Accent     = Color3.fromRGB(50, 120, 255),
    AccentDim  = Color3.fromRGB(30, 70,  160),
    AccentGlow = Color3.fromRGB(80, 150, 255),
    ON         = Color3.fromRGB(50, 200, 120),
    OFF        = Color3.fromRGB(50, 55,  85),
    TextMain   = Color3.fromRGB(220,235,255),
    TextSub    = Color3.fromRGB(130,155,200),
    TextDim    = Color3.fromRGB(70, 90, 140),
    Border     = Color3.fromRGB(35, 55, 110),
    Red        = Color3.fromRGB(220, 60, 60),
    Moon       = Color3.fromRGB(180,210,255),
    Gold       = Color3.fromRGB(255,200, 50),
    Green      = Color3.fromRGB(50, 200,120),
}

-- ═══════════════════════════════════════════
--               STATE
-- ═══════════════════════════════════════════
local State = {
    Minimized  = false,
    ActiveTab  = "Farm",
    Toggles    = {
        AutoFarm   = false,
        AutoSell   = false,
        ESP        = false,
        Sprinkler  = false,
        StatusSeed = false,
    },
}

-- ═══════════════════════════════════════════
--          UTILITY FUNCTIONS
-- ═══════════════════════════════════════════
local function Corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = p
    return c
end

local function Stroke(p, col, th)
    local s = Instance.new("UIStroke")
    s.Color = col or C.Border
    s.Thickness = th or 1
    s.Parent = p
    return s
end

local function Tween(obj, props, t, style)
    TweenService:Create(obj,
        TweenInfo.new(t or 0.25, style or Enum.EasingStyle.Quart),
        props):Play()
end

local function Label(parent, props)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.Gotham
    l.TextColor3 = C.TextMain
    l.TextSize = 12
    for k,v in pairs(props) do l[k] = v end
    l.Parent = parent
    return l
end

local function Section(parent, txt)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,0,0,20)
    f.BackgroundTransparency = 1
    f.Parent = parent
    Label(f,{
        Size=UDim2.new(1,0,1,0),
        Text="  ▸  "..txt,
        TextColor3=C.Accent,
        TextXAlignment=Enum.TextXAlignment.Left,
        TextSize=10,
        Font=Enum.Font.GothamBold,
    })
    return f
end

-- ═══════════════════════════════════════════
--         LOADING SCREEN
-- ═══════════════════════════════════════════
local LoadGui = Instance.new("ScreenGui")
LoadGui.Name = "MoonHub_Load"
LoadGui.ResetOnSpawn = false
LoadGui.DisplayOrder = 999
LoadGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadGui.Parent = game.CoreGui

local LF = Instance.new("Frame")
LF.Size = UDim2.new(1,0,1,0)
LF.BackgroundColor3 = C.BG_Main
LF.BorderSizePixel = 0
LF.Parent = LoadGui

-- Bintang-bintang
for i=1,50 do
    local s = Instance.new("Frame")
    s.Size = UDim2.new(0,math.random(1,3),0,math.random(1,3))
    s.Position = UDim2.new(math.random(),0,math.random(),0)
    s.BackgroundColor3 = C.Moon
    s.BackgroundTransparency = math.random(4,9)/10
    s.BorderSizePixel = 0
    s.Parent = LF
    Corner(s,9)
end

-- Moon
Label(LF,{Size=UDim2.new(0,90,0,90),Position=UDim2.new(0.5,-45,0.22,0),
    Text="🌙",TextSize=64,Font=Enum.Font.GothamBold})

Label(LF,{Size=UDim2.new(0,420,0,44),Position=UDim2.new(0.5,-210,0.4,0),
    Text="MOON HUB",TextColor3=C.Moon,TextSize=34,Font=Enum.Font.GothamBold})

Label(LF,{Size=UDim2.new(0,420,0,26),Position=UDim2.new(0.5,-210,0.5,0),
    Text="SUPER CHEAT  •  Grow A Garden",TextColor3=C.TextSub,TextSize=13})

-- Bar BG
local BBG = Instance.new("Frame")
BBG.Size = UDim2.new(0,360,0,10)
BBG.Position = UDim2.new(0.5,-180,0.62,0)
BBG.BackgroundColor3 = C.BG_Card
BBG.BorderSizePixel = 0
BBG.Parent = LF
Corner(BBG,9)

local BFill = Instance.new("Frame")
BFill.Size = UDim2.new(0,0,1,0)
BFill.BackgroundColor3 = C.Accent
BFill.BorderSizePixel = 0
BFill.Parent = BBG
Corner(BFill,9)

local BPct = Label(LF,{Size=UDim2.new(0,360,0,22),
    Position=UDim2.new(0.5,-180,0.65,0),
    Text="0%",TextColor3=C.Accent,TextSize=12,Font=Enum.Font.GothamBold})

local BStatus = Label(LF,{Size=UDim2.new(0,360,0,22),
    Position=UDim2.new(0.5,-180,0.7,0),
    Text="Initializing...",TextColor3=C.TextSub,TextSize=11})

local function LoadStep(txt, pct, w)
    BStatus.Text = txt
    Tween(BFill, {Size=UDim2.new(pct,0,1,0)}, 0.55)
    local target = math.floor(pct*100)
    local current = tonumber(BPct.Text:match("%d+")) or 0
    for i=current, target, 2 do
        BPct.Text = i.."%"
        task.wait(0.01)
    end
    BPct.Text = target.."%"
    task.wait(w or 0.6)
end

-- ═══════════════════════════════════════════
--          MAIN GUI BUILDER
-- ═══════════════════════════════════════════
local function BuildMain()

    local SG = Instance.new("ScreenGui")
    SG.Name = "MoonHub_Main"
    SG.ResetOnSpawn = false
    SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    SG.DisplayOrder = 100
    SG.Parent = game.CoreGui

    -- ── Window ──
    local Win = Instance.new("Frame")
    Win.Name = "Window"
    Win.Size = UDim2.new(0,580,0,420)
    Win.Position = UDim2.new(0.5,-290,0.5,-210)
    Win.BackgroundColor3 = C.BG_Main
    Win.BorderSizePixel = 0
    Win.Active = true
    Win.Parent = SG
    Corner(Win,12)
    Stroke(Win,C.Border,1.5)

    -- ── Drag ──
    local drag,dStart,dPos = false,nil,nil
    Win.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then
            drag=true; dStart=i.Position; dPos=Win.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and i.UserInputType==Enum.UserInputType.MouseMovement then
            local d = i.Position - dStart
            Win.Position = UDim2.new(dPos.X.Scale, dPos.X.Offset+d.X,
                                     dPos.Y.Scale, dPos.Y.Offset+d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end
    end)

    -- ── TopBar ──
    local Top = Instance.new("Frame")
    Top.Size = UDim2.new(1,0,0,42)
    Top.BackgroundColor3 = C.BG_Side
    Top.BorderSizePixel = 0
    Top.ZIndex = 5
    Top.Parent = Win
    Corner(Top,12)
    -- fix bottom corners
    local TFix = Instance.new("Frame")
    TFix.Size = UDim2.new(1,0,0.5,0)
    TFix.Position = UDim2.new(0,0,0.5,0)
    TFix.BackgroundColor3 = C.BG_Side
    TFix.BorderSizePixel = 0
    TFix.ZIndex = 4
    TFix.Parent = Top

    Label(Top,{Size=UDim2.new(0,34,1,0),Position=UDim2.new(0,8,0,0),
        Text="🌙",TextSize=22,ZIndex=6})
    Label(Top,{Size=UDim2.new(0,280,1,0),Position=UDim2.new(0,44,0,0),
        Text="Moon Hub  |  Super Cheat",TextColor3=C.Moon,
        TextXAlignment=Enum.TextXAlignment.Left,TextSize=14,
        Font=Enum.Font.GothamBold,ZIndex=6})

    -- Mini & Close buttons
    local function TopBtn(xOff, bgCol, txt)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0,28,0,22)
        b.Position = UDim2.new(1,xOff,0.5,-11)
        b.BackgroundColor3 = bgCol
        b.Text = txt
        b.TextColor3 = C.TextMain
        b.TextSize = 13
        b.Font = Enum.Font.GothamBold
        b.BorderSizePixel = 0
        b.ZIndex = 6
        b.Parent = Top
        Corner(b,5)
        return b
    end

    local MinBtn   = TopBtn(-66, C.BG_Card, "─")
    local CloseBtn = TopBtn(-32, C.Red,     "✕")

    -- ── Content Holder ──
    local CH = Instance.new("Frame")
    CH.Size = UDim2.new(1,0,1,-42)
    CH.Position = UDim2.new(0,0,0,42)
    CH.BackgroundTransparency = 1
    CH.ClipsDescendants = true
    CH.Parent = Win

    -- ── Sidebar ──
    local Side = Instance.new("Frame")
    Side.Size = UDim2.new(0,135,1,0)
    Side.BackgroundColor3 = C.BG_Side
    Side.BorderSizePixel = 0
    Side.Parent = CH
    Stroke(Side,C.Border,1)

    local SideList = Instance.new("UIListLayout")
    SideList.Padding = UDim.new(0,4)
    SideList.Parent = Side
    local SP = Instance.new("UIPadding")
    SP.PaddingTop = UDim.new(0,10)
    SP.PaddingLeft = UDim.new(0,6)
    SP.PaddingRight = UDim.new(0,6)
    SP.Parent = Side

    -- ── Content Area ──
    local CA = Instance.new("Frame")
    CA.Size = UDim2.new(1,-135,1,0)
    CA.Position = UDim2.new(0,135,0,0)
    CA.BackgroundColor3 = C.BG_Content
    CA.BorderSizePixel = 0
    CA.ClipsDescendants = true
    CA.Parent = CH
    local CAP = Instance.new("UIPadding")
    CAP.PaddingAll = UDim.new(0,10)
    CAP.Parent = CA

    -- ── Pages ──
    local Pages, TabBtns = {}, {}

    local function MakePage(name)
        local pg = Instance.new("ScrollingFrame")
        pg.Name = name
        pg.Size = UDim2.new(1,0,1,0)
        pg.BackgroundTransparency = 1
        pg.BorderSizePixel = 0
        pg.ScrollBarThickness = 3
        pg.ScrollBarImageColor3 = C.Accent
        pg.Visible = false
        pg.CanvasSize = UDim2.new(0,0,0,0)
        pg.Parent = CA
        local ll = Instance.new("UIListLayout")
        ll.Padding = UDim.new(0,6)
        ll.Parent = pg
        ll:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            pg.CanvasSize = UDim2.new(0,0,0,ll.AbsoluteContentSize.Y+16)
        end)
        Pages[name] = pg
        return pg
    end

    local function SetTab(name)
        State.ActiveTab = name
        for n,pg in pairs(Pages) do pg.Visible = (n==name) end
        for n,btn in pairs(TabBtns) do
            if n==name then
                Tween(btn,{BackgroundColor3=C.AccentDim},0.2)
                btn.TextColor3=C.Moon
            else
                Tween(btn,{BackgroundColor3=Color3.fromRGB(0,0,0)},0.2)
                btn.BackgroundTransparency=1
                btn.TextColor3=C.TextSub
            end
        end
    end

    local Tabs = {
        {"Farm","🌱"},{"ESP","👁"},{"Spawner","🥚"},
        {"Seed","🌾"},{"Special","⚡"},{"Settings","⚙"},
    }

    for _,t in ipairs(Tabs) do
        MakePage(t[1])
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,0,0,34)
        btn.BackgroundColor3 = Color3.fromRGB(0,0,0)
        btn.BackgroundTransparency = 1
        btn.Text = t[2].."  "..t[1]
        btn.TextColor3 = C.TextSub
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamBold
        btn.BorderSizePixel = 0
        btn.Parent = Side
        Corner(btn,7)
        local bp = Instance.new("UIPadding")
        bp.PaddingLeft = UDim.new(0,8)
        bp.Parent = btn
        TabBtns[t[1]] = btn
        btn.MouseButton1Click:Connect(function() SetTab(t[1]) end)
    end

    -- ── Toggle Builder ──
    local function Toggle(parent, label, key, desc)
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1,0,0, desc and 54 or 42)
        card.BackgroundColor3 = C.BG_Card
        card.BorderSizePixel = 0
        card.Parent = parent
        Corner(card,8); Stroke(card,C.Border,1)

        Label(card,{Size=UDim2.new(1,-70,0,22),Position=UDim2.new(0,10,0,6),
            Text=label,TextXAlignment=Enum.TextXAlignment.Left,
            TextSize=12,Font=Enum.Font.GothamBold})

        if desc then
            Label(card,{Size=UDim2.new(1,-70,0,18),Position=UDim2.new(0,10,0,28),
                Text=desc,TextColor3=C.TextDim,
                TextXAlignment=Enum.TextXAlignment.Left,TextSize=10})
        end

        local tb = Instance.new("TextButton")
        tb.Size = UDim2.new(0,48,0,24)
        tb.Position = UDim2.new(1,-58,0.5,-12)
        tb.BackgroundColor3 = C.OFF
        tb.Text = ""; tb.BorderSizePixel = 0
        tb.Parent = card; Corner(tb,12)

        local circ = Instance.new("Frame")
        circ.Size = UDim2.new(0,18,0,18)
        circ.Position = UDim2.new(0,3,0.5,-9)
        circ.BackgroundColor3 = Color3.fromRGB(255,255,255)
        circ.BorderSizePixel = 0
        circ.Parent = tb; Corner(circ,9)

        local function Refresh(v)
            Tween(tb,{BackgroundColor3= v and C.ON or C.OFF},0.2)
            Tween(circ,{Position= v and UDim2.new(0,27,0.5,-9) or UDim2.new(0,3,0.5,-9)},0.2)
        end

        tb.MouseButton1Click:Connect(function()
            if key then
                State.Toggles[key] = not State.Toggles[key]
                Refresh(State.Toggles[key])
            end
        end)
        return card
    end

    -- ══════════════════════════
    --      🌱 FARM PAGE
    -- ══════════════════════════
    local FP = Pages["Farm"]
    Section(FP,"AUTO FARMING")
    Toggle(FP,"Auto Farm","AutoFarm","Otomatis harvest tanaman")
    Toggle(FP,"Auto Sell","AutoSell","Otomatis jual hasil panen")
    Section(FP,"WATERING")
    Toggle(FP,"Auto Sprinkler","Sprinkler","Aktifkan sprinkler otomatis")

    -- ══════════════════════════
    --      👁 ESP PAGE
    -- ══════════════════════════
    local EP = Pages["ESP"]
    Section(EP,"ESP SETTINGS")
    Toggle(EP,"Player ESP","ESP","Highlight semua player di map")

    local einfo = Instance.new("Frame")
    einfo.Size = UDim2.new(1,0,0,48)
    einfo.BackgroundColor3 = C.BG_Card
    einfo.BorderSizePixel = 0
    einfo.Parent = EP
    Corner(einfo,8); Stroke(einfo,C.Border,1)
    Label(einfo,{Size=UDim2.new(1,-16,1,0),Position=UDim2.new(0,8,0,0),
        Text="ℹ️  ESP menampilkan highlight pada\nplayer & item penting di sekitar kamu.",
        TextColor3=C.TextSub,TextXAlignment=Enum.TextXAlignment.Left,
        TextSize=11,TextWrapped=true})

    -- ══════════════════════════
    --   🥚 SPAWNER PAGE (Visual)
    -- ══════════════════════════
    local SPG = Pages["Spawner"]
    Section(SPG,"SPAWNER EGG  [ VISUAL ONLY ]")

    local eggs = {
        {"🥚 Common Egg",   C.TextSub},
        {"💙 Rare Egg",     C.Accent},
        {"💛 Legendary Egg",C.Gold},
        {"🌟 Ancient Egg",  C.Moon},
        {"🐛 Bug Egg",      C.Green},
    }

    for _,e in ipairs(eggs) do
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1,0,0,42)
        card.BackgroundColor3 = C.BG_Card
        card.BorderSizePixel = 0
        card.Parent = SPG
        Corner(card,8); Stroke(card,C.Border,1)

        Label(card,{Size=UDim2.new(1,-80,1,0),Position=UDim2.new(0,10,0,0),
            Text=e[1],TextColor3=e[2],
            TextXAlignment=Enum.TextXAlignment.Left,
            TextSize=12,Font=Enum.Font.GothamBold})

        local sb = Instance.new("TextButton")
        sb.Size = UDim2.new(0,62,0,26)
        sb.Position = UDim2.new(1,-72,0.5,-13)
        sb.BackgroundColor3 = C.Accent
        sb.Text = "Spawn"
        sb.TextColor3 = Color3.fromRGB(255,255,255)
        sb.TextSize = 11
        sb.Font = Enum.Font.GothamBold
        sb.BorderSizePixel = 0
        sb.Parent = card
        Corner(sb,6)

        sb.MouseButton1Click:Connect(function()
            sb.Text = "✓ Done"
            sb.BackgroundColor3 = C.ON
            task.wait(1.5)
            sb.Text = "Spawn"
            sb.BackgroundColor3 = C.Accent
        end)
    end

    local note = Instance.new("TextLabel")
    note.Size = UDim2.new(1,0,0,26)
    note.BackgroundTransparency = 1
    note.Text = "⚠️  Spawner bersifat VISUAL ONLY — tidak mempengaruhi game"
    note.TextColor3 = C.Gold
    note.TextSize = 10
    note.Font = Enum.Font.Gotham
    note.Parent = SPG

    -- ══════════════════════════
    --   🌾 SEED PAGE
    -- ══════════════════════════
    local SEDP = Pages["Seed"]
    Section(SEDP,"SEED MANAGER")
    Toggle(SEDP,"Status Seed","StatusSeed","Tampilkan status tiap seed")

    Section(SEDP,"SEED STATUS LIST")
    local seeds = {
        {"Wheat",      "Growing 🌱",  C.Green},
        {"Carrot",     "Ready ✅",    C.ON},
        {"Pumpkin",    "Watered 💧",  C.Accent},
        {"Strawberry", "Growing 🌱",  C.Green},
        {"Sunflower",  "Wilted ⚠️",   C.Gold},
        {"Blueberry",  "Ready ✅",    C.ON},
        {"Tomato",     "Growing 🌱",  C.Green},
    }

    for _,s in ipairs(seeds) do
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1,0,0,36)
        card.BackgroundColor3 = C.BG_Card
        card.BorderSizePixel = 0
        card.Parent = SEDP
        Corner(card,7); Stroke(card,C.Border,1)

        Label(card,{Size=UDim2.new(0.5,0,1,0),Position=UDim2.new(0,10,0,0),
            Text="🌾 "..s[1],
            TextXAlignment=Enum.TextXAlignment.Left,
            TextSize=12,Font=Enum.Font.GothamBold})

        Label(card,{Size=UDim2.new(0.5,-10,1,0),Position=UDim2.new(0.5,0,0,0),
            Text=s[2],TextColor3=s[3],
            TextXAlignment=Enum.TextXAlignment.Right,TextSize=11})
    end

    -- ══════════════════════════
    --   ⚡ SPECIAL PAGE (Key)
    -- ══════════════════════════
    local SPECP = Pages["Special"]
    Section(SPECP,"MOON HUB | SPECIAL GAG")

    -- Info card
    local infoCard = Instance.new("Frame")
    infoCard.Size = UDim2.new(1,0,0,52)
    infoCard.BackgroundColor3 = C.BG_Card
    infoCard.BorderSizePixel = 0
    infoCard.Parent = SPECP
    Corner(infoCard,8); Stroke(infoCard,C.Accent,1.5)

    Label(infoCard,{Size=UDim2.new(1,-16,1,0),Position=UDim2.new(0,8,0,0),
        Text="⚡ Fitur eksklusif Grow A Garden tersedia di GUI Special.\nSelesaikan task web → dapatkan KEY → Execute!",
        TextColor3=C.TextSub,TextXAlignment=Enum.TextXAlignment.Left,
        TextSize=11,TextWrapped=true})

    Section(SPECP,"KEY SYSTEM")

    -- Key card
    local KC = Instance.new("Frame")
    KC.Size = UDim2.new(1,0,0,178)
    KC.BackgroundColor3 = C.BG_Card
    KC.BorderSizePixel = 0
    KC.Parent = SPECP
    Corner(KC,10); Stroke(KC,C.Border,1.5)

    -- Key title
    local KTitle = Label(KC,{
        Size=UDim2.new(1,0,0,32),Position=UDim2.new(0,0,0,4),
        Text="🔑  Diperlukan KEY untuk GUI Special",
        TextColor3=C.Moon,TextSize=12,Font=Enum.Font.GothamBold})

    -- Key desc
    Label(KC,{Size=UDim2.new(1,-20,0,30),Position=UDim2.new(0,10,0,36),
        Text="Klik 'Get Key' → selesaikan task di web → copy key → paste di bawah",
        TextColor3=C.TextSub,TextXAlignment=Enum.TextXAlignment.Left,
        TextSize=10,TextWrapped=true})

    -- Input bar
    local KBarBG = Instance.new("Frame")
    KBarBG.Size = UDim2.new(1,-20,0,30)
    KBarBG.Position = UDim2.new(0,10,0,72)
    KBarBG.BackgroundColor3 = C.BG_Main
    KBarBG.BorderSizePixel = 0
    KBarBG.Parent = KC
    Corner(KBarBG,7); Stroke(KBarBG,C.Border,1)

    local KInput = Instance.new("TextBox")
    KInput.Size = UDim2.new(1,-12,1,0)
    KInput.Position = UDim2.new(0,8,0,0)
    KInput.BackgroundTransparency = 1
    KInput.PlaceholderText = "🔑  Paste key disini..."
    KInput.PlaceholderColor3 = C.TextDim
    KInput.Text = ""
    KInput.TextColor3 = C.TextMain
    KInput.TextXAlignment = Enum.TextXAlignment.Left
    KInput.TextSize = 12
    KInput.Font = Enum.Font.Gotham
    KInput.ClearTextOnFocus = false
    KInput.Parent = KBarBG

    -- Buttons row
    local function KBtn(xOff, w, bgCol, txt)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0,w,0,28)
        b.Position = UDim2.new(0,xOff,0,112)
        b.BackgroundColor3 = bgCol
        b.Text = txt
        b.TextColor3 = Color3.fromRGB(255,255,255)
        b.TextSize = 11
        b.Font = Enum.Font.GothamBold
        b.BorderSizePixel = 0
        b.Parent = KC
        Corner(b,6)
        return b
    end

    local GetKeyBtn = KBtn(10,  88, C.AccentDim, "🌐 Get Key")
    local PasteBtn  = KBtn(104, 75, C.BG_Side,   "📋 Paste")
    local ExecBtn   = KBtn(185, 85, C.ON,         "▶ Execute")
    Stroke(PasteBtn, C.Border, 1)

    -- Status label bawah card
    local KStatus = Label(KC,{
        Size=UDim2.new(1,-20,0,22),Position=UDim2.new(0,10,0,146),
        Text="Masukkan key yang valid untuk melanjutkan",
        TextColor3=C.TextDim,TextXAlignment=Enum.TextXAlignment.Left,TextSize=10})

    -- Sembunyikan execute dulu
    ExecBtn.Visible = false

    -- ⚠️ GANTI key berikut dengan key asli kamu
    local VALID_KEY = "MOONHUB-SPECIALGAG-2024"

    GetKeyBtn.MouseButton1Click:Connect(function()
        -- 🔗 GANTI URL berikut dengan link web task kamu
        pcall(function() setclipboard("https://linkvertise.com/moonhub-specialgag") end)
        GetKeyBtn.Text = "✓ Link Copied!"
        GetKeyBtn.BackgroundColor3 = C.ON
        task.wait(2)
        GetKeyBtn.Text = "🌐 Get Key"
        GetKeyBtn.BackgroundColor3 = C.AccentDim
    end)

    PasteBtn.MouseButton1Click:Connect(function()
        local ok, cb = pcall(getclipboard)
        if ok and cb and cb~="" then
            KInput.Text = cb
        end
    end)

    KInput:GetPropertyChangedSignal("Text"):Connect(function()
        local v = KInput.Text == VALID_KEY
        ExecBtn.Visible = v
        if v then
            Stroke(KC, C.ON, 2)
            KTitle.Text = "✅  KEY VALID — Siap Execute!"
            KTitle.TextColor3 = C.ON
            KStatus.Text = "Key diterima! Tekan Execute untuk spawn GUI Special"
            KStatus.TextColor3 = C.ON
        else
            Stroke(KC, C.Border, 1.5)
            KTitle.Text = "🔑  Diperlukan KEY untuk GUI Special"
            KTitle.TextColor3 = C.Moon
            KStatus.Text = "Masukkan key yang valid untuk melanjutkan"
            KStatus.TextColor3 = C.TextDim
        end
    end)

    ExecBtn.MouseButton1Click:Connect(function()
        ExecBtn.Text = "⏳ Loading..."
        ExecBtn.BackgroundColor3 = C.AccentDim
        -- 🔗 GANTI URL berikut dengan raw URL Loadstring 2 kamu
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/musgamerkeren23-afk/Mustafahub/refs/heads/main/MustafaHub.lua"))()
        end)
        task.wait(0.8)
        if ok then
            ExecBtn.Text = "✅ Loaded!"
            KStatus.Text = "Moon Hub | Special GaG berhasil di-load! 🌙"
            KStatus.TextColor3 = C.ON
        else
            ExecBtn.Text = "❌ Error"
            ExecBtn.BackgroundColor3 = C.Red
            KStatus.Text = "Gagal load: "..tostring(err)
            KStatus.TextColor3 = C.Red
            task.wait(2)
            ExecBtn.Text = "▶ Execute"
            ExecBtn.BackgroundColor3 = C.ON
        end
    end)

    -- ══════════════════════════
    --   ⚙ SETTINGS PAGE
    -- ══════════════════════════
    local SETP = Pages["Settings"]
    Section(SETP,"ABOUT")

    local about = Instance.new("Frame")
    about.Size = UDim2.new(1,0,0,90)
    about.BackgroundColor3 = C.BG_Card
    about.BorderSizePixel = 0
    about.Parent = SETP
    Corner(about,8); Stroke(about,C.Border,1)

    Label(about,{Size=UDim2.new(1,-16,1,0),Position=UDim2.new(0,8,0,0),
        Text="🌙  Moon Hub | Super Cheat\n"..
             "Versi  :  1.0\n"..
             "Game   :  Grow A Garden\n"..
             "Status :  Loadstring 1 — Keyless ✅",
        TextColor3=C.TextSub,TextXAlignment=Enum.TextXAlignment.Left,
        TextSize=11,TextWrapped=true})

    -- ── Minimize & Close ──
    MinBtn.MouseButton1Click:Connect(function()
        State.Minimized = not State.Minimized
        if State.Minimized then
            Tween(Win,{Size=UDim2.new(0,580,0,42)},0.3)
            MinBtn.Text = "□"
        else
            Tween(Win,{Size=UDim2.new(0,580,0,420)},0.3)
            MinBtn.Text = "─"
        end
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        Tween(Win,{Size=UDim2.new(0,580,0,0), BackgroundTransparency=1},0.3)
        task.wait(0.35)
        SG:Destroy()
    end)

    SetTab("Farm")
end

-- ═══════════════════════════════════════════
--          RUN LOADING → BUILD GUI
-- ═══════════════════════════════════════════
task.spawn(function()
    LoadStep("🌙 Initializing Moon Hub...",    0.10, 0.55)
    LoadStep("🔗 Connecting to server...",     0.30, 0.55)
    LoadStep("📦 Loading modules...",          0.50, 0.50)
    LoadStep("🌾 Setting up GaG features...", 0.72, 0.50)
    LoadStep("⚡ Almost done...",              0.90, 0.45)
    LoadStep("✅  Ready!",                     1.00, 0.35)

    -- Fade out loader
    for _,obj in ipairs(LF:GetDescendants()) do
        pcall(function()
            if obj:IsA("TextLabel") then
                Tween(obj,{TextTransparency=1},0.4)
            end
            if obj:IsA("Frame") then
                Tween(obj,{BackgroundTransparency=1},0.4)
            end
        end)
    end
    Tween(LF,{BackgroundTransparency=1},0.4)
    task.wait(0.5)
    LoadGui:Destroy()

    BuildMain()
end)
