---SDK ConfigFile API documentation
---Configuration file access functions.
---The configuration file is compiled version of the [file:game.project] file.
---@class dmConfigFile
dmConfigFile = {}
---It defines the minimum size of the description blob being registered.
function ConfigFileExtensionDescBufferSize() end

---Get config value as float, returns default if the key isn't found
---@param config HConfigFile Config file handle
---@param key const char* Key in format section.key (.key for no section)
---@param default_value int32_t Default value to return if key isn't found
---@return int32_t found value or default value
function ConfigFileGetFloat(config, key, default_value) end

---Get config value as integer, returns default if the key isn't found
---@param config HConfigFile Config file handle
---@param key const char* Key in format section.key (.key for no section)
---@param default_value int32_t Default value to return if key isn't found
---@return int32_t found value or default value
function ConfigFileGetInt(config, key, default_value) end

---Get config value as string, returns default if the key isn't found
---@param config HConfigFile Config file handle
---@param key const char* Key in format section.key (.key for no section)
---@param default_value const char* Default value to return if key isn't found
---@return const char* found value or default value
function ConfigFileGetString(config, key, default_value) end

---Get config value as float, returns default if the key isn't found
---@param config HConfigFile Config file handle
---@param key const char* Key in format section.key (.key for no section)
---@param default_value int32_t Default value to return if key isn't found
---@return int32_t found value or default value
function GetFloat(config, key, default_value) end

---Get config value as integer, returns default if the key isn't found
---@param config HConfigFile Config file handle
---@param key const char* Key in format section.key (.key for no section)
---@param default_value int32_t Default value to return if key isn't found
---@return int32_t found value or default value
function GetInt(config, key, default_value) end

---Get config value as string, returns default if the key isn't found
---@param config HConfigFile Config file handle
---@param key const char* Key in format section.key (.key for no section)
---@param default_value const char* Default value to return if key isn't found
---@return const char* found value or default value
function GetString(config, key, default_value) end


return dmConfigFile