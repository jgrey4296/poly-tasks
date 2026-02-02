--  basic.lua -*- mode: lua-mode -*-
--  Summary:
--
--  Tags:
--
local getlocal    = require("debug" ).getlocal
local texio       = require("texio")

-- Consts
local BEGIN          = [[\begin]]
local END            = [[\end]]
local NODE           = [[\node]]
local OBRACE         = "{"
local CBRACE         = "}"
local LDOTS          = [[\ldots]]
local EMPTYSET       = [[\emptyset{}]]
local DRAW           = [[\draw]]
local EMPH           = [[\emph]]
local BOTTOM         = [[$\bot$]]
local TOP            = [[$\top$]]
local TURNSTILE      = [[$\vdash$]]
local ENDSTILE       = [[$\dashv$]]

local TheObject = {
  WRITE_DEBUG     = false,
}

local function debug(str, ...)
  -- Writes out debug information when the package is loaded with the debug option
  local val
  if TheObject.WRITE_DEBUG ~= true then return end
  if ... then
    val = string.format(str, ...)
  else
    val = str
  end
  texio.write_nl("term", "-- EventChain --: "  .. val .. "\n")
end

--   --------------------------------------------------

function TheObject:new ()
  -- ctor for an eventchain. Takes a direction, a node distance
  debug("Creating TheObject")
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end


--   --------------------------------------------------

function TheObject:output (...)
  -- Util method to output strings to the tex file for expansion.
  local extra = table.pack(...)
  ::loop:: for i,v in ipairs(extra) do
    if v == nil then goto loop end
    table.insert(self.total, v)
    tex.print(v)
  end
end

function TheObject:output_parts (...)
  -- Util method to output strings to the tex file for expansion.
  local extra = table.pack(...)
  for i,v in ipairs(extra) do
    for m in string.gmatch(v, "[^\n]+") do
      table.insert(self.total, m)
      tex.print(m)
    end
  end
end

function TheObject:s_output (...)
  -- Util method to output strings to the tex file for expansion.
  local extra = table.pack(...)
  tex.sprint(extra)
end

--   --------------------------------------------------

return TheObject
