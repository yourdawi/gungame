
addEventHandler("onPlayerChangeNick",getRootElement(),
function()
cancelEvent()
end)

invalidChars = {}
for i = 33, 39 do
invalidChars[i] = true
end
for i = 40, 43 do
invalidChars[i] = true
end
invalidChars[47] = true
for i = 58, 64 do
invalidChars[i] = true
end
invalidChars[92] = true
invalidChars[94] = true
invalidChars[96] = true
for i = 123, 126 do
invalidChars[i] = true
end

function hasInvalidChar ( player )

	name = getPlayerName ( player )
	for i, index in pairs ( invalidChars ) do
		if not gettok ( name, 1, i ) or gettok ( name, 1, i ) ~= name then
			return true
		end
	end
	return false
end


addEventHandler("onPlayerJoin",getRootElement(),
function()
if hasInvalidChar(source) then
kickPlayer ( source, "Your name contains invalid characters!" )
end
end)

addEventHandler("onPlayerConnect",getRootElement(),
function(pName,pIP,pUSername,pSerial)
for i,v in ipairs(getElementsByType("player")) do
	if getPlayerSerial(v) == pSerial then
		cancelEvent(true,"Serial in use")
	end
end
end)


addEvent("loginPlayer",true)
addEventHandler("loginPlayer",getRootElement(),
function(pw)
local pname = getPlayerName(source)
local result = DB:query("SELECT * FROM players WHERE Name=?",pname)
result = result[1]
if result["Password"] == md5(pw) then
enew(source,CPlayer,result["ID"],pname,result["Password"],result["Serial"],result["Kills"],result["Tode"],result["Coins"],result["Level"],result["Adminlvl"],result["Skin"])
  outputChatBox("You successfully logged in!",source,0,255,0)
  outputChatBox("You will spawn in 5 seconds!",source,255,255,0)
  triggerClientEvent(source,"closePlayerLogin",source)
  source:spawning()
else
  outputChatBox("Wrong password!",source,255,0,0)
end
end)

---DEFAULT SETTINGS

local dKills = 0
local dTode = 0
local dCoins = 0
local dLevel = 1
local dAdminlvl = 0
local dSkin = 7

addEvent("registerPlayer",true)
addEventHandler("registerPlayer",getRootElement(),
function(pw,pwagain)
  local pname = getPlayerName(source)
  local result = DB:query("SELECT * FROM players WHERE Name=?",pname)
  if pw == pwagain then
    if #result > 0 then
        outputChatBox("ERROR: ACCOUNT ALREADY CREATED",source,255,0,0)
    else
	pw = md5(pw)
DB:query("INSERT INTO `players`(`Name`, `Password`, `Serial`, `Kills`, `Tode`, `Coins`, `Level`,`Adminlvl`,`Skin`) VALUES (?,?,?,?,?,?,?,?,?)",getPlayerName(source),pw,getPlayerSerial(source),dKills,dTode,dCoins,dLevel,dAdminlvl,dSkin)
result = DB:query("SELECT * FROM players WHERE Name=?",pname)
result = result[1]
  enew(source,CPlayer,result["ID"],pname,result["Password"],result["Serial"],result["Kills"],result["Tode"],result["Coins"],result["Level"],result["Adminlvl"],result["Skin"])
  source:spawning()
  triggerClientEvent(source,"closePlayerRegister",source)
  end
end
end)

addEvent("onPlayerReady",true)
addEventHandler("onPlayerReady",getRootElement(),
function()
local result = DB:query("SELECT * FROM players WHERE Name=?",getPlayerName(source))
fadeCamera(source,true)
if #result > 0 then
  triggerClientEvent(source,"showPlayerLogin",source)
else
  triggerClientEvent(source,"showPlayerRegister",source)
end
end)

-----
