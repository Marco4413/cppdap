term.pushColor(term.yellow)
print("Workspace: cppdap")
term.popColor()
require("premake", ">=5.0.0-beta4")

workspace "cppdap"
  configurations { "Debug", "Release" }
  startproject "cppdap"

include "cppdap"