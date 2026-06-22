---HTTP API documentation
---Functions for performing HTTP and HTTPS requests.
---@class http
http = {}
---Perform a HTTP/HTTPS request.
--- If no timeout value is passed, the configuration value "network.http_timeout" is used. If that is not set, the timeout value is 0 (which blocks indefinitely).
---@param url string target url
---@param method string HTTP/HTTPS method, e.g. "GET", "PUT", "POST" etc.
---@param callback fun(self, id, response) response callback function
---@param headers table|nil optional table with custom headers
---@param post_data string|nil optional data to send
---@param options table|nil optional table with request parameters. Supported entries:
function http.request(url, method, callback, headers, post_data, options) end


return http