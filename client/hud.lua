local counter = 0
local starttick
local currenttick
local frames = 0
addEventHandler("onClientRender",getRootElement(),
	function()
		if not starttick then
			starttick = getTickCount()
		end
		counter = counter + 1
		currenttick = getTickCount()
		if currenttick - starttick >= 1000 then
			frames = counter
			counter = 0
			starttick = false
		end
	end
)

local sx,sy = guiGetScreenSize()
local sxx,syy = 1280,720

function renderHUD()
      dxDrawText("Coins: "..getElementData(localPlayer,"coins"), 437/sxx*sx, 0/syy*sy, 578/sxx*sx, 21/syy*sy, tocolor(255, 255, 255, 255), 1/sxx*sx, "default-bold", "left", "top", false, false, false, false, false)
      dxDrawText("Level: "..getElementData(localPlayer,"level"), 578/sxx*sx, 0/syy*sy, 719/sxx*sx, 21/syy*sy, tocolor(255, 255, 255, 255), 1/sxx*sx, "default-bold", "left", "top", false, false, false, false, false)
      dxDrawText("Kills: "..getElementData(localPlayer,"kills"), 719/sxx*sx, 0/syy*sy, 860/sxx*sx, 21/syy*sy, tocolor(255, 255, 255, 255), 1/sxx*sx, "default-bold", "left", "top", false, false, false, false, false)
      dxDrawText("Death: "..getElementData(localPlayer,"tode"), 860/sxx*sx, 0/syy*sy, 1001/sxx*sx, 21/syy*sy, tocolor(255, 255, 255, 255), 1/sxx*sx, "default-bold", "left", "top", false, false, false, false, false)
      dxDrawText("Ping: "..getPlayerPing(localPlayer).." | FPS: "..frames , 1001/sxx*sx, 0/syy*sy, 1142/sxx*sx, 21/syy*sy, tocolor(255, 255, 255, 255), 1/sxx*sx, "default-bold", "left", "top", false, false, false, false, false)
end

function showHud(state)
  if state == "true" then
  addEventHandler("onClientRender",getRootElement(),renderHUD)
else
  removeEventHandler("onClientRender",getRootElement(),renderHUD)
end
end

addEvent("showPlayerHud",true)
addEventHandler("showPlayerHud",getRootElement(),showHud)


addEvent("playLooser",true)

addEvent("playWinner",true)

addEventHandler("playWinner",getRootElement(),
function()
playSound("res/sounds/win.mp3")
end)

addEventHandler("playLooser",getRootElement(),
function()
playSound("res/sounds/die.mp3")
end)

addEventHandler("onClientPlayerDamage",getRootElement(),
function(attacker,weapon)
if weapon == 0 then
cancelEvent()
end
end)

addEventHandler("onClientPlayerDamage",getRootElement(),
function(attacker,weapon)
if not (attacker) then
cancelEvent()
end
end)


-------------------


local theSkins = {
[7]= true,
[9]= true,
[10]= true,
[11]= true,
[12]= true,
[13]= true,
[14]= true,
[15]= true,
[16]= true,
[17]= true,
[18]= true,
[19]= true,
[20]= true,
[21]= true,
[22]= true,
[23]= true,
[24]= true,
[25]= true,
[26]= true,
[27]= true,
[28]= true,
[29]= true,
[30]= true,
[31]= true,
[32]= true,
[33]= true,
[34]= true,
[35]= true,
[36]= true,
[37]= true,
[38]= true,
[39]= true,
[40]= true,
[41]= true,
[43]= true,
[44]= true,
[45]= true,
[46]= true,
[47]= true,
[48]= true,
[49]= true,
[50]= true,
[51]= true,
[52]= true,
[53]= true,
[54]= true,
[55]= true,
[56]= true,
[57]= true,
[58]= true,
[59]= true,
[60]= true,
[61]= true,
[62]= true,
[63]= true,
[64]= true,
[66]= true,
[67]= true,
[68]= true,
[69]= true,
[70]= true,
[71]= true,
[72]= true,
[73]= true,
[75]= true,
[76]= true,
[77]= true,
[78]= true,
[79]= true,
[80]= true,
[81]= true,
[82]= true,
[83]= true,
[84]= true,
[85]= true,
[87]= true,
[88]= true,
[89]= true,
[90]= true,
[91]= true,
[92]= true,
[93]= true,
[94]= true,
[95]= true,
[96]= true,
[97]= true,
[98]= true,
[99]= true,
[100]= true,
[101]= true,
[102]= true,
[103]= true,
[104]= true,
[105]= true,
[106]= true,
[107]= true,
[108]= true,
[109]= true,
[110]= true,
[111]= true,
[112]= true,
[113]= true,
[114]= true,
[115]= true,
[116]= true,
[117]= true,
[118]= true,
[120]= true,
[121]= true,
[122]= true,
[123]= true,
[124]= true,
[125]= true,
[126]= true,
[127]= true,
[128]= true,
[129]= true,
[130]= true,
[131]= true,
[132]= true,
[133]= true,
[134]= true,
[135]= true,
[136]= true,
[137]= true,
[138]= true,
[139]= true,
[140]= true,
[141]= true,
[142]= true,
[143]= true,
[144]= true,
[145]= true,
[146]= true,
[147]= true,
[148]= true,
[150]= true,
[151]= true,
[152]= true,
[153]= true,
[154]= true,
[155]= true,
[156]= true,
[157]= true,
[158]= true,
[159]= true,
[160]= true,
[161]= true,
[162]= true,
[163]= true,
[164]= true,
[165]= true,
[166]= true,
[167]= true,
[168]= true,
[169]= true,
[170]= true,
[171]= true,
[172]= true,
[173]= true,
[174]= true,
[175]= true,
[176]= true,
[177]= true,
[178]= true,
[179]= true,
[180]= true,
[181]= true,
[182]= true,
[183]= true,
[184]= true,
[185]= true,
[186]= true,
[187]= true,
[188]= true,
[189]= true,
[190]= true,
[191]= true,
[192]= true,
[193]= true,
[194]= true,
[195]= true,
[196]= true,
[197]= true,
[198]= true,
[199]= true,
[200]= true,
[201]= true,
[202]= true,
[203]= true,
[204]= true,
[205]= true,
[206]= true,
[207]= true,
[209]= true,
[210]= true,
[211]= true,
[212]= true,
[213]= true,
[214]= true,
[215]= true,
[216]= true,
[217]= true,
[218]= true,
[219]= true,
[220]= true,
[221]= true,
[222]= true,
[223]= true,
[224]= true,
[225]= true,
[226]= true,
[227]= true,
[228]= true,
[229]= true,
[230]= true,
[231]= true,
[232]= true,
[233]= true,
[234]= true,
[235]= true,
[236]= true,
[237]= true,
[238]= true,
[239]= true,
[240]= true,
[241]= true,
[242]= true,
[243]= true,
[244]= true,
[245]= true,
[246]= true,
[247]= true,
[248]= true,
[249]= true,
[250]= true,
[251]= true,
[252]= true,
[253]= true,
[254]= true,
[255]= true,
[256]= true,
[257]= true,
[258]= true,
[259]= true,
[260]= true,
[261]= true,
[262]= true,
[263]= true,
[264]= true,
[274]= true,
[275]= true,
[276]= true,
[277]= true,
[278]= true,
[279]= true,
[280]= true,
[281]= true,
[282]= true,
[283]= true,
[284]= true,
[285]= true,
[286]= true,
[287]= true,
[288]= true
}

local id
local targetST = getPlayerName(localPlayer)
local userpanelShow = "false"
local aesx,aesy = 1920,1080

function userpanelGo()
  if userpanelShow == "false" then
    userpanelOn()
    userpanelShow = "true"
    showCursor(true)
  else
    destroyElement(gridlist)
    destroyElement(statsgrid)
    destroyElement(skinpic)
    destroyElement(buy)
    userpanelShow = "false"
    showCursor(false)
  end
end
local lpName = getPlayerName(localPlayer)

function userpanelOn()
  targetST = getPlayerName(localPlayer)
  id = getElementModel(localPlayer)
  gridlist = guiCreateGridList(1049/aesx*sx, 396/aesy*sy, 136/aesx*sx, 328/aesy*sy, false)
  theSkinsCol = guiGridListAddColumn(gridlist, "Skins", 0.9)
	guiGridListSetSortingEnabled(gridlist,true)
	 if (theSkinsCol) then
			for i,v in pairs(theSkins) do
				rowSkin = guiGridListAddRow(gridlist)
				guiGridListSetItemText(gridlist,rowSkin,theSkinsCol,tostring(i),false,false)
			end
		end

		buy = guiCreateButton(1241/aesx*sx, 565/aesy*sy, 110/aesx*sx, 32/aesy*sy, "50 Coins", false)
    guiSetProperty(buy, "NormalTextColour", "FFAAAAAA")

    skinpic = guiCreateStaticImage(1241/aesx*sx, 388/aesy*sy, 108/aesx*sx, 177/aesy*sy, "res/images/skins/Skinid"..id..".png", false)

        addEventHandler("onClientGUIClick",gridlist,
			      function()
			           id = guiGridListGetItemText(gridlist,guiGridListGetSelectedItem(gridlist),1)
			            destroyElement(skinpic)
			            skinpic = guiCreateStaticImage(1241/aesx*sx, 388/aesy*sy, 108/aesx*sx, 177/aesy*sy, "res/images/skins/Skinid"..id..".png", false)
			      end,false)

        addEventHandler("onClientGUIClick",buy,
				    function()
				          triggerServerEvent("onSkinChangeBuy",localPlayer,id)
				    end,false)
       statsgrid = guiCreateGridList(909/aesx*sx, 393/aesy*sy, 124/aesx*sx, 333/aesy*sy, false)
      playerscol = guiGridListAddColumn(statsgrid, "Player", 0.9)
		  guiGridListSetSortingEnabled(statsgrid,true)
			   if (playerscol) then
				       for i,player in ipairs(getElementsByType("player")) do
					        row = guiGridListAddRow(statsgrid)
					        guiGridListSetItemText(statsgrid,row,playerscol,getPlayerName(player),false,false)
				      end
			  end

        addEventHandler("onClientGUIClick",statsgrid,
			     function()
			          targetST = guiGridListGetItemText(statsgrid,guiGridListGetSelectedItem(statsgrid),1)
			    end)
	end


addEventHandler("onClientRender", getRootElement(),
    function()
		if userpanelShow == "true" then
		local kills = getElementData(getPlayerFromName(targetST),"kills")
local tode = getElementData(getPlayerFromName(targetST),"tode")
local coins = getElementData(getPlayerFromName(targetST),"coins")
local skin = getElementModel(getPlayerFromName(targetST))
local level = getElementData(getPlayerFromName(targetST),"level")
        dxDrawRectangle(747/aesx*sx, 389/aesy*sy, 494/aesx*sx, 347/aesy*sy, tocolor(1, 0, 0, 203), false)
        dxDrawLine(1038/aesx*sx, 388/aesy*sy, 1038/aesx*sx, 734/aesy*sy, tocolor(255, 255, 255, 255), 1, true)
        dxDrawText("Stats", 768/aesx*sx, 395/aesy*sy, 872/aesx*sx, 426/aesy*sy, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "left", "top", false, false, false, false, false)
        dxDrawText("Kills: "..kills, 758/aesx*sx, 445/aesy*sy, 828/aesx*sx, 465/aesy*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawText("Death: "..tode, 758/aesx*sx, 475/aesy*sy, 828/aesx*sx, 495/aesy*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawText("Skin: "..skin, 758/aesx*sx, 505/aesy*sy, 828/aesx*sx, 525/aesy*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, true, false, false)
        dxDrawText("Coins: "..coins, 758/aesx*sx, 535/aesy*sy, 828/aesx*sx, 555/aesy*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawText("Level: "..level, 758/aesx*sx, 565/aesy*sy, 828/aesx*sx, 585/aesy*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    end
end
)

addEvent("jetztbindediescheisse",true)
addEventHandler("jetztbindediescheisse",getRootElement(),
function()
bindKey("u","down",userpanelGo)
end)
