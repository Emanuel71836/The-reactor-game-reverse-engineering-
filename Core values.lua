local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    warn("LocalPlayer not found. Script might not be running on the client.")
    return
end

-- --- UI Configuration ---
-- Find the TextLabel where you want to display the values.
-- Adjust the path below to match your UI hierarchy.
local scoreTextLabel: TextLabel? = script.Parent:FindFirstChild("ScoreTextLabel")
local levelTextLabel: TextLabel? = script.Parent:FindFirstChild("LevelTextLabel")
local itemsTextLabel: TextLabel? = script.Parent:FindFirstChild("ItemsTextLabel")

if not scoreTextLabel then warn("ScoreTextLabel not found.") end
if not levelTextLabel then warn("LevelTextLabel not found.") end
if not itemsTextLabel then warn("ItemsTextLabel not found.") end

-- --- Function to Get Game Values ---
local function getGameValues(): { [string]: any }
    -- Example: Getting values from Leaderstats
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    local score = leaderstats and leaderstats:FindFirstChild("Score") and leaderstats.Score.Value or 0
    local level = leaderstats and leaderstats:FindFirstChild("Level") and leaderstats.Level.Value or 1

    -- Example: Simulated values for items
    local items = {"Espada", "Escudo", "Poção"}

    return {
        Score = score,
        Level = level,
        Items = items
    }
end

-- --- Function to Update the UI ---
local function updateUI()
    local gameValues = getGameValues()

    if scoreTextLabel then
        scoreTextLabel.Text = "Pontuação: " .. tostring(gameValues.Score)
    end

    if levelTextLabel then
        levelTextLabel.Text = "Nível: " .. tostring(gameValues.Level)
    end

    if itemsTextLabel then
        itemsTextLabel.Text = "Itens: " .. table.concat(gameValues.Items, ", ")
    end
end

-- --- Event Connections for Dynamic Updates ---
-- Observe changes in Leaderstats
local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
if leaderstats then
    for _, stat in ipairs(leaderstats:GetChildren()) do
        if stat:IsA("IntValue") or stat:IsA("NumberValue") then
            stat.Changed:Connect(function()
                updateUI()
            end)
        end
    end
end

-- Initial UI update
updateUI()

print("Local Script for game UI loaded.")

