local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "TradeControl"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 9999
gui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 420, 0, 320)
main.Position = UDim2.new(0.5, -210, 0.5, -160)
main.BackgroundColor3 = Color3.new(0, 0, 0)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui
local mainCorner = Instance.new("UICorner", main)
mainCorner.CornerRadius = UDim.new(0, 16)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Thickness = 2
mainStroke.Color = Color3.new(1, 1, 1)
mainStroke.Transparency = 0.7

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "TRADE CONTROL"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.Arcade
title.TextScaled = true
title.TextStrokeTransparency = 0.3
title.TextStrokeColor3 = Color3.new(0, 0, 0)
title.Parent = main

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.Arcade
closeBtn.TextScaled = true
closeBtn.Parent = main
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Victim Avatar Preview
local avatarFrame = Instance.new("Frame")
avatarFrame.Size = UDim2.new(0, 100, 0, 100)
avatarFrame.Position = UDim2.new(0.05, 0, 0.18, 0)
avatarFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
avatarFrame.Parent = main
local avatarCorner = Instance.new("UICorner", avatarFrame)
avatarCorner.CornerRadius = UDim.new(0, 12)
local avatarStroke = Instance.new("UIStroke", avatarFrame)
avatarStroke.Thickness = 1.5
avatarStroke.Color = Color3.new(1, 1, 1)
avatarStroke.Transparency = 0.8

local avatarImg = Instance.new("ImageLabel")
avatarImg.Size = UDim2.new(1, 0, 1, 0)
avatarImg.BackgroundTransparency = 1
avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=1&w=150&h=150"
avatarImg.Parent = avatarFrame
local imgCorner = Instance.new("UICorner", avatarImg)
imgCorner.CornerRadius = UDim.new(0, 12)

-- Input Label
local userLabel = Instance.new("TextLabel")
userLabel.Size = UDim2.new(0.5, 0, 0, 35)
userLabel.Position = UDim2.new(0.32, 0, 0.22, 0)
userLabel.BackgroundTransparency = 1
userLabel.Text = "Put Victim's Username"
userLabel.TextColor3 = Color3.new(1, 1, 1)
userLabel.Font = Enum.Font.Arcade
userLabel.TextScaled = true
userLabel.TextXAlignment = Enum.TextXAlignment.Left
userLabel.Parent = main

-- Input Box
local userInput = Instance.new("TextBox")
userInput.Size = UDim2.new(0.6, 0, 0, 45)
userInput.Position = UDim2.new(0.32, 0, 0.34, 0)
userInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
userInput.TextColor3 = Color3.new(1, 1, 1)
userInput.Font = Enum.Font.SourceSansBold
userInput.TextScaled = true
userInput.PlaceholderText = ""
userInput.Text = ""
userInput.ClearTextOnFocus = true
userInput.Parent = main
local inputCorner = Instance.new("UICorner", userInput)
inputCorner.CornerRadius = UDim.new(0, 12)
local inputStroke = Instance.new("UIStroke", userInput)
inputStroke.Thickness = 1.5
inputStroke.Color = Color3.new(1, 1, 1)
inputStroke.Transparency = 0.8

-- Real-time avatar update
userInput:GetPropertyChangedSignal("Text"):Connect(function()
	local name = userInput.Text
	if name ~= "" then
		local target = Players:FindFirstChild(name)
		if target then
			local thumb = "rbxthumb://type=AvatarHeadShot&id="..target.UserId.."&w=150&h=150"
			ContentProvider:PreloadAsync({thumb})
			avatarImg.Image = thumb
		else
			avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=1&w=150&h=150"
		end
	else
		avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=1&w=150&h=150"
	end
end)

-- Freeze Trade Button
local freezeBtn = Instance.new("TextButton")
freezeBtn.Size = UDim2.new(0.85, 0, 0, 50)
freezeBtn.Position = UDim2.new(0.075, 0, 0.55, 0)
freezeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
freezeBtn.Text = "FREEZE TRADE"
freezeBtn.TextColor3 = Color3.new(1, 1, 1)
freezeBtn.Font = Enum.Font.Arcade
freezeBtn.TextScaled = true
freezeBtn.Parent = main
local freezeCorner = Instance.new("UICorner", freezeBtn)
freezeCorner.CornerRadius = UDim.new(0, 14)
local freezeStroke = Instance.new("UIStroke", freezeBtn)
freezeStroke.Thickness = 2
freezeStroke.Color = Color3.new(1, 1, 1)
freezeStroke.Transparency = 0.7

-- Force Accept Button
local forceBtn = Instance.new("TextButton")
forceBtn.Size = UDim2.new(0.85, 0, 0, 50)
forceBtn.Position = UDim2.new(0.075, 0, 0.75, 0)
forceBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
forceBtn.Text = "FORCE ACCEPT"
forceBtn.TextColor3 = Color3.new(1, 1, 1)
forceBtn.Font = Enum.Font.Arcade
forceBtn.TextScaled = true
forceBtn.Parent = main
local forceCorner = Instance.new("UICorner", forceBtn)
forceCorner.CornerRadius = UDim.new(0, 14)
local forceStroke = Instance.new("UIStroke", forceBtn)
forceStroke.Thickness = 2
forceStroke.Color = Color3.new(1, 1, 1)
forceStroke.Transparency = 0.7

-- Click sound
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://9114487363"
clickSound.Volume = 0.6
clickSound.Parent = main

local function playClick()
	clickSound:Play()
end

-- === Р”РѕР±Р°РІР»СЏРµРј С„СѓРЅРєС†РёРѕРЅР°Р» РёР·РјРµРЅРµРЅРёСЏ С†РІРµС‚Р° РєРЅРѕРїРѕРє ===
local function toggleButtonColor(button)
	playClick()
	local isGreen = button:GetAttribute("IsGreen")
	if isGreen then
		-- Р’РѕР·РІСЂР°С‰Р°РµРј РІ СЃРµСЂС‹Р№
		button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		button:SetAttribute("IsGreen", false)
	else
		-- Р”РµР»Р°РµРј Р·РµР»С‘РЅС‹Рј
		button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		button:SetAttribute("IsGreen", true)
	end
end

-- РќР°Р·РЅР°С‡Р°РµРј РїРѕРІРµРґРµРЅРёРµ РЅР° РєРЅРѕРїРєРё
freezeBtn:SetAttribute("IsGreen", false)
forceBtn:SetAttribute("IsGreen", false)

freezeBtn.MouseButton1Click:Connect(function()
	toggleButtonColor(freezeBtn)
end)

forceBtn.MouseButton1Click:Connect(function()
	toggleButtonColor(forceBtn)
end)

closeBtn.MouseButton1Click:Connect(function()
	playClick()
	gui:Destroy()
end)

-- Pulse glow
spawn(function()
	while main.Parent do
		TweenService:Create(freezeStroke, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1), {Transparency = 0.4, Thickness = 3}):Play()
		TweenService:Create(forceStroke, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1), {Transparency = 0.4, Thickness = 3}):Play()
		task.wait(0.05)
	end
end)
