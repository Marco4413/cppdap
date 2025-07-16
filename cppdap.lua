require("premake", ">=5.0.0-beta4")

local configpath = "%{cfg.system}_%{cfg.architecture}/%{cfg.buildcfg}"
local buildpath  = "%{prj.location}/" .. configpath

local function cxxflags()
  filter "toolset:gcc or clang"
    buildoptions {
      "-Wall", "-Wextra", "-Wno-pedantic",
      "-Werror",
    }

  filter "action:vs*"
    fatalwarnings { "All" }
    warnings "Extra"
    externalwarnings "Extra"

  filter "toolset:msc"
    buildoptions { "/W4", "/WX" }

  filter "system:windows"
    defines "_CRT_SECURE_NO_WARNINGS"

  -- filter { "system:windows", "toolset:gcc or clang" }
  --   buildoptions { "-Wa,-mbig-obj" }

  filter "configurations:Debug*"
    symbols "On"

  filter "configurations:Release*"
    optimize "Speed"
end

project "cppdap"
  kind "StaticLib"
  language "C++"
  cppdialect "C++11"

  location "build/cppdap"
  targetdir (buildpath)
  objdir    (buildpath .. "/obj")

  defines "CPPDAP_JSON_NLOHMANN"
  includedirs { "include", "third_party/json/include" }
  files {
    "src/content_stream.cpp",
    "src/io.cpp",
    "src/nlohmann_json_serializer.cpp",
    "src/network.cpp",
    "src/null_json_serializer.cpp",
    "src/protocol_events.cpp",
    "src/protocol_requests.cpp",
    "src/protocol_response.cpp",
    "src/protocol_types.cpp",
    "src/session.cpp",
    "src/socket.cpp",
    "src/typeinfo.cpp",
    "src/typeof.cpp",
  }

  filter "system:linux"
    links "pthread"

  filter "system:windows"
    links "ws2_32"

  cxxflags()
