---Sprite API documentation
---Functions, messages and properties used to manipulate sprite components.
---@class sprite
sprite = {}
---hash sprite animation
---READ ONLY The current animation id. An animation that plays currently for the sprite. The type of the property is hash.
animation = nil

---number sprite cursor
---The normalized animation cursor. The type of the property is number.
cursor = nil

---hash sprite frame_count
---READ ONLY The frame count of the currently playing animation.
frame_count = nil

---hash sprite image
---The image used when rendering the sprite. The type of the property is hash.
image = nil

---hash sprite material
---The material used when rendering the sprite. The type of the property is hash.
material = nil

---number sprite playback_rate
---The animation playback rate. A multiplier to the animation playback rate. The type of the property is number.
---The playback_rate is a non-negative number, a negative value will be clamped to 0.
playback_rate = nil

---vector3 sprite scale
---The non-uniform scale of the sprite. The type of the property is vector3.
scale = nil

---vector3 sprite size
---The size of the sprite, not allowing for any additional scaling that may be applied.
---The type of the property is vector3. It is not possible to set the size if the size mode
---of the sprite is set to auto.
size = nil

---vector4 sprite slice
---The slice values of the sprite. The type of the property is a vector4 that corresponds to
---the left, top, right, bottom values of the sprite in the editor.
---It is not possible to set the slice property if the size mode of the sprite is set to auto.
slice = nil

---Play an animation on a sprite component from its tile set
---An optional completion callback function can be provided that will be called when
---the animation has completed playing. If no function is provided,
---a animation_done message is sent to the script that started the animation.
---@param url string|hash|url the sprite that should play the animation
---@param id string|hash hashed id of the animation to play
---@param complete_function fun(self, message_id, message, sender)|nil function to call when the animation has completed.
---@param play_properties table|nil optional table with properties:
function sprite.play_flipbook(url, id, complete_function, play_properties) end

---Sets horizontal flipping of the provided sprite's animations.
---The sprite is identified by its URL.
---If the currently playing animation is flipped by default, flipping it again will make it appear like the original texture.
---@param url string|hash|url the sprite that should flip its animations
---@param flip boolean true if the sprite should flip its animations, false if not
function sprite.set_hflip(url, flip) end

---Sets vertical flipping of the provided sprite's animations.
---The sprite is identified by its URL.
---If the currently playing animation is flipped by default, flipping it again will make it appear like the original texture.
---@param url string|hash|url the sprite that should flip its animations
---@param flip boolean true if the sprite should flip its animations, false if not
function sprite.set_vflip(url, flip) end


return sprite