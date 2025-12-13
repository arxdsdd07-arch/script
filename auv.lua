for i = 1,10 do
game:GetService("ReplicatedStorage"):WaitForChild("LobbyFolder"):WaitForChild("Remotes"):WaitForChild("Stock"):InvokeServer("Gold Shop",i,0/0)
end
task.wait()
game.Players.LocalPlayer:Kick('hehehe')
