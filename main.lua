local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Teleports GUI Script",
   LoadingTitle = "Loading GUI...",
   LoadingSubtitle = "by Omar_elshafie2013",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil,
      FileName = "Big Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"}
   }
})

local player = game.Players.LocalPlayer
local Pos1

local PTpTab = Window:CreateTab("Place Teleports", nil) -- Title, Image
local PlrTpTab = Window:CreateTab("Player Teleports", nil) -- Title, Image

local SPosSection = PTpTab:CreateSection("Save Teleports")

local STpDropdown = PTpTab:CreateDropdown({
   Name = "Choose Slot",
   Options = {"Position 1", "Position 2", "Position 3", "Position 4", "Position 5"},
   CurrentOption = {"Position 1"},
   MultipleOptions = false,
   Flag = "DropdownSTp",
   Callback = function(Option)
       -- The function that takes place when the selected option is changed
       -- The variable (Option) is a table of strings for the current selected options
   end,
})

local SavedPositions = {
   ["Position 1"] = nil,
   ["Position 2"] = nil,
   ["Position 3"] = nil,
   ["Position 4"] = nil,
   ["Position 5"] = nil,
}

local SetPosButton = PTpTab:CreateButton({
   Name = "Set Position",
   Callback = function()
       local selectedSlot = STpDropdown.CurrentOption[1]
       if selectedSlot then
           SavedPositions[selectedSlot] = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
           print("Position saved in slot:", selectedSlot)
       else
           print("No slot selected.")
       end
   end,
})

local TpPosButton = PTpTab:CreateButton({
   Name = "Tp To Position",
   Callback = function()
       local selectedSlot = STpDropdown.CurrentOption[1]
       if selectedSlot then
           local savedPosition = SavedPositions[selectedSlot]
           if savedPosition then
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
               print("Teleported to position in slot:", selectedSlot)
           else
               print("No position saved in slot:", selectedSlot)
           end
       else
           print("No slot selected.")
       end
   end,
})




local PlrTpSection = PlrTpTab:CreateSection("Player Teleports")

local playerNames = {}
local players = game.Players:GetPlayers()
for _, p in ipairs(players) do
    table.insert(playerNames, p.Name)
end

local PlrTpDropdown = PlrTpTab:CreateDropdown({
   Name = "Player Teleports",
   Options = playerNames,
   CurrentOption = playerNames[1] or "",
   MultipleOptions = false,
   Flag = "DropdownPlrTp",
   Callback = function(option)
       -- option is a table containing the selected option(s)
       -- option[1] will contain the selected player name
       local PlayerToUse = option[1]
       print("Selected player:", PlayerToUse)
       -- You can perform additional actions here based on the selected player
   end,
})

local PlrTpButton = PlrTpTab:CreateButton({
   Name = "Goto Player",
   Callback = function()
        local selectedPlayer = PlrTpDropdown.CurrentOption[1]
        if selectedPlayer then
            local gotoPlayer = game.Players:FindFirstChild(selectedPlayer)
            if gotoPlayer and gotoPlayer.Character and gotoPlayer.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = gotoPlayer.Character.HumanoidRootPart.CFrame
            else
                print("Selected player is not available or does not have a HumanoidRootPart.")
            end
        else
            print("No player selected.")
        end
   end,
})

