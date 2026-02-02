-- ## init.lua -*- mode: lua-mode -*-
-- # Summary: Init file passed to lualatex in calls of cargo tex
-- #
-- # Tags:
-- #
local getlocal  = require("debug" ).getlocal
local texio     = require("texio")
local status    = require("status")
local token     = require("token")

function write_to_aux ()
  info = status.list()
  base_path = string.format("%s.aux", string.sub(info.filename, 0, -5))
  texio.write_nl("term", string.format("Writing to Aux: %s", base_path))
  auxf = io.open(base_path,"a+")
  if auxf == nil then return end
  auxf:write([[ Example Text ]])
  -- f:write([[\def\gtt@chartextrasize#1#2{}]])
  auxf:close()
end
