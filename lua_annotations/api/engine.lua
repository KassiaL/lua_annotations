---SDK Engine extension API documentation
---SDK Engine extension API documentation
---@class dmEngine
dmEngine = {}
---get the config file
---@param app_params dmExtension::AppParams* The app params sent to the extension dmExtension::AppInitialize / dmExtension::AppInitialize
---@return dmConfigFile::HConfig The game project config file
function GetConfigFile(app_params) end

---get the game object register
---@param app_params dmExtension::AppParams* The app params sent to the extension dmExtension::AppInitialize / dmExtension::AppInitialize
---@return dmGameObject::HRegister The game object register
function GetGameObjectRegister(app_params) end

---get the hid context
---@param app_params dmExtension::AppParams* The app params sent to the extension dmExtension::AppInitialize / dmExtension::AppInitialize
---@return dmHID::HContext The hid context
function GetHIDContext(app_params) end

---get the web server handle
---@param app_params dmExtension::AppParams* The app params sent to the extension dmExtension::AppInitialize / dmExtension::AppInitialize
---@return dmWebServer::HServer The web server handle
function GetWebServer(app_params) end


return dmEngine