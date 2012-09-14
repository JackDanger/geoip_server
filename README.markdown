# GeoIP Server

This simple Rack server is useful as a self-hosted service for making lookups to the GeoIP database from MaxMind.com


## Instant installation and deploy

* Clone this: `git clone git://github.com/JackDanger/geoip_server.git`
* Download the free GeoIP data files: `rake geoip:update_city_lite`
* Commit that data file to your clone: `git add vendor && git commit -m "adding data file"`
* Signup for an account at Heroku ([better details here](http://github.com/sinatra/heroku-sinatra-app))
* Create and name a new app where you want to host this
* Push it to Heroku.com: `git push heroku master`


## HowTo

Once the server is running you can make a GET request to the server and receive lookup results in JSON format.

```ruby
require 'json'
require 'open-uri'
# Get the requesting user's IP address
# In a Rails app, you can use: request.remote_ip
# In a Sinatra app, you can use: request.ip
# In a Rack app, you can use: @env['REMOTE_ADDR']
ip = "207.97.227.239"
data = JSON.load(open("http://my-geoip-service-app.herokuapp.com/#{ip}").read)
"You're in: #{data['city']}"
```

Or, straight from a terminal:

    curl http://my-geoip-service-app.herokuapp.com/207.97.227.239

Patches welcome, forks celebrated.

Copyright (c) 2010 [Jack Danger Canty](http://jåck.com). Released under the MIT License.