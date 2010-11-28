# GeoIP Server

This simple Rack server is useful as a self-hosted service for making lookups to the GeoIP database from MaxMind.com


## Instant installation and deploy

* Clone this: `git clone git://github.com/JackDanger/geoip_server.git`
* Download the free GeoIP data files: `rake geoip:update_city_lite`
* Signup for an account at Heroku ([better details here](http://github.com/sinatra/heroku-sinatra-app))
* Create and name a new app where you want to host this
* push it to Heroku.com: `git push heroku master`


## HowTo

Once the server is running you can make a GET request to the server and receive lookup results in JSON format.

    ip = request.remote_ip
    require 'open-uri'
    data = JSON.decode(open("http://my-geoip-service-app.heroku.com/#{ip}").read)
    render :text => "You're in: #{data[:city]}"

Or, straight from a terminal:

    curl -X POST http://my-geoip-service-app.heroku.com/207.97.227.239

Patches welcome, forks celebrated.

Copyright (c) 2010 [Jack Danger Canty](http://jåck.com). Released under the MIT License.