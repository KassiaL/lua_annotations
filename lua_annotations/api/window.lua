---Window API documentation
---Functions and constants to access the window, window event listeners
---and screen dimming.
---@class window
window = {}
---dimming mode off
---Dimming mode is used to control whether or not a mobile device should dim the screen after a period without user interaction.
window.DIMMING_OFF = nil

---dimming mode on
---Dimming mode is used to control whether or not a mobile device should dim the screen after a period without user interaction.
window.DIMMING_ON = nil

---dimming mode unknown
---Dimming mode is used to control whether or not a mobile device should dim the screen after a period without user interaction.
---This mode indicates that the dim mode can't be determined, or that the platform doesn't support dimming.
window.DIMMING_UNKNOWN = nil

---deiconified window event
---This event is sent to a window event listener when the game window or app screen is
---restored after being iconified.
window.WINDOW_EVENT_DEICONIFIED = nil

---focus gained window event
---This event is sent to a window event listener when the game window or app screen has
---gained focus.
---This event is also sent at game startup and the engine gives focus to the game.
window.WINDOW_EVENT_FOCUS_GAINED = nil

---focus lost window event
---This event is sent to a window event listener when the game window or app screen has lost focus.
window.WINDOW_EVENT_FOCUS_LOST = nil

---iconify window event
---This event is sent to a window event listener when the game window or app screen is
---iconified (reduced to an application icon in a toolbar, application tray or similar).
window.WINDOW_EVENT_ICONFIED = nil

---resized window event
---This event is sent to a window event listener when the game window or app screen is resized.
---The new size is passed along in the data field to the event listener.
window.WINDOW_EVENT_RESIZED = nil

---Returns the current dimming mode set on a mobile device.
---The dimming mode specifies whether or not a mobile device should dim the screen after a period without user interaction.
---On platforms that does not support dimming, window.DIMMING_UNKNOWN is always returned.
---@return constant The mode for screen dimming
function window.get_dim_mode() end

---This returns the content scale of the current display.
---@return number The display scale
function window.get_display_scale() end

---This returns the current lock state of the mouse cursor
---@return boolean The lock state
function window.get_mouse_lock() end

---This returns the safe area rectangle (x, y, width, height) and the inset
---values relative to the window edges. On platforms without a safe area,
---this returns the full window size and zero insets.
---@return table safe area data
function window.get_safe_area() end

---This returns the current window size (width and height).
---@return number The window width
---@return number The window height
function window.get_size() end

---Sets the dimming mode on a mobile device.
---The dimming mode specifies whether or not a mobile device should dim the screen after a period without user interaction. The dimming mode will only affect the mobile device while the game is in focus on the device, but not when the game is running in the background.
---This function has no effect on platforms that does not support dimming.
---@param mode constant The mode for screen dimming
function window.set_dim_mode(mode) end

---Sets a window event listener. Only one window event listener can be set at a time.
---@param callback fun(self, event, data)|nil A callback which receives info about window events. Pass an empty function or nil if you no longer wish to receive callbacks.
function window.set_listener(callback) end

---Set the locking state for current mouse cursor on a PC platform.
---This function locks or unlocks the mouse cursor to the center point of the window. While the cursor is locked,
---mouse position updates will still be sent to the scripts as usual.
---@param flag boolean The lock state for the mouse cursor
function window.set_mouse_lock(flag) end

---Sets the window position.
---@param x number Horizontal position of window
---@param y number Vertical position of window
function window.set_position(x, y) end

---Sets the window size. Works on desktop platforms only.
---@param width number Width of window
---@param height number Height of window
function window.set_size(width, height) end

---Sets the window title. Works on desktop platforms.
---@param title string The title, encoded as UTF-8
function window.set_title(title) end


return window