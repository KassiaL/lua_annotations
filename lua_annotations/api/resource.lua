---Resource API documentation
---Functions and constants to access resources.
---@class resource
resource = {}
---Constructor-like function with two purposes:
---
---
--- * Load the specified resource as part of loading the script
---
--- * Return a hash to the run-time version of the resource
---
--- This function can only be called within go.property function calls.
---@param path string|nil optional resource path string to the resource
---@return hash a path hash to the binary version of the resource
function resource.atlas(path) end

---Constructor-like function with two purposes:
---
---
--- * Load the specified resource as part of loading the script
---
--- * Return a hash to the run-time version of the resource
---
--- This function can only be called within go.property function calls.
---@param path string|nil optional resource path string to the resource
---@return hash a path hash to the binary version of the resource
function resource.buffer(path) end

---This function creates a new atlas resource that can be used in the same way as any atlas created during build time.
---The path used for creating the atlas must be unique, trying to create a resource at a path that is already
---registered will trigger an error. If the intention is to instead modify an existing atlas, use the resource.set_atlas
---function. Also note that the path to the new atlas resource must have a '.texturesetc' extension,
---meaning "/path/my_atlas" is not a valid path but "/path/my_atlas.texturesetc" is.
---When creating the atlas, at least one geometry and one animation is required, and an error will be
---raised if these requirements are not met. A reference to the resource will be held by the collection
---that created the resource and will automatically be released when that collection is destroyed.
---Note that releasing a resource essentially means decreasing the reference count of that resource,
---and not necessarily that it will be deleted.
---@param path string The path to the resource.
---@param table table A table containing info about how to create the atlas. Supported entries:
---@return hash Returns the atlas resource path
function resource.create_atlas(path, table) end

---This function creates a new buffer resource that can be used in the same way as any buffer created during build time.
---The function requires a valid buffer created from either buffer.create or another pre-existing buffer resource.
---By default, the new resource will take ownership of the buffer lua reference, meaning the buffer will not automatically be removed
---when the lua reference to the buffer is garbage collected. This behaviour can be overruled by specifying 'transfer_ownership = false'
---in the argument table. If the new buffer resource is created from a buffer object that is created by another resource,
---the buffer object will be copied and the new resource will effectively own a copy of the buffer instead.
---Note that the path to the new resource must have the '.bufferc' extension, "/path/my_buffer" is not a valid path but "/path/my_buffer.bufferc" is.
---The path must also be unique, attempting to create a buffer with the same name as an existing resource will raise an error.
---@param path string The path to the resource.
---@param table table|nil A table containing info about how to create the buffer. Supported entries:
---@return hash Returns the buffer resource path
function resource.create_buffer(path, table) end

---Creates a sound data resource
---Supported formats are .oggc, .opusc and .wavc
---@param path string the path to the resource. Must not already exist.
---@param options table|nil A table containing parameters for the text. Supported entries:
---@return hash the resulting path hash to the resource
function resource.create_sound_data(path, options) end

---Creates a new texture resource that can be used in the same way as any texture created during build time.
---The path used for creating the texture must be unique, trying to create a resource at a path that is already
---registered will trigger an error. If the intention is to instead modify an existing texture, use the resource.set_texture
---function. Also note that the path to the new texture resource must have a '.texturec' extension,
---meaning "/path/my_texture" is not a valid path but "/path/my_texture.texturec" is.
---If the texture is created without a buffer, the pixel data will be blank.
---@param path string The path to the resource.
---@param table table A table containing info about how to create the texture. Supported entries:
---@param buffer buffer optional buffer of precreated pixel data
---@return hash The path to the resource.  3D Textures are currently only supported on OpenGL and Vulkan adapters. To check if your device supports 3D textures, use: ```lua if graphics.TEXTURE_TYPE_3D ~= nil then     -- Device and graphics adapter support 3D textures end
function resource.create_texture(path, table, buffer) end

---Creates a new texture resource that can be used in the same way as any texture created during build time.
---The path used for creating the texture must be unique, trying to create a resource at a path that is already
---registered will trigger an error. If the intention is to instead modify an existing texture, use the resource.set_texture
---function. Also note that the path to the new texture resource must have a '.texturec' extension,
---meaning "/path/my_texture" is not a valid path but "/path/my_texture.texturec" is.
---If the texture is created without a buffer, the pixel data will be blank.
---The difference between the async version and resource.create_texture is that the texture data will be uploaded
---in a graphics worker thread. The function will return a resource immediately that contains a 1x1 blank texture which can be used
---immediately after the function call. When the new texture has been uploaded, the initial blank texture will be deleted and replaced with the
---new texture. Be careful when using the initial texture handle handle as it will not be valid after the upload has finished.
---@param path string|hash The path to the resource.
---@param table table
---@param buffer buffer optional buffer of precreated pixel data
---@param callback fun callback function when texture is created (self, request_id, resource)
---@return hash The path to the texture resource.
---@return number The request id for the async request.  3D Textures are currently only supported on OpenGL and Vulkan adapters. To check if your device supports 3D textures, use: ```lua if graphics.TEXTURE_TYPE_3D ~= nil then     -- Device and graphics adapter support 3D textures end
function resource.create_texture_async(path, table, buffer, callback) end

---Constructor-like function with two purposes:
---
---
--- * Load the specified resource as part of loading the script
---
--- * Return a hash to the run-time version of the resource
---
--- This function can only be called within go.property function calls.
---@param path string|nil optional resource path string to the resource
---@return hash a path hash to the binary version of the resource
function resource.font(path) end

---Returns the atlas data for an atlas
---@param path hash|string The path to the atlas resource
---@return table A table with the following entries:
function resource.get_atlas(path) end

---gets the buffer from a resource
---@param path hash|string The path to the resource
---@return buffer The resource buffer
function resource.get_buffer(path) end

---Gets render target info from a render target resource path or a render target handle
---@param path hash|string|number The path to the resource or a render target handle
---@return table A table containing info about the render target:
function resource.get_render_target_info(path) end

---Gets the text metrics from a font
---@param url hash the font to get the (unscaled) metrics from
---@param text string text to measure
---@param options table|nil A table containing parameters for the text. Supported entries:
---@return table a table with the following fields:
function resource.get_text_metrics(url, text, options) end

---Gets texture info from a texture resource path or a texture handle
---@param path hash|string|number The path to the resource or a texture handle
---@return table A table containing info about the texture:
function resource.get_texture_info(path) end

---Loads the resource data for a specific resource.
---@param path string The path to the resource
---@return buffer Returns the buffer stored on disc
function resource.load(path) end

---Constructor-like function with two purposes:
---
---
--- * Load the specified resource as part of loading the script
---
--- * Return a hash to the run-time version of the resource
---
--- This function can only be called within go.property function calls.
---@param path string|nil optional resource path string to the resource
---@return hash a path hash to the binary version of the resource
function resource.material(path) end

---Release a resource.
--- This is a potentially dangerous operation, releasing resources currently being used can cause unexpected behaviour.
---@param path hash|string The path to the resource.
function resource.release(path) end

---Constructor-like function with two purposes:
---
---
--- * Load the specified resource as part of loading the script
---
--- * Return a hash to the run-time version of the resource
---
--- This function can only be called within go.property function calls.
---@param path string|nil optional resource path string to the resource
---@return hash a path hash to the binary version of the resource
function resource.render_target(path) end

---Sets the resource data for a specific resource
---@param path string|hash The path to the resource
---@param buffer buffer The buffer of precreated data, suitable for the intended resource type
function resource.set(path, buffer) end

---Sets the data for a specific atlas resource. Setting new atlas data is specified by passing in
---a texture path for the backing texture of the atlas, a list of geometries and a list of animations
---that map to the entries in the geometry list. The geometry entries are represented by three lists:
---vertices, uvs and indices that together represent triangles that are used in other parts of the
---engine to produce render objects from.
---Vertex and uv coordinates for the geometries are expected to be
---in pixel coordinates where 0,0 is the top left corner of the texture.
---There is no automatic padding or margin support when setting custom data,
---which could potentially cause filtering artifacts if used with a material sampler that has linear filtering.
---If that is an issue, you need to calculate padding and margins manually before passing in the geometry data to
---this function.
---@param path hash|string The path to the atlas resource
---@param table table A table containing info about the atlas. Supported entries:
function resource.set_atlas(path, table) end

---Sets the buffer of a resource. By default, setting the resource buffer will either copy the data from the incoming buffer object
---to the buffer stored in the destination resource, or make a new buffer object if the sizes between the source buffer and the destination buffer
---stored in the resource differs. In some cases, e.g performance reasons, it might be beneficial to just set the buffer object on the resource without copying or cloning.
---To achieve this, set the transfer_ownership flag to true in the argument table. Transferring ownership from a lua buffer to a resource with this function
---works exactly the same as resource.create_buffer: the destination resource will take ownership of the buffer held by the lua reference, i.e the buffer will not automatically be removed
---when the lua reference to the buffer is garbage collected.
---Note: When setting a buffer with transfer_ownership = true, the currently bound buffer in the resource will be destroyed.
---@param path hash|string The path to the resource
---@param buffer buffer The resource buffer
---@param table table|nil A table containing info about how to set the buffer. Supported entries:
function resource.set_buffer(path, buffer, table) end

---Update internal sound resource (wavc/oggc/opusc) with new data
---@param path hash|string The path to the resource
---@param buffer string A lua string containing the binary sound data
function resource.set_sound(path, buffer) end

---Sets the pixel data for a specific texture.
---@param path hash|string The path to the resource
---@param table table A table containing info about the texture. Supported entries:
---@param buffer buffer The buffer of precreated pixel data  To update a cube map texture you need to pass in six times the amount of data via the buffer, since a cube map has six sides!  3D Textures are currently only supported on OpenGL and Vulkan adapters. To check if your device supports 3D textures, use: ```lua if graphics.TEXTURE_TYPE_3D ~= nil then     -- Device and graphics adapter support 3D textures end
function resource.set_texture(path, table, buffer) end

---Constructor-like function with two purposes:
---
---
--- * Load the specified resource as part of loading the script
---
--- * Return a hash to the run-time version of the resource
---
--- This function can only be called within go.property function calls.
---@param path string|nil optional resource path string to the resource
---@return hash a path hash to the binary version of the resource
function resource.texture(path) end

---Constructor-like function with two purposes:
---
---
--- * Load the specified resource as part of loading the script
---
--- * Return a hash to the run-time version of the resource
---
--- This function can only be called within go.property function calls.
---@param path string|nil optional resource path string to the resource
---@return hash a path hash to the binary version of the resource
function resource.tile_source(path) end


return resource