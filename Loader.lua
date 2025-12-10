repeat wait() until game:IsLoaded() 

if getgenv().map == "ASC" then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/arxdsdd07-arch/script/refs/heads/main/Protected_1379384898613797.lua"))()
elseif getgenv().map == "AUV" then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/arxdsdd07-arch/script/refs/heads/main/auv.lua"))()
else
    warn('')
end
