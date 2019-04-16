package = "kong-plugin-header-echo"
version = "0.1.0-1"
source = {
   url = "git+https://github.com/nexDigitalDev/kong-plugins-xml-auth.git"
}
description = {
   homepage = "https://github.com/nexDigitalDev/kong-plugins-xml-auth",
   license = "*** please specify a license ***"
}
dependencies = {}
build = {
   type = "builtin",
   modules = {
      ["kong.plugins.kong-plugin-header-echo.handler"] = "kong/plugins/kong-plugin-header-echo/handler.lua",
      ["kong.plugins.kong-plugin-header-echo.schema"] = "kong/plugins/kong-plugin-header-echo/schema.lua"
   }
}
