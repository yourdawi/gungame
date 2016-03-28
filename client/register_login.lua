

local sx,sy = guiGetScreenSize()
local sxx,syy = 1280,720

local loginButton
local loginEditbox

function showLogin()
  startBrowser()
  showCursor(true)
  addEventHandler("onClientRender",getRootElement(),renderloginWindow)
  loginButton = guiCreateButton(0.45, 0.58, 0.09, 0.05, "Login", true)
   loginEditbox = guiCreateEdit(0.43, 0.48, 0.14, 0.04, "asdgsg", true)
guiEditSetMasked(loginEditbox, true)

  addEventHandler ( "onClientGUIClick", loginButton,
  function()
    if guiGetText(loginEditbox) ~= "" then
      triggerServerEvent("loginPlayer",localPlayer,guiGetText(loginEditbox))
    end
  end, false )
end

function renderloginWindow()
dxDrawRectangle(420/sxx*sx, 222/syy*sy, 448/sxx*sx, 276/syy*sy, tocolor(18, 15, 15, 183), true)
dxDrawText("Welcome, "..getPlayerName(localPlayer).."! \nThere is an account with your name,\n if its not yours please change your name!", 436/sxx*sx, 236/syy*sy, 842/sxx*sx, 296/syy*sy, tocolor(255, 255, 255, 255), 1/sxx*sx, "default-bold", "left", "top", false, false, true, false, false)
dxDrawText("Please enter your password!", 548/sxx*sx, 296/syy*sy, 771/sxx*sx, 338/syy*sy, tocolor(221, 0, 0, 255), 1/sxx*sx, "default-bold", "left", "top", false, false, true, false, false)
end

function cancelLoginWindow()
  removeEventHandler("onClientRender",getRootElement(),renderloginWindow)
  destroyElement(loginButton)
  destroyElement(loginEditbox)
  showCursor(false)
  stopBrowser()
end

addEvent("showPlayerLogin",true)
addEventHandler("showPlayerLogin",getRootElement(),showLogin)
addEvent("closePlayerLogin",true)
addEventHandler("closePlayerLogin",getRootElement(),cancelLoginWindow)

---------------------------------------------------------------------------------------------------------


local registerButton
local registerEditbox
local registerEditbox

function showRegister()
  startBrowser()
  showCursor(true)
  addEventHandler("onClientRender",getRootElement(),renderregisterWindow)

  registerButton = guiCreateButton(0.54, 0.70, 0.10, 0.06, "Register", true)


registerEditbox = guiCreateEdit(0.34, 0.56, 0.13, 0.05, "adasd", true)
guiEditSetMasked(registerEditbox, true)


registerEditboxagain = guiCreateEdit(0.34, 0.67, 0.13, 0.05, "dsdas", true)
        guiEditSetMasked(registerEditboxagain, true)

        addEventHandler ( "onClientGUIClick", registerButton,
        function()
          if guiGetText(registerEditbox) ~= "" then
            if guiGetText(registerEditbox) == guiGetText(registerEditbox) then
            triggerServerEvent("registerPlayer",localPlayer,guiGetText(registerEditbox),guiGetText(registerEditboxagain))
            else
              outputChatBox("Password doesn´t match!",255,0,0)
            end
          end
        end, false )
end

function renderregisterWindow()
dxDrawRectangle(417/sxx*sx, 161/syy*sy, 430/sxx*sx, 401/syy*sy, tocolor(0, 0, 0, 180), true)
dxDrawText("Welcome!\nThere is no account with this name.\nPlease fill out the form.\n\nWe hope you will enjoy this server.\n(c)yourdawi.de", 444/sxx*sx, 184/syy*sy, 820/sxx*sx, 292/syy*sy, tocolor(255, 255, 255, 255), 1/sxx*sx, "default-bold", "left", "top", false, false, true, false, false)
dxDrawText(getPlayerName(localPlayer), 538/sxx*sx, 331/syy*sy, 721/sxx*sx, 370/syy*sy, tocolor(255, 255, 255, 255), 1/sxx*sx, "default-bold", "left", "top", false, false, true, false, false)
dxDrawText("Password", 438/sxx*sx, 380/syy*sy, 576/sxx*sx, 413/syy*sy, tocolor(255, 255, 255, 255), 1/sxx*sx, "default-bold", "left", "top", false, false, true, false, false)
dxDrawText("Password again", 438/sxx*sx, 460/syy*sy, 576/sxx*sx, 493/syy*sy, tocolor(255, 255, 255, 255), 1/sxx*sx, "default-bold", "left", "top", false, false, true, false, false)
end

function cancelRegisterWindow()
  removeEventHandler("onClientRender",getRootElement(),renderregisterWindow)
  destroyElement(registerEditbox)
  destroyElement(registerEditboxagain)
  destroyElement(registerButton)
  showCursor(false)
  stopBrowser()
end

addEvent("showPlayerRegister",true)
addEventHandler("showPlayerRegister",getRootElement(),showRegister)
addEvent("closePlayerRegister",true)
addEventHandler("closePlayerRegister",getRootElement(),cancelRegisterWindow)

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),
function()
  triggerServerEvent("onPlayerReady",localPlayer)
end)


---------------------------
--BROWSER
--------------------------
local webBrowser
function startBrowser()
webBrowser = createBrowser(sx, sy, false, false)
addEventHandler("onClientBrowserCreated",webBrowser,
function()
loadBrowserURL(webBrowser,"http://youtube.com/embed/BnmzpbT1wJc?autoplay=1&start=1&controls=0&showinfo=0&loop=1&rel=0&iv_load_policy=3")
end)
addEventHandler("onClientRender",getRootElement(),webBrowserRender)
end

function webBrowserRender()
	dxDrawImage(0, 0, sx, sy, webBrowser, 0, 0, 0, tocolor(255,255,255,255), false)
end

function stopBrowser()
setTimer(function()
  destroyElement(webBrowser)
  removeEventHandler("onClientRender",getRootElement(),webBrowserRender)
  end,5000,1)
end
