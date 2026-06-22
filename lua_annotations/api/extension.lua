---SDK Extension API documentation
---Functions for creating and controlling engine native extension libraries.
---@class dmExtension
dmExtension = {}
---Finalizes an extension app params struct (deallocates internal memory)
---@param app_params ExtensionAppParams* the params
function AppParamsFinalize(app_params) end

---get the app exit code
---@param app_params dmExtension::AppParams* The app params sent to the extension dmExtension::AppInitialize / dmExtension::AppInitialize
---@return ExtensionAppExitCode engine exit code
function AppParamsGetAppExitCode(app_params) end

---Gets a context using a specified name hash
---@param params ExtensionAppParams the params
---@param name_hash dmhash_t the context name hash
---@return void* The context, if it exists
function AppParamsGetContext(params, name_hash) end

---Gets a context using a specified name
---@param params ExtensionAppParams the params
---@param name const char* the context name
---@return void* The context, if it exists
function AppParamsGetContextByName(params, name) end

---Initializes an extension app params struct
---NOTE: this is an opaque struct, do not use it's members directly!
---@param app_params ExtensionAppParams* the params
function AppParamsInitialize(app_params) end

---Sets a context using a specified name
---@param params ExtensionAppParams the params
---@param name const char* the context name
---@param context void* the context
---@return int 0 if successful
function AppParamsSetContext(params, name, context) end

---Finalizes an extension app params struct (deallocates internal memory)
---@param app_params ExtensionAppParams* the params
function ExtensionAppParamsFinalize(app_params) end

---get the app exit code
---@param app_params dmExtension::AppParams* The app params sent to the extension dmExtension::AppInitialize / dmExtension::AppInitialize
---@return ExtensionAppExitCode engine exit code
function ExtensionAppParamsGetAppExitCode(app_params) end

---Gets a context using a specified name hash
---@param params ExtensionAppParams the params
---@param name_hash dmhash_t the context name hash
---@return void* The context, if it exists
function ExtensionAppParamsGetContext(params, name_hash) end

---Gets a context using a specified name
---@param params ExtensionAppParams the params
---@param name const char* the context name
---@return void* The context, if it exists
function ExtensionAppParamsGetContextByName(params, name) end

---Initializes an extension app params struct
---NOTE: this is an opaque struct, do not use it's members directly!
---@param app_params ExtensionAppParams* the params
function ExtensionAppParamsInitialize(app_params) end

---Sets a context using a specified name
---@param params ExtensionAppParams the params
---@param name const char* the context name
---@param context void* the context
---@return int 0 if successful
function ExtensionAppParamsSetContext(params, name, context) end

---Used when registering new extensions
function ExtensionDescBufferSize() end

---Finalizes an extension  params struct (deallocates internal memory)
---@param app_params ExtensionParams* the params
function ExtensionParamsFinalize(app_params) end

---Gets a context using a specified name hash
---@param params ExtensionParams the params
---@param name_hash dmhash_t the context name hash
---@return void* The context, if it exists
function ExtensionParamsGetContext(params, name_hash) end

---Gets a context using a specified name
---@param params ExtensionParams the params
---@param name const char* the context name
---@return void* The context, if it exists
function ExtensionParamsGetContextByName(params, name) end

---Initializes an extension params struct
---NOTE: this is an opaque struct, do not use it's members directly!
---@param app_params ExtensionParams* the params
function ExtensionParamsInitialize(app_params) end

---Sets a context using a specified name
---@param params ExtensionAppParams the params
---@param name const char* the context name
---@param context void* the context
---@return int 0 if successful
function ExtensionParamsSetContext(params, name, context) end

---Extension declaration helper. Internal function. Use DM_DECLARE_EXTENSION
---@param desc void* A persistent buffer of at least 128 bytes.
---@param desc_size const char* size of buffer holding desc. in bytes
---@param name const char* extension name. human readble. max 16 characters long.
---@param app_initialize FExtensionAppInitialize app-init function. May be null
---@param app_finalize FExtensionAppFinalize app-final function. May be null
---@param initialize FExtensionInitialize init function. May not be 0
---@param finalize FExtensionFinalize finalize function. May not be 0
---@param update FExtensionUpdate update function. May be null
---@param on_event FExtensionOnEvent event callback function. May be null
function ExtensionRegister(desc, desc_size, name, app_initialize, app_finalize, initialize, finalize, update, on_event) end

---Register an iOS application delegate to the engine. Multiple delegates are supported (Max 32)
---@param delegate void* An id, see: https://developer.apple.com/documentation/uikit/uiapplicationdelegate?language=objc
function ExtensionRegisteriOSUIApplicationDelegate(delegate) end

---Deregister a previously registered iOS application delegate
---This function is only available on iOS.
---@param delegate void* an id
function ExtensionUnregisteriOSUIApplicationDelegate(delegate) end

---Finalizes an extension  params struct (deallocates internal memory)
---@param app_params ExtensionParams* the params
function ParamsFinalize(app_params) end

---Gets a context using a specified name hash
---@param params ExtensionParams the params
---@param name_hash dmhash_t the context name hash
---@return void* The context, if it exists
function ParamsGetContext(params, name_hash) end

---Gets a context using a specified name
---@param params ExtensionParams the params
---@param name const char* the context name
---@return void* The context, if it exists
function ParamsGetContextByName(params, name) end

---Initializes an extension params struct
---NOTE: this is an opaque struct, do not use it's members directly!
---@param app_params ExtensionParams* the params
function ParamsInitialize(app_params) end

---Sets a context using a specified name
---@param params ExtensionAppParams the params
---@param name const char* the context name
---@param context void* the context
---@return int 0 if successful
function ParamsSetContext(params, name, context) end

---Register an iOS application delegate to the engine. Multiple delegates are supported (Max 32)
---@param delegate void* An id, see: https://developer.apple.com/documentation/uikit/uiapplicationdelegate?language=objc
function RegisteriOSUIApplicationDelegate(delegate) end

---Deregister a previously registered iOS application delegate
---This function is only available on iOS.
---@param delegate void* an id
function UnregisteriOSUIApplicationDelegate(delegate) end


return dmExtension