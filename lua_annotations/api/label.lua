---Label API documentation
---Functions to manipulate a label component.
---@class label
label = {}
---vector4 label color
---The color of the label. The type of the property is vector4.
color = nil

---hash label font
---The font used when rendering the label. The type of the property is hash.
font = nil

---Gets the text from a label component
---@param url string|hash|url the label to get the text from
---@return string the label text
function label.get_text(url) end

---Sets the text of a label component
--- This method uses the message passing that means the value will be set after dispatch messages step.
---More information is available in the Application Lifecycle manual.
---@param url string|hash|url the label that should have a constant set
---@param text string|number the text
function label.set_text(url, text) end

---number label leading
---The leading of the label. This value is used to scale the line spacing of text.
---The type of the property is number.
leading = nil

---boolean label line break
---The line break of the label.
---This value is used to adjust the vertical spacing of characters in the text.
---The type of the property is boolean.
line_break = nil

---hash label material
---The material used when rendering the label. The type of the property is hash.
material = nil

---vector4 label outline
---The outline color of the label. The type of the property is vector4.
outline = nil

---number | vector3 label scale
---The scale of the label. The type of the property is number (uniform)
---or vector3 (non uniform).
scale = nil

---vector4 label shadow
---The shadow color of the label. The type of the property is vector4.
shadow = nil

---vector3 label size
---Returns the size of the label. The size will constrain the text if line break is enabled.
---The type of the property is vector3.
size = nil

---number label tracking
---The tracking of the label.
---This value is used to adjust the vertical spacing of characters in the text.
---The type of the property is number.
tracking = nil


return label