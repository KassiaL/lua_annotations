---Lua table standard library
---Documentation for the Lua table standard library.
---
---From [Lua 5.1 Reference Manual](https://www.lua.org/manual/5.1/)
---by Roberto Ierusalimschy, Luiz Henrique de Figueiredo, Waldemar Celes.
---
---Copyright © 2006-2012 Lua.org, PUC-Rio.
---
---Freely available under the terms of the [Lua license](https://www.lua.org/license.html).
---@class table
table = {}
---Given an array where all elements are strings or numbers,
---returns table[i]..sep..table[i+1] ... sep..table[j].
---The default value for sep is the empty string,
---the default for i is 1,
---and the default for j is the length of the table.
---If i is greater than j, returns the empty string.
---@param table table
---@param sep string|nil
---@param i number|nil
---@param j number|nil
function table.concat(table, sep, i, j) end

---Inserts element value at position pos in table,
---shifting up other elements to open space, if necessary.
---The default value for pos is n+1,
---where n is the length of the table ,
---so that a call table.insert(t,x) inserts x at the end
---of table t.
---@param table table
---@param pos number|nil
---@param value any
function table.insert(table, pos, value) end

---Returns the largest positive numerical index of the given table,
---or zero if the table has no positive numerical indices.
---(To do its job this function does a linear traversal of
---the whole table.)
---@param table table
function table.maxn(table) end

---Removes from table the element at position pos,
---shifting down other elements to close the space, if necessary.
---Returns the value of the removed element.
---The default value for pos is n,
---where n is the length of the table,
---so that a call table.remove(t) removes the last element
---of table t.
---@param table table
---@param pos number|nil
function table.remove(table, pos) end

---Sorts table elements in a given order, in-place,
---from table[1] to table[n],
---where n is the length of the table.
---If comp is given,
---then it must be a function that receives two table elements,
---and returns true
---when the first is less than the second
---(so that not comp(a[i+1],a[i]) will be true after the sort).
---If comp is not given,
---then the standard Lua operator < is used instead.
---The sort algorithm is not stable;
---that is, elements considered equal by the given order
---may have their relative positions changed by the sort.
---@param table table
---@param comp fun|nil
function table.sort(table, comp) end


return table