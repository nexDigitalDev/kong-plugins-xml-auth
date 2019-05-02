package = "plugin-test"
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
      ["kong.plugins.plugin-test.access"] = "kong/plugins/plugin-test/access.lua",
      ["kong.plugins.plugin-test.handler"] = "kong/plugins/plugin-test/handler.lua",
      ["kong.plugins.plugin-test.schema"] = "kong/plugins/plugin-test/schema.lua"
   }
}
