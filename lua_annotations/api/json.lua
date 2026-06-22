---JSON API documentation
---Manipulation of JSON data strings.
---@class json
json = {}
---Decode a string of JSON data into a Lua table.
---A Lua error is raised for syntax errors.
---@param json string json data
---@param options table|nil table with decode options
---@return table decoded json
function json.decode(json, options) end

---Encode a lua table to a JSON string.
---A Lua error is raised for syntax errors.
---@param tbl table lua table to encode
---@param options table|nil table with encode options
---@return string encoded json
function json.encode(tbl, options) end

---null
---Represents the null primitive from a json file
json.null = nil


return json