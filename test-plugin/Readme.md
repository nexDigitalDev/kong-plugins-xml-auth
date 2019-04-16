# A simple kong plugin

For this one, we'll see how to start with a simple custom plugin with kong, with the right configuration. For starters, you need to prepare your development environment. For this, I opted for the local installation of Kong and configure a service from which we will test the plugins.

  - Install kong
  - Configuring a service
  - create your plugins

# Create your plugin
How it works, we will create a simple header echo plugin. Here's an example of how it should work, the user will send the request he wants , like this: 
'X-request: --what you want--'

    Request: $ curl -i http://localhost:8000/nx-service/request -H 'Host: mockbin.org' -H 'X-Request-Echo: Hello my friend'
    Response: contains the header 'X-Response-Echo: Hello my friend'

nx-service : name of our service

# Start your plugin development!

Create your directory : 
    > kong-plugin-header-echo
The structure of the plugins should be like this inside of your principal directory: 

    $ mkdir -p kong-plugin-header-echo/kong/plugins/kong-plugin-header-echo/
    $ touch kong-plugin-header-echo/kong/plugins/kong-plugin-header-echo/handler.lua
    $ touch kong-plugin-header-echo/kong/plugins/kong-plugin-header-echo/schema.lua


After configuring the structure of your directory, we 're gonna generate the template for the rockspec, using luarocks (package manager for lua programming language).
As we know, libraries and packages managed by luarocks are called .rocks
So, for generate this: 

    $ luarocks write_rockspec
    # And rename the following files in the right version
    $ mv kong-plugin-header-echo-scm-1 kong-plugin-header-echo-0.1.0-1.rockspec
    
# Define the schema.lua and handler.lua

> shcema.lua
> handler.lua

Now, when plugins configuration is done, you have to setup your custom plugin into the basic plugin modules:
 . which each function will be run at the desired moment in the lifecycle of a request.
 . by the user. This module holds the schema of that configuration and defines rules on it, so that the user can only enter valid configuration values.

# Build the plugin
You have to add your plugin on Kong:

    $ KONG_PLUGINS=bundled,kong-plugin-header-echo kong start -c /path/kong.conf
   
And verify that Kong knows about your plugin, with the following command:

    $ curl http://localhost:8001/

Your plugins should be inside the list.
Now that Kong knows about our plugin, we need to activate it using the Admin API. To do so, run the following command:

    $ curl -X POST \
        --url "http://localhost:8001/services/nx-service/plugins" \
        --data "name=kong-plugin-header-echo" \

You should have something like this


    HTTP/1.1 200 OK
    Access-Control-Allow-Origin: *
    Connection: keep-alive
    Content-Length: 273
    Content-Type: application/json; charset=utf-8
    Date: Tue, 16 Apr 2019 11:42:15 GMT
    Server: kong/0.14.1
    {
    "data": [
        {
            "config": {
                "requestHeader": "X-Request-Echo",
                "responseHeader": "X-Response-Echo"
            },
            "created_at": 1555409967000,
            "enabled": true,
            "id": "0957664d-a7fb-4785-acf6-d0f1a125c3e0",
            "name": "kong-plugin-header-echo",
            "service_id": "46ddce85-3cea-4b90-a413-d0d4406d3bab"
        }
    ],
    "total": 1
    }
    

And last,  Run the following command using port 8000, not 8001:


    curl -i http://localhost:8000/nx-service/request -H 'Host: example.com' -H 'X-Request-Echo: Hello Friend'

You should have : 

    Fsdqsq
    Content-Type: text/html; charset=utf-8
    Content-Length: 28
    Connection: keep-alive
    Server: openresty/1.13.6.2
    Date: Tue, 16 Apr 2019 11:54:21 GMT 
    X-Content-Type-Options: nosniff
    Vary: Accept-Encoding
    ...
    X-Kong-Proxy-Latency: 16
    X-Response-Echo: Hello Friend
    ...

#### Useful links
- [Kong installation](https://medium.com/@vasista/kong-api-gateway-installation-guide-for-beginners-ab6c796b36bf)
- [Configuring service](https://docs.konghq.com/1.1.x/getting-started/configuring-a-service/)
- [Plugin development](https://docs.konghq.com/1.1.x/plugin-development/)




 
