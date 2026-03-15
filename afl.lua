--Skidded lua code by meentoz v1
--Update tomorrow 👑😺😝

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local TELEPORT_SPEED = 1
local RESPAWN_WAIT_TIME = 60

local COORDS = {
    first = Vector3.new(-303.61, 27.43, -1599.01),
    second = Vector3.new(-287.71, 24.65, -1625.04)
}

local EGG_TYPES = {
    "CandyEggBlue",
    "CandyEggGreen", 
    "CandyEggPink",
    "CandyEggRed",
    "CandyEggYellow"
}

local farmingActive = false
local farmingThread = nil

local function findEggs()
    local eggs = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        for _, eggName in pairs(EGG_TYPES) do
            if obj.Name == eggName then
                table.insert(eggs, obj)
                break
            end
        end
    end
    return eggs
end

local function getEggPosition(egg)
    if egg:IsA("BasePart") then
        return egg.Position
    elseif egg:IsA("Model") then
        if egg.PrimaryPart then
            return egg.PrimaryPart.Position
        end
        for _, part in pairs(egg:GetChildren()) do
            if part:IsA("BasePart") then
                return part.Position
            end
        end
    end
    return nil
end

local function teleportTo(pos)
    local char = player.Character
    if not char then
        char = player.CharacterAdded:Wait()
    end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp and pos then
        hrp.CFrame = CFrame.new(pos)
        return true
    end
    return false
end

local function collectAllEggs()
    local eggs = findEggs()
    if #eggs == 0 then return 0 end
    
    local count = 0
    for i, egg in ipairs(eggs) do
        local pos = getEggPosition(egg)
        if pos then
            teleportTo(pos)
            count = count + 1
            print("Collect " .. count .. "/" .. #eggs)
            task.wait(TELEPORT_SPEED)
        end
    end
    return count
end

local function startFarming()
    while farmingActive do
        collectAllEggs()
        task.wait(1)
        teleportTo(COORDS.first)
        task.wait(1)
        teleportTo(COORDS.second)
        task.wait(RESPAWN_WAIT_TIME)
    end
end

local function toggleFarming()
    farmingActive = not farmingActive
    
    if farmingActive then
        print("🚀 Farm Start")
        if farmingThread then
            task.cancel(farmingThread)
        end
        farmingThread = task.spawn(startFarming)
    else
        print("⏹️ Farm Stop")
        if farmingThread then
            task.cancel(farmingThread)
            farmingThread = nil
        end
    end
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoFarmEggs2026"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = CoreGui

local mainContainer = Instance.new("Frame")
mainContainer.Name = "MainContainer"
mainContainer.Size = UDim2.new(0, 280, 0, 50)
mainContainer.Position = UDim2.new(0.5, -140, 0.5, -25)
mainContainer.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
mainContainer.BorderSizePixel = 0
mainContainer.Active = true
mainContainer.Parent = screenGui

local leftEgg = Instance.new("TextLabel")
leftEgg.Name = "LeftEgg"
leftEgg.Size = UDim2.new(0, 30, 0, 30)
leftEgg.Position = UDim2.new(0, 8, 0.5, -15)
leftEgg.BackgroundTransparency = 1
leftEgg.Text = "🥚"
leftEgg.TextSize = 24
leftEgg.TextColor3 = Color3.fromRGB(255, 255, 255)
leftEgg.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
leftEgg.TextStrokeTransparency = 0.3
leftEgg.Font = Enum.Font.SourceSans
leftEgg.Parent = mainContainer

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(0.6, 0, 1, 0)
titleLabel.Position = UDim2.new(0, 45, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "AutoFarm Eggs 2026"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.TextStrokeTransparency = 0.3
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainContainer

local rightEgg = Instance.new("TextLabel")
rightEgg.Name = "RightEgg"
rightEgg.Size = UDim2.new(0, 30, 0, 30)
rightEgg.Position = UDim2.new(1, -70, 0.5, -15)
rightEgg.BackgroundTransparency = 1
rightEgg.Text = "🥚"
rightEgg.TextSize = 24
rightEgg.TextColor3 = Color3.fromRGB(255, 255, 255)
rightEgg.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
rightEgg.TextStrokeTransparency = 0.3
rightEgg.Font = Enum.Font.SourceSans
rightEgg.Parent = mainContainer

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(1, -45, 0.5, -20)
toggleButton.BackgroundTransparency = 1
toggleButton.Text = ""
toggleButton.Parent = mainContainer

local arrowLabel = Instance.new("TextLabel")
arrowLabel.Name = "Arrow"
arrowLabel.Size = UDim2.new(1, 0, 1, 0)
arrowLabel.BackgroundTransparency = 1
arrowLabel.Text = "▼"
arrowLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
arrowLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
arrowLabel.TextStrokeTransparency = 0.3
arrowLabel.TextSize = 26
arrowLabel.Font = Enum.Font.SourceSansBold
arrowLabel.Parent = toggleButton

local mainPanel = Instance.new("Frame")
mainPanel.Name = "MainPanel"
mainPanel.Size = UDim2.new(1, 0, 0, 0)
mainPanel.Position = UDim2.new(0, 0, 0, 50)
mainPanel.BackgroundColor3 = Color3.fromRGB(255, 209, 220)
mainPanel.BorderSizePixel = 0
mainPanel.ClipsDescendants = true
mainPanel.Parent = mainContainer

local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, -20, 1, -20)
contentFrame.Position = UDim2.new(0, 10, 0, 10)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainPanel

local panelText = Instance.new("TextLabel")
panelText.Size = UDim2.new(1, 0, 0, 30)
panelText.BackgroundTransparency = 1
panelText.Text = "🥚 AutoFarm 🥚"
panelText.TextColor3 = Color3.fromRGB(255, 105, 180)
panelText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
panelText.TextStrokeTransparency = 0.5
panelText.TextSize = 18
panelText.Font = Enum.Font.GothamBold
panelText.Parent = contentFrame

local farmButton = Instance.new("TextButton")
farmButton.Name = "FarmButton"
farmButton.Size = UDim2.new(1, 0, 0, 35)
farmButton.Position = UDim2.new(0, 0, 0, 35)
farmButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
farmButton.BorderSizePixel = 0
farmButton.Text = "Autofarm (Off)"
farmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
farmButton.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
farmButton.TextStrokeTransparency = 0.4
farmButton.TextSize = 14
farmButton.Font = Enum.Font.GothamBold
farmButton.Parent = contentFrame

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.5, -5, 0, 25)
speedLabel.Position = UDim2.new(0, 0, 0, 80)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Speed:"
speedLabel.TextColor3 = Color3.fromRGB(255, 105, 180)
speedLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
speedLabel.TextStrokeTransparency = 0.5
speedLabel.TextSize = 14
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = contentFrame

local speedBox = Instance.new("TextBox")
speedBox.Name = "SpeedBox"
speedBox.Size = UDim2.new(0.5, -5, 0, 25)
speedBox.Position = UDim2.new(0.5, 5, 0, 80)
speedBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
speedBox.Text = tostring(TELEPORT_SPEED)
speedBox.TextColor3 = Color3.fromRGB(255, 105, 180)
speedBox.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
speedBox.TextStrokeTransparency = 0.5
speedBox.TextSize = 14
speedBox.Font = Enum.Font.Gotham
speedBox.PlaceholderText = "0.1-2.0 sec"
speedBox.ClearTextOnFocus = false
speedBox.Parent = contentFrame

local eggsRow = Instance.new("TextLabel")
eggsRow.Size = UDim2.new(1, 0, 0, 30)
eggsRow.Position = UDim2.new(0, 0, 0, 115)
eggsRow.BackgroundTransparency = 1
eggsRow.Text = "🥚 🥚 🥚 🥚 🥚"
eggsRow.TextColor3 = Color3.fromRGB(255, 182, 193)
eggsRow.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
eggsRow.TextStrokeTransparency = 0.6
eggsRow.TextSize = 24
eggsRow.Font = Enum.Font.SourceSans
eggsRow.Parent = contentFrame

local isOpen = false
local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

local function updateArrow()
    arrowLabel.Text = isOpen and "▲" or "▼"
end

local function toggleGUI()
    isOpen = not isOpen
    
    if isOpen then
        local openTween = TweenService:Create(mainPanel, tweenInfo, {
            Size = UDim2.new(1, 0, 0, 160)
        })
        openTween:Play()
    else
        local closeTween = TweenService:Create(mainPanel, tweenInfo, {
            Size = UDim2.new(1, 0, 0, 0)
        })
        closeTween:Play()
    end
    
    updateArrow()
end

farmButton.MouseButton1Click:Connect(function()
    toggleFarming()
    farmButton.Text = farmingActive and "Autofarm (On)" or "Autofarm (Off)"
    farmButton.BackgroundColor3 = farmingActive and Color3.fromRGB(76, 187, 23) or Color3.fromRGB(255, 105, 180)
end)

speedBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local newSpeed = tonumber(speedBox.Text)
        if newSpeed and newSpeed >= 0.1 and newSpeed <= 5 then
            TELEPORT_SPEED = newSpeed
            print("⚡ The speed has been changed to: " .. newSpeed .. " sec")
        else
            speedBox.Text = tostring(TELEPORT_SPEED)
            print("❌ Incorrect value! Use 0.1-5.0")
        end
    end
end)

local dragging = false
local dragStart
local startPos

mainContainer.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainContainer.Position
        
        mainContainer.ZIndex = 10
        mainPanel.ZIndex = 10
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainContainer.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X,
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and dragging then
        dragging = false
        mainContainer.ZIndex = 1
        mainPanel.ZIndex = 1
    end
end)

toggleButton.MouseButton1Click:Connect(toggleGUI)

updateArrow()
