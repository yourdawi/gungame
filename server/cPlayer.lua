addEvent("onSkinChangeBuy",true)
call ( getResourceFromName ( "scoreboard" ), "scoreboardAddColumn", "level" )
CPlayer = {}
Players = {}

--Constructor
function CPlayer:constructor(id,name,password,serial,kills,tode,coins,level,adminlvl,skin)
        self.ID = id
        self.Name = name
        self.Password = password
        self.Serial = serial
        self.Kills = kills
        self.Tode = tode
        self.Coins = coins
        self.Level = level
        self.Adminlvl = adminlvl
        self.Skin = skin
        self:setModel(skin)
        self.LoggedIn = true

        Players[self.ID] = self

        setElementData(self,"kills",self.Kills)
        setElementData(self,"tode",self.Tode)
        setElementData(self,"level",self.Level)
        setElementData(self,"coins",self.Coins)

        ---EVENTS
        self.eOnWasted = bind(CPlayer.onWasted, self)
        addEventHandler("onPlayerWasted",self, self.eOnWasted)

        self.eOnQuit = bind(CPlayer.onQuit,self)
        addEventHandler("onPlayerQuit",self,self.eOnQuit)

        self.eOnChangeSkinBuy = bind(CPlayer.onSkinBuy,self)
        addEventHandler("onSkinChangeBuy",self,self.eOnChangeSkinBuy)

        triggerClientEvent(self,"showPlayerHud",self,"true")
        triggerClientEvent(self,"jetztbindediescheisse",self)
end


--Functions

function CPlayer:onSkinBuy(id)
  if self.Coins >= 50 then
    self:setSkin(id)
    self:takeCoins(50)
  else
    outputChatBox("Not enough coins!",self,255,0,0)
  end
end

function CPlayer:onWasted(totalAmmo,killer,KillerWeapon,bodypart,stealth)
  self:newDeath(killer)
  if killer then
        if getElementType(killer) == "player" then
            killer:newKill(self)

				  if killer.Level == 15 and KillerWeapon ~= 4 then
                  outputChatBox(killer:getName().." has won the round!",getRootElement(),255,0,0)
                  killer:giveCoins(4)
                  for i,v in ipairs(getElementsByType("player")) do
                    if v:isLoggedIn() then
                      killPed(v)
                      v:setLevel(1)
                      v:spawning()
                    end
                  end


                elseif killer.Level <= 14 and KillerWeapon ~= 4 then
                    killer:levelUp()
                    self:spawning()


                elseif KillerWeapon == 4 then
                  killer:giveCoins(1)
                  self:levelDown()
                  self:spawning()
                end

      end
else
  outputChatBox("You killed yourself!",self,255,255,0)
  self:spawning()
end
end

function CPlayer:onQuit(quitType,reason,responsibleElement)
  DB:query("UPDATE players SET Serial=?, Kills=?, Tode=?, Coins=?, Level=?, Adminlvl=?, Skin=? WHERE Name=?", getPlayerSerial(self),self.Kills,self.Tode,self.Coins,self.Level,self.Adminlvl,self.Skin, self:getName() )
end

function CPlayer:setLevel(level)
  self.Level = level
  setElementData(self,"level",self.Level)
end

function CPlayer:newDeath(killer)
    self.Tode = self.Tode + 1
    setElementData(self,"tode",self.Tode)
    triggerClientEvent(self,"playLooser",self)
    if killer then
    outputChatBox("You are killed by "..killer:getName(),self,255,255,0)
  end
end

function CPlayer:newKill(opfer)
  self.Kills = self.Kills + 1
  setElementData(self,"kills",self.Kills)
  triggerClientEvent(self,"playWinner",self)
  outputChatBox("You killed "..opfer:getName(),self,255,255,0)
end

local WaffenListe = {}
WaffenListe[1] = 22 --Pistol
WaffenListe[2] = 24 --Deagle
WaffenListe[3] = 25 --Shotgun
WaffenListe[4] = 26 --Spawn-Off Shotgun
WaffenListe[5] = 27 --Spaz-12 Combat Shotgun
WaffenListe[6] = 28 --Uzi
WaffenListe[7] = 29 -- MP5
WaffenListe[8] = 32-- Tec-9
WaffenListe[9] = 30 --Ak47
WaffenListe[10] = 31 --M4
WaffenListe[11] = 33 -- Country Rifle
WaffenListe[12] = 34 -- Sniper
WaffenListe[13] = 35 --RPG
WaffenListe[14] = 36 --Jevelin
--WaffenListe[15] = 37 --Flammenwerfer
--WaffenListe[16] = 16 -- Granate
--WaffenListe[17] = 18 --Molotov
WaffenListe[15] = 38 --Minigun


function CPlayer:levelUp()
  self.Level = self.Level + 1
  setElementData(self,"level",self.Level)
  takeAllWeapons(self)
  giveWeapon(self,WaffenListe[self.Level],9999,true)
	giveWeapon(self,4)
end

function CPlayer:levelDown()
  outputChatBox("KNIFE KILL!",self,255,255,0)
  if self.Level > 1 then
    self.Level = self.Level - 1
    setElementData(self,"level",self.Level)
    takeAllWeapons(self)
    giveWeapon(self,WaffenListe[self.Level],9999,true)
  	giveWeapon(self,4)
  end
end

function CPlayer:giveCoins(coin)
  self.Coins = self.Coins + tonumber(coin)
  setElementData(self,"coins",self.Coins)
end

function CPlayer:takeCoins(coin)
  if self.Coins >= coin then
    self.Coins = self.Coins - coin
    setElementData(self,"coins",self.Coins)
  else
    return false
  end
end

function CPlayer:setKills(value)
  if value then
    self.Kills = value
    setElementData(self,"kills",self.Kills)
    return true
  end
end

function CPlayer:setDeath(value)
  if value then
    self.Tode = value
    setElementData(self,"tode",self.Tode)
    return true
  end
end

function CPlayer:setLevel(value)
  if value then
    self.Level = value
    setElementData(self,"level",self.Level)
  end
end
------------------SPAWN------------------------------

local SpawnPlatz = {}
SpawnPlatz[1] = {0,0,3}
SpawnPlatz[2] = {-296,-2.4000000953674,1.1000000238419}
SpawnPlatz[3] = {-196.69999694824,68.900001525879,3.0999999046326}
SpawnPlatz[4] = {-48.099998474121,6.0999999046326,3.0999999046326}
SpawnPlatz[5] = {-78.900001525879,-115,3.0999999046326}
SpawnPlatz[6] = {-142.5,-96.800003051758,3.0999999046326}
SpawnPlatz[7] = {-38.299999237061,98.099998474121,3.0999999046326}
SpawnPlatz[8] = {70.400001525879,52.200000762939,0.60000002384186}
SpawnPlatz[9] = {-142.5,50,3.0999999046326}
SpawnPlatz[10] = {-203.80000305176,222,11.800000190735}

local spawnRan = {}

function CPlayer:spawning()
  spawnRan[self] = math.random(1,10)
  setTimer(function()
  		spawnPlayer(self,SpawnPlatz[spawnRan[self]][1],SpawnPlatz[spawnRan[self]][2],SpawnPlatz[spawnRan[self]][3],0,self.Skin)
      setCameraTarget(self,self)
      fadeCamera(self,true)
      takeAllWeapons(self)
      giveWeapon(self,WaffenListe[self.Level],9999,true)
    	giveWeapon(self,4)
  		end,5000,1)
end

--Skin
function CPlayer:getSkin()
        return self.Skin
end

function CPlayer:setSkin(id)
        if setElementModel(self,id) then
                self.Skin = id
        else
                return false
        end
end





--Name

function CPlayer:getName()
        return self.Name
end

--login

function CPlayer:isLoggedIn()
  if self.LoggedIn then
    return true
  else
    return false
  end
end

--VIP

function CPlayer:getCoins()
  return self.Coins
end

function CPlayer:setCoins(value)
  if value then
    self.Coins = value
    setElementData(self,"coins",self.Coins)
    return true
  else
    return false
  end
end


--Admin

function CPlayer:isAdmin()
  if self.Adminlvl >= 1 then
    return true
  else
    return false
  end
end

function CPlayer:getAdminLevel()
  return self.Adminlvl
end

function CPlayer:save()
  x,y,z = getElementPosition(self)
  int = getElementInterior(self)
  dim = getElementDimension(self)
  _,_,rz = getElementRotation(self)
  spawn = tostring(x).."|"..tostring(y).."|"..tostring(z).."|"..tostring(int).."|"..tostring(dim).."|"..tostring(rz)

  DB:query("UPDATE players SET Serial=?, Kills=?, Tode=?, Coins=?, Level=?, Adminlvl=?, Skin=? WHERE Name=?", getPlayerSerial(self),self.Kills,self.Tode,self.Coins,self.Level,self.Adminlvl,self.Skin, self:getName() )
end
----SECURE SAVE
addEventHandler("onResourceStop",getResourceRootElement(getThisResource()),
function()
  for i,v in ipairs(getElementsByType("player")) do
    if v:isLoggedIn() then
      v:save()
    end
  end
end)

function CPlayer:destructor()
  self.LoggedIn = false
  Players[self.ID] = nil
end

--COMMANDHANDLER

addCommandHandler("set",
function(player,cmd,target,value,new)
if player:isAdmin() then
  if target and value and new then
    if getPlayerFromName(target) then
      target = getPlayerFromName(target)
      if tonumber(new) then
        new = tonumber(new)
        if value == "skin" then
          target:setSkin(new)
          outputChatBox(getPlayerName(target).."s "..value.." changed!",player,0,255,0)
        elseif value == "coins" then
          target:setCoins(new)
          outputChatBox(getPlayerName(target).."s "..value.." changed!",player,0,255,0)
        elseif value == "kills" then
          target:setKills(new)
          outputChatBox(getPlayerName(target).."s "..value.." changed!",player,0,255,0)
        elseif value == "death" then
          target:setDeath(new)
          outputChatBox(getPlayerName(target).."s "..value.." changed!",player,0,255,0)
        elseif value == "level" then
          target:setLevel(new)
          outputChatBox(getPlayerName(target).."s "..value.." changed!",player,0,255,0)
        end
      end
    else
      outputChatBox("Player not found!",player,255,0,0)
    end
  end
end
end)