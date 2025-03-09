local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:FindFirstChild("PlayerGui")
if not playerGui then return end
local CoreGui = game:GetService("CoreGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = CoreGui

local function addCorner(instance, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = instance
end

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 330)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -165)
mainFrame.BackgroundTransparency = 0
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.Parent = screenGui
mainFrame.Active = true
addCorner(mainFrame, 5)
mainFrame.Draggable = true

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
header.Parent = mainFrame
addCorner(header, 5)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.4, 0, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "Título Predeterminado"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.TextSize = 18
title.Font = Enum.Font.SourceSansBold
title.Parent = header

local description = Instance.new("TextLabel")
description.Size = UDim2.new(0.4, 0, 1, 0)
description.Position = UDim2.new(0.5, 0, 0, 0)
description.Text = "Descripción Predeterminada"
description.TextColor3 = Color3.fromRGB(150, 150, 150)
description.BackgroundTransparency = 1
description.TextSize = 16
description.Font = Enum.Font.SourceSans
description.TextXAlignment = Enum.TextXAlignment.Left
description.Parent = header

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 1, 0)
closeButton.Position = UDim2.new(1, -35, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundTransparency = 1
closeButton.TextSize = 16
closeButton.Parent = header
addCorner(closeButton, 5)

closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

local tabScroll = Instance.new("ScrollingFrame")
tabScroll.Size = UDim2.new(1, 0, 0, 40)
tabScroll.Position = UDim2.new(0, 0, 0, 40)
tabScroll.CanvasSize = UDim2.new(2, 0, 0, 0)
tabScroll.ScrollBarThickness = 1
tabScroll.BackgroundTransparency = 1
tabScroll.Parent = mainFrame

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 5)
tabLayout.Parent = tabScroll
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder

local tabFrames = {}

local function createTab(tabName)
	local tabButton = Instance.new("TextButton")
	tabButton.Size = UDim2.new(0, 130, 1, 0)
	tabButton.Text = tabName
	tabButton.BackgroundTransparency = 0.5
	tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	tabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	tabButton.Parent = tabScroll
	addCorner(tabButton, 5)

	local tabFrame = Instance.new("Frame")
	tabFrame.Size = UDim2.new(1, 0, 1, -80)
	tabFrame.Position = UDim2.new(0, 0, 0, 80)
	tabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	tabFrame.Visible = true
	tabFrame.BackgroundTransparency = 1
	tabFrame.Parent = mainFrame
	addCorner(tabFrame, 5)

	local frameScroll = Instance.new("ScrollingFrame")
	frameScroll.Size = UDim2.new(1, -10, 1, -10)
	frameScroll.Position = UDim2.new(0, 5, 0, 5)
	frameScroll.CanvasSize = UDim2.new(0, 0, 2, 0)
	frameScroll.ScrollBarThickness = 1
	frameScroll.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	frameScroll.Parent = tabFrame

	local buttonLayout = Instance.new("UIListLayout")
	buttonLayout.Padding = UDim.new(0, 5)
	buttonLayout.Parent = frameScroll
	buttonLayout.SortOrder = Enum.SortOrder.LayoutOrder

	tabFrames[tabName] = tabFrame

	tabButton.MouseButton1Click:Connect(function()
		for _, frame in pairs(tabFrames) do
			frame.Visible = false
		end
		tabFrame.Visible = true
	end)

	return frameScroll
end

local function addButtonToTab(tabName, buttonText, callback)
	local parentFrame = tabFrames[tabName]
	if not parentFrame then return end
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -10, 0, 40)
	button.Text = buttonText
	button.TextSize = 10
	button.BackgroundTransparency = 0
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	button.Parent = parentFrame:FindFirstChildOfClass("ScrollingFrame")
	addCorner(button, 5)
	button.MouseButton1Click:Connect(callback)
end

local function setHeader(newTitle, newDescription)
	title.Text = newTitle or "Título Predeterminado"
	description.Text = newDescription or "Descripción Predeterminada"
end

local function createLabel(tabName, labelText, position)
	local parentFrame = tabFrames[tabName]
	if not parentFrame then return end
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0, 300, 0, 40)
	label.Position = position or UDim2.new(0, 5, 0, 5)
	label.Text = labelText
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.BackgroundTransparency = 1
	label.TextSize = 16
	label.Font = Enum.Font.SourceSans
	label.Parent = parentFrame:FindFirstChildOfClass("ScrollingFrame")
end

createTab("Murder Mystery 2")
createTab("Murderers VS Sheriffs duel")
createTab("Silent Aimbot v4")
createTab("Be a Npc Or die")
createTab("MM2 Aim Trainer")

addButtonToTab("Murder Mystery 2", "Murder Mystery 2", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Jorgelinea/Ahj/refs/heads/main/Protected_5227260397926876.txt"))()
end)

createLabel("Murder Mystery 2", "I recommend the one above")

addButtonToTab("Murder Mystery 2", "Murder Mystery 2 (does not have a menu)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Sinnombrexd1/Lolol/refs/heads/main/%F0%9F%92%A6%F0%9F%97%A3%EF%B8%8F"))()
end)

addButtonToTab("Murderers VS Sheriffs duel", "Murderers VS Sheriffs duel", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/KSEEgARB"))()
end)

addButtonToTab("Silent Aimbot v4", "Silent Aimbot v4 {be careful in some games}", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/kT3sxuBY"))()
end)

addButtonToTab("Be a Npc Or die", "Be a Npc Or die", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/kxbdiNsq"))()
end)

addButtonToTab("MM2 Aim Trainer", "MM2 Aim Trainer", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Jorgelinea/Bysgisb/refs/heads/main/Protected_4742543876396808.txt", true))()
end)

setHeader("CapybaraScript", "Hub")
