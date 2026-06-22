---Model API documentation
---Functions and messages for interacting with model components.
---@class model
model = {}
---hash model animation
---The current animation set on the component. The type of the property is hash.
animation = nil

---number model cursor
---The normalized animation cursor. The type of the property is number.
--- Please note that model events may not fire as expected when the cursor is manipulated directly.
cursor = nil

---hash model material
---The material used when rendering the model. The type of the property is hash.
material = nil

---Cancels all animation on a model component.
---@param url string|hash|url the model for which to cancel the animation
function model.cancel(url) end

---Get AABB of the whole model in local coordinate space.
---AABB information return as a table with min and max fields, where min and max has type vmath.vector3.
---@param url string|hash|url the model
---@return table A table containing AABB of the model. If model has no meshes - return vmath.vector3(0,0,0) for min and max fields.
function model.get_aabb(url) end

---Gets the id of the game object that corresponds to a model skeleton bone.
---The returned game object can be used for parenting and transform queries.
---This function has complexity O(n), where n is the number of bones in the model skeleton.
---Game objects corresponding to a model skeleton bone can not be individually deleted.
---@param url string|hash|url the model to query
---@param bone_id string|hash id of the corresponding bone
---@return hash id of the game object
function model.get_go(url, bone_id) end

---Get AABB of all meshes.
---AABB information return as a table with min and max fields, where min and max has type vmath.vector3.
---@param url string|hash|url the model
---@return table A table containing info about all AABB in the format
function model.get_mesh_aabb(url) end

---Get the enabled state of a mesh
---@param url string|hash|url the model
---@param mesh_id string|hash|url the id of the mesh
---@return boolean true if the mesh is visible, false otherwise
function model.get_mesh_enabled(url, mesh_id) end

---Plays an animation on a model component with specified playback
---mode and parameters.
---An optional completion callback function can be provided that will be called when
---the animation has completed playing. If no function is provided,
---a model_animation_done message is sent to the script that started the animation.
--- The callback is not called (or message sent) if the animation is
---cancelled with model.cancel. The callback is called (or message sent) only for
---animations that play with the following playback modes:
---
---
--- * go.PLAYBACK_ONCE_FORWARD
---
--- * go.PLAYBACK_ONCE_BACKWARD
---
--- * go.PLAYBACK_ONCE_PINGPONG
---@param url string|hash|url the model for which to play the animation
---@param anim_id string|hash id of the animation to play
---@param playback constant playback mode of the animation
---@param play_properties table|nil optional table with properties Play properties table:
---@param complete_function fun(self, message_id, message, sender)|nil function to call when the animation has completed.
function model.play_anim(url, anim_id, playback, play_properties, complete_function) end

---Enable or disable visibility of a mesh
---@param url string|hash|url the model
---@param mesh_id string|hash|url the id of the mesh
---@param enabled boolean true if the mesh should be visible, false if it should be hideen
function model.set_mesh_enabled(url, mesh_id, enabled) end

---number model playback_rate
---The animation playback rate. A multiplier to the animation playback rate. The type of the property is number.
playback_rate = nil

---hash model textureN where N is 0-7
---The texture hash id of the model. Used for getting/setting model texture for unit 0-7
textureN = nil


return model