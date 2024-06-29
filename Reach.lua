local LocalPlayer = game:GetService("Players").LocalPlayer
local ToolClone;
local Size = 50
local LeftHand_Save = LocalPlayer.Character.LeftHand.Size
local RightHand_Save = LocalPlayer.Character.RightHand.Size

local ANIM_TRACK = Instance.new("Animation")
ANIM_TRACK.AnimationId = "rbxassetid://2788290941"
local FakePunch = LocalPlayer.Character:WaitForChild("Humanoid"):LoadAnimation(ANIM_TRACK)
FakePunch.Priority = Enum.AnimationPriority.Action

-- Remove seats
for i, v in pairs(game.workspace.MAP:GetDescendants()) do 
	if v.ClassName == "Seat" and v.Disabled ~= true then 
		v.Disabled = true
	end
end


function FireRemote(NAME, STATE)
	game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer(NAME, STATE)
end

function RemoveMovement()
	for i = 1,15 do
		for i, v in pairs(LocalPlayer.Character:WaitForChild("BodyEffects"):FindFirstChild("Movement"):GetChildren()) do
			v:Destroy()
		end
		task.wait()
	end
end

function RefreshAnimations()
	LocalPlayer.Character.Animate.Disabled = true
	for _, v in ipairs(LocalPlayer.Character:WaitForChild("Humanoid"):GetPlayingAnimationTracks()) do
		v:Stop()
	end
	LocalPlayer.Character.Animate.Disabled = false
	task.wait()
end

function MouseIcon(STATE)
	if STATE then
		game:GetService("UserInputService").MouseIconEnabled = true
	else
		LocalPlayer.PlayerGui.MainScreenGui.AmmoFrame.Visible = false
		game:GetService("UserInputService").MouseIconEnabled = false
		LocalPlayer.PlayerGui.MainScreenGui.Aim.Bottom.BackgroundTransparency = 1
		LocalPlayer.PlayerGui.MainScreenGui.Aim.Left.BackgroundTransparency = 1
		LocalPlayer.PlayerGui.MainScreenGui.Aim.Right.BackgroundTransparency = 1
		LocalPlayer.PlayerGui.MainScreenGui.Aim.Top.BackgroundTransparency = 1
		LocalPlayer.PlayerGui.MainScreenGui.Aim.CursorImage.ImageTransparency = 1
		LocalPlayer.PlayerGui.MainScreenGui.Aim.BackgroundTransparency = 1
	end
end

function HandReach(STATE)
	if STATE then
		LocalPlayer.Character.RightHand.Size = Vector3.new(Size, Size, Size)
		LocalPlayer.Character.LeftHand.Size = Vector3.new(Size, Size, Size)
		LocalPlayer.Character.RightHand.Transparency = 1
		LocalPlayer.Character.LeftHand.Transparency = 1
		LocalPlayer.Character.RightHand.Massless = true
		LocalPlayer.Character.LeftHand.Massless = true
	else
		LocalPlayer.Character.RightHand.Size = Vector3.new(RightHand_Save)
		LocalPlayer.Character.LeftHand.Size = Vector3.new(LeftHand_Save)
		LocalPlayer.Character.RightHand.Transparency = 0
		LocalPlayer.Character.LeftHand.Transparency = 0
		LocalPlayer.Character.RightHand.Massless = false
		LocalPlayer.Character.LeftHand.Massless = false
	end
end

function BuyTool()
	warn("NO GUN FOUND BUYING GUN")
	local GlockSpot = workspace.Ignored.Shop:FindFirstChild('[Glock] - $318')
	repeat
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = GlockSpot:GetPivot() * CFrame.new(0,-5,0)
		fireclickdetector(GlockSpot.ClickDetector)
		game:GetService('RunService').Stepped:Wait()
	until game.Players.LocalPlayer.Backpack:FindFirstChild('[Glock]')
end

BuyTool()

if LocalPlayer.Character:FindFirstChild("Reach") then LocalPlayer.Character:FindFirstChild("Reach"):Destroy() end
if LocalPlayer.Backpack:FindFirstChild("Reach") then LocalPlayer.Backpack:FindFirstChild("Reach"):Destroy() end
local Tool = Instance.new("Tool", LocalPlayer.Backpack)
Tool.Name = "Reach"
Tool.CanBeDropped = false
Tool.RequiresHandle = false
Tool.TextureId = "rbxassetid://854037206" --16274800774
game.Players.LocalPlayer.CharacterAdded:Connect(function()
	if not game.Players.LocalPlayer.Backpack:FindFirstChild('Reach') then
		wait(1)
		ToolClone = Tool:Clone()
		ToolClone.Parent = game.Players.LocalPlayer.Backpack

		local Attacking = false
		local RemovingValues = false
		ToolClone.Activated:Connect(function()
			if not Attacking then
				Attacking = true
				local q=0
				for i, v in pairs(LocalPlayer.Backpack:GetChildren()) do
					if v:IsA("Tool") and q==0 then
						if v:FindFirstChild("Ammo") then
							q=q+1

							local Tool = v
							local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid")

							Humanoid:UnequipTools();

							if Tool then
								MouseIcon(false);
								for i = 1,20 do
									FireRemote("GunCombatToggle", true);
								end
						--[[repeat task.wait()
							FireRemote("GunCombatToggle", true);
						until LocalPlayer.Character:FindFirstChild("BodyEffects"):FindFirstChild("MousePos"):FindFirstChild("HandAttk").Value == true]]

								Humanoid:EquipTool(Tool);
								Tool:Activate();
								RemoveMovement();

								--repeat task.wait() until LocalPlayer.Character:FindFirstChild("BodyEffects"):FindFirstChild("Attacking").Value == true
								Humanoid:UnequipTools();
								MouseIcon(true);

								FakePunch:Play(.5);
								FakePunch:AdjustSpeed(0);
								FakePunch.TimePosition = 0.4

								LocalPlayer.Character:WaitForChild("Highlight");

								LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(Tool);

								HandReach(true);
								MouseIcon(false);
								Tool:Activate();
								task.wait()
								Tool:Deactivate();
								LocalPlayer:GetMouse()
								Humanoid:UnequipTools();
								MouseIcon(true);
								RemoveMovement();

								FakePunch:AdjustSpeed(1.5);

								for i = 1,15 do
									for i, v in pairs(Humanoid:GetPlayingAnimationTracks()) do
										if v.Animation.AnimationId:match("rbxassetid://2791876661") then
											v:Stop();
										end
									end
									task.wait()
								end

								repeat task.wait() until LocalPlayer.Character:FindFirstChild("BodyEffects"):FindFirstChild("Attacking").Value == false

								HandReach(false);
							end

							Attacking = false
						end
					end
				end
				if q == 0 then
					BuyTool();
				end
			end
		end)
	end
end)

local Attacking = false
local RemovingValues = false
Tool.Activated:Connect(function()
	if not Attacking then
		Attacking = true
		local q=0
		for i, v in pairs(LocalPlayer.Backpack:GetChildren()) do
			if v:IsA("Tool") and q==0 then
				if v:FindFirstChild("Ammo") then
					q=q+1

					local Tool = v
					local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid")

					Humanoid:UnequipTools();

					if Tool then
						MouseIcon(false);
						for i = 1,20 do
							FireRemote("GunCombatToggle", true);
						end
						--[[repeat task.wait()
							FireRemote("GunCombatToggle", true);
						until LocalPlayer.Character:FindFirstChild("BodyEffects"):FindFirstChild("MousePos"):FindFirstChild("HandAttk").Value == true]]

						Humanoid:EquipTool(Tool);
						Tool:Activate();
						RemoveMovement();

						--repeat task.wait() until LocalPlayer.Character:FindFirstChild("BodyEffects"):FindFirstChild("Attacking").Value == true
						Humanoid:UnequipTools();
						MouseIcon(true);

						FakePunch:Play(.5);
						FakePunch:AdjustSpeed(0);
						FakePunch.TimePosition = 0.4

						LocalPlayer.Character:WaitForChild("Highlight");

						LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(Tool);

						HandReach(true);
						MouseIcon(false);
						Tool:Activate();
						task.wait()
						Tool:Deactivate();
						LocalPlayer:GetMouse()
						Humanoid:UnequipTools();
						MouseIcon(true);
						RemoveMovement();

						FakePunch:AdjustSpeed(1.5);

						for i = 1,15 do
							for i, v in pairs(Humanoid:GetPlayingAnimationTracks()) do
								if v.Animation.AnimationId:match("rbxassetid://2791876661") then
									v:Stop();
								end
							end
							task.wait()
						end

						repeat task.wait() until LocalPlayer.Character:FindFirstChild("BodyEffects"):FindFirstChild("Attacking").Value == false

						HandReach(false);
					end

					Attacking = false
				end
			end
		end
		if q == 0 then
			BuyTool();
		end
	end
end)
