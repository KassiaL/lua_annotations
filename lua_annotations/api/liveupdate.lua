---LiveUpdate API documentation
---Functions and constants to access resources.
---@class liveupdate
liveupdate = {}
---LIVEUPDATE_BUNDLED_RESOURCE_MISMATCH
---Mismatch between between expected bundled resources and actual bundled resources. The manifest expects a resource to be in the bundle, but it was not found in the bundle. This is typically the case when a non-excluded resource was modified between publishing the bundle and publishing the manifest.
liveupdate.LIVEUPDATE_BUNDLED_RESOURCE_MISMATCH = nil

---LIVEUPDATE_ENGINE_VERSION_MISMATCH
---Mismatch between running engine version and engine versions supported by manifest.
liveupdate.LIVEUPDATE_ENGINE_VERSION_MISMATCH = nil

---LIVEUPDATE_FORMAT_ERROR
---Failed to parse manifest data buffer. The manifest was probably produced by a different engine version.
liveupdate.LIVEUPDATE_FORMAT_ERROR = nil

---LIVEUPDATE_INVAL
---Argument was invalid
liveupdate.LIVEUPDATE_INVAL = nil

---LIVEUPDATE_INVALID_HEADER
---The handled resource is invalid.
liveupdate.LIVEUPDATE_INVALID_HEADER = nil

---LIVEUPDATE_INVALID_RESOURCE
---The header of the resource is invalid.
liveupdate.LIVEUPDATE_INVALID_RESOURCE = nil

---LIVEUPDATE_IO_ERROR
---I/O operation failed
liveupdate.LIVEUPDATE_IO_ERROR = nil

---LIVEUPDATE_MEM_ERROR
---Memory wasn't allocated
liveupdate.LIVEUPDATE_MEM_ERROR = nil

---LIVEUPDATE_OK
liveupdate.LIVEUPDATE_OK = nil

---LIVEUPDATE_SCHEME_MISMATCH
---Mismatch between scheme used to load resources. Resources are loaded with a different scheme than from manifest, for example over HTTP or directly from file. This is typically the case when running the game directly from the editor instead of from a bundle.
liveupdate.LIVEUPDATE_SCHEME_MISMATCH = nil

---LIVEUPDATE_SIGNATURE_MISMATCH
---Mismatch between expected and actual integrity data for legacy liveupdate verification.
liveupdate.LIVEUPDATE_SIGNATURE_MISMATCH = nil

---LIVEUPDATE_UNKNOWN
---Unspecified error
liveupdate.LIVEUPDATE_UNKNOWN = nil

---LIVEUPDATE_VERSION_MISMATCH
---Mismatch between manifest expected version and actual version.
liveupdate.LIVEUPDATE_VERSION_MISMATCH = nil

---Adds a resource mount to the resource system.
---The mounts are persisted between sessions.
---After the mount succeeded, the resources are available to load. (i.e. no reboot required)
---@param name string Unique name of the mount
---@param uri string The uri of the mount, including the scheme. Currently supported schemes are 'zip' and 'archive'.
---@param priority number Priority of mount. Larger priority takes prescedence
---@param callback fun Callback after the asynchronous request completed
---@return number The result of the request
function liveupdate.add_mount(name, uri, priority, callback) end

---Get an array of the current mounts
---This can be used to determine if a new mount is needed or not
---@return table Array of mounts
function liveupdate.get_mounts() end

---Remove a mount the resource system.
---The remaining mounts are persisted between sessions.
---Removing a mount does not affect any loaded resources.
---@param name string Unique name of the mount
---@return number The result of the call
function liveupdate.remove_mount(name) end


return liveupdate