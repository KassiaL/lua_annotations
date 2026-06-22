---Collection proxy API documentation
---Messages for controlling and interacting with collection proxies
---which are used to dynamically load collections into the runtime.
---@class collectionproxy
collectionproxy = {}
---collection proxy is already loaded
---It's impossible to change the collection if the collection is already loaded.
collectionproxy.RESULT_ALREADY_LOADED = nil

---collection proxy is loading now
---It's impossible to change the collection while the collection proxy is loading.
collectionproxy.RESULT_LOADING = nil

---collection proxy isn't excluded
---It's impossible to change the collection for a proxy that isn't excluded.
collectionproxy.RESULT_NOT_EXCLUDED = nil

---return an indexed table of resources for a collection proxy where the
---referenced collection has been excluded using LiveUpdate. Each entry is a
---hexadecimal string that represents the data of the specific resource.
---This representation corresponds with the filename for each individual
---resource that is exported when you bundle an application with LiveUpdate
---functionality.
---@param collectionproxy url the collectionproxy to check for resources.
---@return table the resources, or an empty list if the collection was not excluded.
function collectionproxy.get_resources(collectionproxy) end

---The collection should be loaded by the collection proxy.
---Setting the collection to "nil" will revert it back to the original collection.
---The collection proxy shouldn't be loaded and should have the 'Exclude' checkbox checked.
---This functionality is designed to simplify the management of Live Update resources.
---@param url string|hash|url|nil the collection proxy component
---@param prototype string|nil the path to the new collection, or nil
---@return boolean collection change was successful
---@return number one of the collectionproxy.RESULT_* codes if unsuccessful
function collectionproxy.set_collection(url, prototype) end


return collectionproxy