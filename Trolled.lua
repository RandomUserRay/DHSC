    local LocalPlayer = game.Players.LocalPlayer
    local Character = LocalPlayer.Character
    
    local IM = game:GetService("ReplicatedStorage").IM.ANIM
    
    local PlayersChar = workspace.Players
    
    if _G.JOINTWATCHER then
        _G.JOINTWATCHER:Disconnect()
    end
    
    local function Align(P0, P1, P, R)
        local A0, A1 = Instance.new("Attachment", P0), Instance.new("Attachment", P1)
        
        local AP, AO = Instance.new("AlignPosition", P0), Instance.new("AlignOrientation", P0)
        
        A1.Position = P
        A0.Rotation = R
        
        AP.RigidityEnabled = true
        AP.Responsiveness = 200
        AP.Attachment0 = A0
        AP.Attachment1 = A1
        
        AO.MaxTorque = 9e9
        AO.Responsiveness = 200
        AO.RigidityEnabled = true
        AO.Attachment0 = A0
        AO.Attachment1 = A1
        
        return A0, A1, AP, A0
    end
    
    _G.JOINTWATCHER = PlayersChar.DescendantAdded:Connect(function(Ins)
        if Ins:IsA("Weld") and Ins.Name == "GRABBING_CONSTRAINT" then
            repeat task.wait() until Ins.Part0 ~= nil
            repeat task.wait() until Ins:FindFirstChildOfClass("RopeConstraint")
            
            local AT0, AT1, AP, A0
            
            if Ins.Part0:IsDescendantOf(LocalPlayer.Character) then
                Ins:FindFirstChildOfClass("RopeConstraint").Length = 9e9
                
                
                Character.Humanoid:LoadAnimation(IM.RightAim):Play()
                
                AT0, AT1, AP, A0 = Align(Ins.Parent.UpperTorso, LocalPlayer.Character.RightHand, Vector3.new(0, 0, 0), Vector3.new(90, 0, 0))
            end
            
            repeat task.wait() until Ins.Parent == nil
            
        for i,v in pairs(game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):GetPlayingAnimationTracks()) do
        if (v.Animation.AnimationId:match("rbxassetid://13850675130")) then
        v:Stop()
        end
        end

        AT0:Destroy()
        AT1:Destroy()
        AP:Destroy()
        A0:Destroy()
    end
end)

local PLR = game:GetService("Players").LocalPlayer
local CHAR = game:GetService("Players").LocalPlayer.Character
local RIP_CD = false

    local RIPINHALF = Instance.new("Tool", PLR.Backpack)
    RIPINHALF.Name = "Rip In Half"
    RIPINHALF.CanBeDropped = false
    RIPINHALF.RequiresHandle = false
    RIPINHALF.Activated:connect(function()
        local GrabbedPLR = CHAR.BodyEffects:FindFirstChild("Grabbed")
        if GrabbedPLR.Value ~= nil then
            if RIP_CD == true then return end
            RIP_CD = true
            local GrabbedCHAR = GrabbedPLR.Value

            game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("I'm gonna rip you in half now...", "All")   
            GrabbedCHAR.RightUpperArm.Position = Vector3.new(0,-1200,0)
            GrabbedCHAR.LeftUpperArm.Position = Vector3.new(0,-1200,0)
            GrabbedCHAR.RightUpperLeg.Position = Vector3.new(0,-1200,0)
            GrabbedCHAR.LeftUpperLeg.Position = Vector3.new(0,-1200,0)
            task.wait(.1)
            game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer("Grabbing", false)
            RIP_CD = false
        end
end)
