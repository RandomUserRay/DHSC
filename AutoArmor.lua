local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

    if LocalPlayer.Character.BodyEffects.Armor.Value < 50 then 
        local Pos = LocalPlayer.Character.HumanoidRootPart.CFrame
        LocalPlayer.Character.HumanoidRootPart.CFrame = Workspace.Ignored.Shop["[High-Medium Armor] - $2440"].Head.CFrame
        wait(0.2)
        fireclickdetector(Workspace.Ignored.Shop["[High-Medium Armor] - $2440"].ClickDetector)
        RunService.RenderStepped:Wait()
        LocalPlayer.Character.HumanoidRootPart.CFrame = Pos 
    end
