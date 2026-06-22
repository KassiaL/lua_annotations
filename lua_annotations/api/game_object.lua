---Game object API documentation
---Functions, core hooks, messages and constants for manipulation of
---game objects. The "go" namespace is accessible from game object script
---files.
---@class go
go = {}
---vector3 game object euler rotation
---The rotation of the game object expressed in Euler angles.
---Euler angles are specified in degrees in the interval (-360, 360).
---The type of the property is vector3.
euler = nil

---This is a callback-function, which is called by the engine when a script component is finalized (destroyed). It can
---be used to e.g. take some last action, report the finalization to other game object instances, delete spawned objects
---or release user input focus (see release_input_focus).
---@param self userdata reference to the script state to be used for storing data
function final(self) end

---This is a callback-function, which is called by the engine at fixed intervals to update the state of a script
---component. The function will be called if 'Fixed Update Frequency' is enabled in the Engine section of game.project.
---It can for instance be used to update game logic with the physics simulation if using a fixed timestep for the
---physics (enabled by ticking 'Use Fixed Timestep' in the Physics section of game.project).
---@param self userdata reference to the script state to be used for storing data
---@param dt number the time-step of the frame update
function fixed_update(self, dt) end

---in-back
go.EASING_INBACK = nil

---in-bounce
go.EASING_INBOUNCE = nil

---in-circlic
go.EASING_INCIRC = nil

---in-cubic
go.EASING_INCUBIC = nil

---in-elastic
go.EASING_INELASTIC = nil

---in-exponential
go.EASING_INEXPO = nil

---in-out-back
go.EASING_INOUTBACK = nil

---in-out-bounce
go.EASING_INOUTBOUNCE = nil

---in-out-circlic
go.EASING_INOUTCIRC = nil

---in-out-cubic
go.EASING_INOUTCUBIC = nil

---in-out-elastic
go.EASING_INOUTELASTIC = nil

---in-out-exponential
go.EASING_INOUTEXPO = nil

---in-out-quadratic
go.EASING_INOUTQUAD = nil

---in-out-quartic
go.EASING_INOUTQUART = nil

---in-out-quintic
go.EASING_INOUTQUINT = nil

---in-out-sine
go.EASING_INOUTSINE = nil

---in-quadratic
go.EASING_INQUAD = nil

---in-quartic
go.EASING_INQUART = nil

---in-quintic
go.EASING_INQUINT = nil

---in-sine
go.EASING_INSINE = nil

---linear interpolation
go.EASING_LINEAR = nil

---out-back
go.EASING_OUTBACK = nil

---out-bounce
go.EASING_OUTBOUNCE = nil

---out-circlic
go.EASING_OUTCIRC = nil

---out-cubic
go.EASING_OUTCUBIC = nil

---out-elastic
go.EASING_OUTELASTIC = nil

---out-exponential
go.EASING_OUTEXPO = nil

---out-in-back
go.EASING_OUTINBACK = nil

---out-in-bounce
go.EASING_OUTINBOUNCE = nil

---out-in-circlic
go.EASING_OUTINCIRC = nil

---out-in-cubic
go.EASING_OUTINCUBIC = nil

---out-in-elastic
go.EASING_OUTINELASTIC = nil

---out-in-exponential
go.EASING_OUTINEXPO = nil

---out-in-quadratic
go.EASING_OUTINQUAD = nil

---out-in-quartic
go.EASING_OUTINQUART = nil

---out-in-quintic
go.EASING_OUTINQUINT = nil

---out-in-sine
go.EASING_OUTINSINE = nil

---out-quadratic
go.EASING_OUTQUAD = nil

---out-quartic
go.EASING_OUTQUART = nil

---out-quintic
go.EASING_OUTQUINT = nil

---out-sine
go.EASING_OUTSINE = nil

---loop backward
go.PLAYBACK_LOOP_BACKWARD = nil

---loop forward
go.PLAYBACK_LOOP_FORWARD = nil

---ping pong loop
go.PLAYBACK_LOOP_PINGPONG = nil

---no playback
go.PLAYBACK_NONE = nil

---once backward
go.PLAYBACK_ONCE_BACKWARD = nil

---once forward
go.PLAYBACK_ONCE_FORWARD = nil

---once ping pong
go.PLAYBACK_ONCE_PINGPONG = nil

---This is only supported for numerical properties. If the node property is already being
---animated, that animation will be canceled and replaced by the new one.
---If a complete_function (lua function) is specified, that function will be called when the animation has completed.
---By starting a new animation in that function, several animations can be sequenced together. See the examples for more information.
--- If you call go.animate() from a game object's final() function,
---any passed complete_function will be ignored and never called upon animation completion.
---See the properties guide for which properties can be animated and the animation guide for how
---them.
---@param url string|hash|url url of the game object or component having the property
---@param property string|hash id of the property to animate
---@param playback go.PLAYBACK_ONCE_FORWARD|go.PLAYBACK_ONCE_BACKWARD|go.PLAYBACK_ONCE_PINGPONG|go.PLAYBACK_LOOP_FORWARD|go.PLAYBACK_LOOP_BACKWARD|go.PLAYBACK_LOOP_PINGPONG playback mode of the animation
---@param to number|vector3|vector4|quaternion target property value
---@param easing vector|go.EASING_INBACK|go.EASING_INBOUNCE|go.EASING_INCIRC|go.EASING_INCUBIC|go.EASING_INELASTIC|go.EASING_INEXPO|go.EASING_INOUTBACK|go.EASING_INOUTBOUNCE|go.EASING_INOUTCIRC|go.EASING_INOUTCUBIC|go.EASING_INOUTELASTIC|go.EASING_INOUTEXPO|go.EASING_INOUTQUAD|go.EASING_INOUTQUART|go.EASING_INOUTQUINT|go.EASING_INOUTSINE|go.EASING_INQUAD|go.EASING_INQUART|go.EASING_INQUINT|go.EASING_INSINE|go.EASING_LINEAR|go.EASING_OUTBACK|go.EASING_OUTBOUNCE|go.EASING_OUTCIRC|go.EASING_OUTCUBIC|go.EASING_OUTELASTIC|go.EASING_OUTEXPO|go.EASING_OUTINBACK|go.EASING_OUTINBOUNCE|go.EASING_OUTINCIRC|go.EASING_OUTINCUBIC|go.EASING_OUTINELASTIC|go.EASING_OUTINEXPO|go.EASING_OUTINQUAD|go.EASING_OUTINQUART|go.EASING_OUTINQUINT|go.EASING_OUTINSINE|go.EASING_OUTQUAD|go.EASING_OUTQUART|go.EASING_OUTQUINT|go.EASING_OUTSINE easing to use during animation. Either specify a constant, see the animation guide for a complete list, or a vmath.vector with a curve
---@param duration number duration of the animation in seconds
---@param delay number|nil delay before the animation starts in seconds
---@param complete_function fun(self, url, property)|nil optional function to call when the animation has completed
function go.animate(url, property, playback, to, easing, duration, delay, complete_function) end

---By calling this function, all or specified stored property animations of the game object or component will be canceled.
---See the properties guide for which properties can be animated and the animation guide for how to animate them.
---@param url string|hash|url url of the game object or component
---@param property string|hash|nil optional id of the property to cancel
function go.cancel_animations(url, property) end

---Delete one or more game objects identified by id. Deletion is asynchronous meaning that
---the game object(s) are scheduled for deletion which will happen at the end of the current
---frame. Note that game objects scheduled for deletion will be counted against
---max_instances in "game.project" until they are actually removed.
--- Deleting a game object containing a particle FX component emitting particles will not immediately stop the particle FX from emitting particles. You need to manually stop the particle FX using particlefx.stop().
--- Deleting a game object containing a sound component that is playing will not immediately stop the sound from playing. You need to manually stop the sound using sound.stop().
---@param id string|hash|url|table|nil optional id or table of id's of the instance(s) to delete, the instance of the calling script is deleted by default
---@param recursive boolean|nil optional boolean, set to true to recursively delete child hiearchy in child to parent order
function go.delete(id, recursive) end

---This function can check for game objects in any collection by specifying
---the collection name in the URL.
---@param url string|hash|url url of the game object to check
---@return boolean true if the game object exists
function go.exists(url) end

---gets a named property of the specified game object or component
---@param url string|hash|url url of the game object or component having the property
---@param property string|hash id of the property to retrieve
---@param options table|nil optional options table - index number index into array property (1 based) - key hash name of internal property - keys table array of internal component resources identified by key (e.g. a particle fx emitter, see examples below)
---@return number|boolean|hash|url|vector3|vector4|quaternion|resource the value of the specified property
function go.get(url, property, options) end

---Returns or constructs an instance identifier. The instance id is a hash
---of the absolute path to the instance.
---
---
--- * If path is specified, it can either be absolute or relative to the instance of the calling script.
---
--- * If path is not specified, the id of the game object instance the script is attached to will be returned.
---@param path string|nil path of the instance for which to return the id
---@return hash instance id
function go.get_id(path) end

---Get the parent for a game object instance.
---@param id string|hash|url|nil optional id of the game object instance to get parent for, defaults to the instance containing the calling script
---@return hash|nil parent instance or nil
function go.get_parent(id) end

---The position is relative the parent (if any). Use go.get_world_position to retrieve the global world position.
---@param id string|hash|url|nil optional id of the game object instance to get the position for, by default the instance of the calling script
---@return vector3 instance position
function go.get_position(id) end

---The rotation is relative to the parent (if any). Use go.get_world_rotation to retrieve the global world rotation.
---@param id string|hash|url|nil optional id of the game object instance to get the rotation for, by default the instance of the calling script
---@return quaternion instance rotation
function go.get_rotation(id) end

---The scale is relative the parent (if any). Use go.get_world_scale to retrieve the global world 3D scale factor.
---@param id string|hash|url|nil optional id of the game object instance to get the scale for, by default the instance of the calling script
---@return vector3 instance scale factor
function go.get_scale(id) end

---The uniform scale is relative the parent (if any). If the underlying scale vector is non-uniform the min element of the vector is returned as the uniform scale factor.
---@param id string|hash|url|nil optional id of the game object instance to get the uniform scale for, by default the instance of the calling script
---@return number uniform instance scale factor
function go.get_scale_uniform(id) end

---The function will return the world position calculated at the end of the previous frame.
---To recalculate it within the current frame, use go.update_world_transform on the instance before calling this.
---Use go.get_position to retrieve the position relative to the parent.
---@param id string|hash|url|nil optional id of the game object instance to get the world position for, by default the instance of the calling script
---@return vector3 instance world position
function go.get_world_position(id) end

---The function will return the world rotation calculated at the end of the previous frame.
---To recalculate it within the current frame, use go.update_world_transform on the instance before calling this.
---Use go.get_rotation to retrieve the rotation relative to the parent.
---@param id string|hash|url|nil optional id of the game object instance to get the world rotation for, by default the instance of the calling script
---@return quaternion instance world rotation
function go.get_world_rotation(id) end

---The function will return the world 3D scale factor calculated at the end of the previous frame.
---To recalculate it within the current frame, use go.update_world_transform on the instance before calling this.
---Use go.get_scale to retrieve the 3D scale factor relative to the parent.
---This vector is derived by decomposing the transformation matrix and should be used with care.
---For most cases it should be fine to use go.get_world_scale_uniform instead.
---@param id string|hash|url|nil optional id of the game object instance to get the world scale for, by default the instance of the calling script
---@return vector3 instance world 3D scale factor
function go.get_world_scale(id) end

---The function will return the world scale factor calculated at the end of the previous frame.
---To recalculate it within the current frame, use go.update_world_transform on the instance before calling this.
---Use go.get_scale_uniform to retrieve the scale factor relative to the parent.
---@param id string|hash|url|nil optional id of the game object instance to get the world scale for, by default the instance of the calling script
---@return number instance world scale factor
function go.get_world_scale_uniform(id) end

---The function will return the world transform matrix calculated at the end of the previous frame.
---To recalculate it within the current frame, use go.update_world_transform on the instance before calling this.
---@param id string|hash|url|nil optional id of the game object instance to get the world transform for, by default the instance of the calling script
---@return matrix4 instance world transform
function go.get_world_transform(id) end

---This function defines a property which can then be used in the script through the self-reference.
---The properties defined this way are automatically exposed in the editor in game objects and collections which use the script.
---Note that you can only use this function outside any callback-functions like init and update.
---@param name string the id of the property
---@param value number|hash|url|vector3|vector4|quaternion|resource|boolean default value of the property. In the case of a url, only the empty constructor msg.url() is allowed. In the case of a resource one of the resource constructors (eg resource.atlas(), resource.font() etc) is expected.
function go.property(name, value) end

---sets a named property of the specified game object or component, or a material constant
---@param url string|hash|url url of the game object or component having the property
---@param property string|hash id of the property to set
---@param value number|boolean|hash|url|vector3|vector4|quaternion|resource the value to set
---@param options table|nil optional options table - index integer index into array property (1 based) - key hash name of internal property - keys table array of internal component resources identified by key (e.g. a particle fx emitter, see examples below)
function go.set(url, property, value, options) end

---Sets the parent for a game object instance. This means that the instance will exist in the geometrical space of its parent,
---like a basic transformation hierarchy or scene graph. If no parent is specified, the instance will be detached from any parent and exist in world
---space.
---This function will generate a set_parent message. It is not until the message has been processed that the change actually takes effect. This
---typically happens later in the same frame or the beginning of the next frame. Refer to the manual to learn how messages are processed by the
---engine.
---@param id string|hash|url|nil optional id of the game object instance to set parent for, defaults to the instance containing the calling script
---@param parent_id string|hash|url|nil optional id of the new parent game object, defaults to detaching game object from its parent
---@param keep_world_transform boolean|nil optional boolean, set to true to maintain the world transform when changing spaces. Defaults to false.
function go.set_parent(id, parent_id, keep_world_transform) end

---The position is relative to the parent (if any). The global world position cannot be manually set.
---@param position vector3 position to set
---@param id string|hash|url|nil optional id of the game object instance to set the position for, by default the instance of the calling script
function go.set_position(position, id) end

---The rotation is relative to the parent (if any). The global world rotation cannot be manually set.
---@param rotation quaternion rotation to set
---@param id string|hash|url|nil optional id of the game object instance to get the rotation for, by default the instance of the calling script
function go.set_rotation(rotation, id) end

---The scale factor is relative to the parent (if any). The global world scale factor cannot be manually set.
--- See manual to know how physics affected when setting scale from this function.
---@param scale number|vector3 vector or uniform scale factor, must be greater than 0
---@param id string|hash|url|nil optional id of the game object instance to get the scale for, by default the instance of the calling script
function go.set_scale(scale, id) end

---The scale factor is relative to the parent (if any). The global world scale factor cannot be manually set.
--- See manual to know how physics affected when setting scale from this function.
---@param scale number|vector3 vector or uniform scale factor, must be greater than 0
---@param id string|hash|url|nil optional id of the game object instance to get the scale for, by default the instance of the calling script
function go.set_scale_xy(scale, id) end

---Recalculates and updates the cached world transform immediately for the target instance
---and its ancestors (parent chain up to the collection root). Descendants (children) are
---not updated by this function.
---If no id is provided, the instance of the calling script is used.
--- Use this after changing local transform mid-frame when you need the
---new world transform right away (e.g. before end-of-frame updates). Note that child
---instances will still have last-frame world transforms until the regular update.
---@param id string|hash|url|nil optional id of the game object instance to update
function go.update_world_transform(id) end

---The function uses world transformation calculated at the end of previous frame.
---@param position vector3 position which need to be converted
---@param url string|hash|url url of the game object which coordinate system convert to
---@return vector3 converted position
function go.world_to_local_position(position, url) end

---The function uses world transformation calculated at the end of previous frame.
---@param transformation matrix4 transformation which need to be converted
---@param url string|hash|url url of the game object which coordinate system convert to
---@return matrix4 converted transformation
function go.world_to_local_transform(transformation, url) end

---This is a callback-function, which is called by the engine when a script component is initialized. It can be used
---to set the initial state of the script.
---@param self userdata reference to the script state to be used for storing data
function init(self) end

---This is a callback-function, which is called by the engine at the end of the frame to update the state of a script
---component. Use it to make final adjustments to the game object instance.
---@param self userdata reference to the script state to be used for storing data
---@param dt number the time-step of the frame update
function late_update(self, dt) end

---This is a callback-function, which is called by the engine when user input is sent to the game object instance of the script.
---It can be used to take action on the input, e.g. move the instance according to the input.
---For an instance to obtain user input, it must first acquire input focus
---through the message acquire_input_focus.
---Any instance that has obtained input will be put on top of an
---input stack. Input is sent to all listeners on the stack until the
---end of stack is reached, or a listener returns true
---to signal that it wants input to be consumed.
---See the documentation of acquire_input_focus for more
---information.
---The action parameter is a table containing data about the input mapped to the
---action_id.
---For mapped actions it specifies the value of the input and if it was just pressed or released.
---Actions are mapped to input in an input_binding-file.
---Mouse movement is specifically handled and uses nil as its action_id.
---The action only contains positional parameters in this case, such as x and y of the pointer.
---Here is a brief description of the available table fields:
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---Gamepad specific fields:
---
---
---
---
---
---
---
---
---
---Touch input table:
---
---
---
---
---
---
---
---
---
---
---
---
---@param self userdata reference to the script state to be used for storing data
---@param action_id hash id of the received input action, as mapped in the input_binding-file
---@param action table a table containing the input data, see above for a description
---@return boolean|nil optional boolean to signal if the input should be consumed (not passed on to others) or not, default is false
function on_input(self, action_id, action) end

---This is a callback-function, which is called by the engine whenever a message has been sent to the script component.
---It can be used to take action on the message, e.g. send a response back to the sender of the message.
---The message parameter is a table containing the message data. If the message is sent from the engine, the
---documentation of the message specifies which data is supplied.
---@param self userdata reference to the script state to be used for storing data
---@param message_id hash id of the received message
---@param message table a table containing the message data
---@param sender url address of the sender
function on_message(self, message_id, message, sender) end

---This is a callback-function, which is called by the engine when the script component is reloaded, e.g. from the editor.
---It can be used for live development, e.g. to tweak constants or set up the state properly for the instance.
---@param self userdata reference to the script state to be used for storing data
function on_reload(self) end

---vector3 game object position
---The position of the game object.
---The type of the property is vector3.
position = nil

---quaternion game object rotation
---The rotation of the game object.
---The type of the property is quaternion.
rotation = nil

---number game object scale
---The uniform scale of the game object. The type of the property is number.
scale = nil

---This is a callback-function, which is called by the engine every frame to update the state of a script component.
---It can be used to perform any kind of game related tasks, e.g. moving the game object instance.
---@param self userdata reference to the script state to be used for storing data
---@param dt number the time-step of the frame update
function update(self, dt) end


return go