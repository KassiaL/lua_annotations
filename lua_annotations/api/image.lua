---Image API documentation
---Functions for creating image objects.
---@class image
image = {}
---luminance image type
image.TYPE_LUMINANCE = nil

---luminance image type
image.TYPE_LUMINANCE_ALPHA = nil

---RGB image type
image.TYPE_RGB = nil

---RGBA image type
image.TYPE_RGBA = nil

---get the header of an .astc buffer
---@param buffer string .astc file data buffer
---@return table|nil header or nil if buffer is not a valid .astc. The header has these fields:
function image.get_astc_header(buffer) end

---Load image (PNG or JPEG) from buffer.
---@param buffer string image data buffer
---@param options table|nil An optional table containing parameters for loading the image. Supported entries:
---@return table|nil object or nil if loading fails. The object is a table with the following fields:
function image.load(buffer, options) end

---Load image (PNG or JPEG) from a string buffer.
---@param buffer string image data buffer
---@param options table|nil An optional table containing parameters for loading the image. Supported entries:
---@return table|nil object or nil if loading fails. The object is a table with the following fields:
function image.load_buffer(buffer, options) end


return image