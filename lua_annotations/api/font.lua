---Font API documentation
---Functions, messages and properties used to manipulate font resources.
---@class font
font = {}
---associates a ttf resource to a .fontc file.
---@param fontc string|hash The path to the .fontc resource
---@param ttf string|hash The path to the .ttf resource
function font.add_font(fontc, ttf) end

---Gets information about a font, such as the associated font files
---@param fontc string|hash The path to the .fontc resource
---@return table the information table contains these fields:
function font.get_info(fontc) end

---prepopulates the font glyph cache with rasterised glyphs
---@param fontc string|hash The path to the .fontc resource
---@param text string The text to layout
---@param callback fun(self, request_id, result, errstring)|nil (optional) A callback function that is called after the request is finished
---@return number Returns the asynchronous request id
function font.prewarm_text(fontc, text, callback) end

---associates a ttf resource to a .fontc file
---@param fontc string|hash The path to the .fontc resource
---@param ttf string|hash The path to the .ttf resource
function font.remove_font(fontc, ttf) end


return font