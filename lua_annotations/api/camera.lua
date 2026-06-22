---Camera API documentation
---Camera functions, messages and constants.
---@class camera
camera = {}
---auto-cover orthographic zoom mode
---Computes zoom so the original display area covers the entire window while preserving aspect ratio.
---Equivalent to using max(window_width/width, window_height/height).
camera.ORTHO_MODE_AUTO_COVER = nil

---auto-fit orthographic zoom mode
---Computes zoom so the original display area (game.project width/height) fits inside the window
---while preserving aspect ratio. Equivalent to using min(window_width/width, window_height/height).
camera.ORTHO_MODE_AUTO_FIT = nil

---fixed orthographic zoom mode
---Uses the manually set orthographic zoom value (camera.set_orthographic_zoom).
camera.ORTHO_MODE_FIXED = nil

---Gets the effective aspect ratio of the camera. If auto aspect ratio is enabled,
---returns the aspect ratio calculated from the current render target dimensions.
---Otherwise returns the manually set aspect ratio.
---@param camera url|number|nil camera id
---@return number the effective aspect ratio.
function camera.get_aspect_ratio(camera) end

---Returns whether auto aspect ratio is enabled. When enabled, the camera automatically
---calculates aspect ratio from render target dimensions. When disabled, uses the
---manually set aspect ratio value.
---@param camera url|number|nil camera id
---@return boolean true if auto aspect ratio is enabled
function camera.get_auto_aspect_ratio(camera) end

---This function returns a table with all the camera URLs that have been
---registered in the render context.
---@return table a table with all camera URLs
function camera.get_cameras() end

---get enabled
---@param camera url|number|nil camera id
---@return boolean true if the camera is enabled
function camera.get_enabled(camera) end

---get far z
---@param camera url|number|nil camera id
---@return number the far z.
function camera.get_far_z(camera) end

---get field of view
---@param camera url|number|nil camera id
---@return number the field of view.
function camera.get_fov(camera) end

---get near z
---@param camera url|number|nil camera id
---@return number the near z.
function camera.get_near_z(camera) end

---get orthographic zoom mode
---@param camera url|number|nil camera id
---@return number one of camera.ORTHO_MODE_FIXED, camera.ORTHO_MODE_AUTO_FIT or camera.ORTHO_MODE_AUTO_COVER
function camera.get_orthographic_mode(camera) end

---get orthographic zoom
---@param camera url|number|nil camera id
---@return number the zoom level when the camera uses orthographic projection.
function camera.get_orthographic_zoom(camera) end

---get projection matrix
---@param camera url|number|nil camera id
---@return matrix4 the projection matrix.
function camera.get_projection(camera) end

---get view matrix
---@param camera url|number|nil camera id
---@return matrix4 the view matrix.
function camera.get_view(camera) end

---Converts a screen-space 2D point with view depth to a 3D world point.
---z is the view depth in world units measured from the camera plane along the camera forward axis.
---If a camera isn't specified, the last enabled camera is used.
---@param pos vector3 Screen-space position (x, y) with z as view depth in world units
---@param camera url|number|nil optional camera id
---@return vector3 the world coordinate
function camera.screen_to_world(pos, camera) end

---Converts 2D screen coordinates (x,y) to the 3D world-space point on the camera's near plane for that pixel.
---If a camera isn't specified, the last enabled camera is used.
---@param x number X coordinate on screen.
---@param y number Y coordinate on screen.
---@param camera url|number|nil optional camera id
---@return vector3 the world coordinate on the camera near plane
function camera.screen_xy_to_world(x, y, camera) end

---Sets the manual aspect ratio for the camera. This value is only used when
---auto aspect ratio is disabled. To disable auto aspect ratio and use this
---manual value, call camera.set_auto_aspect_ratio(camera, false).
---@param camera url|number|nil camera id
---@param aspect_ratio number the manual aspect ratio value.
function camera.set_aspect_ratio(camera, aspect_ratio) end

---Enables or disables automatic aspect ratio calculation. When enabled (true),
---the camera automatically calculates aspect ratio from render target dimensions.
---When disabled (false), uses the manually set aspect ratio value.
---@param camera url|number|nil camera id
---@param auto_aspect_ratio boolean true to enable auto aspect ratio
function camera.set_auto_aspect_ratio(camera, auto_aspect_ratio) end

---set far z
---@param camera url|number|nil camera id
---@param far_z number the far z.
function camera.set_far_z(camera, far_z) end

---set field of view
---@param camera url|number|nil camera id
---@param fov number the field of view.
function camera.set_fov(camera, fov) end

---set near z
---@param camera url|number|nil camera id
---@param near_z number the near z.
function camera.set_near_z(camera, near_z) end

---set orthographic zoom mode
---@param camera url|number|nil camera id
---@param mode number camera.ORTHO_MODE_FIXED, camera.ORTHO_MODE_AUTO_FIT or camera.ORTHO_MODE_AUTO_COVER
function camera.set_orthographic_mode(camera, mode) end

---set orthographic zoom
---@param camera url|number|nil camera id
---@param orthographic_zoom number the zoom level when the camera uses orthographic projection.
function camera.set_orthographic_zoom(camera, orthographic_zoom) end

---Converts a 3D world position to screen-space coordinates with view depth.
---Returns a vector3 where x and y are in screen pixels and z is the view depth in world units
---measured from the camera plane along the camera forward axis. The returned z can be used with
---camera.screen_to_world to reconstruct the world position on the same pixel ray.
---If a camera isn't specified, the last enabled camera is used.
---@param world_pos vector3 World-space position
---@param camera url|number|nil optional camera id
---@return vector3 Screen position (x,y in pixels, z is view depth)
function camera.world_to_screen(world_pos, camera) end


return camera