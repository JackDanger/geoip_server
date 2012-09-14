require 'sinatra'
require 'geoip'
require 'multi_json'

data_file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'vendor', 'GeoLiteCity.dat'))

configure :production do
  begin
    require 'newrelic_rpm'
  rescue LoadError
  end
end

get '/' do
<<END
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <style type="text/css">
      body {
        font-family: Archer, Museo, Helvetica, Georgia;
        margin: 0;
        padding-top: 20%;
        text-align: center;
      }
      code {
        background-color: #eee;
        display: block;
        font-family: Iconsolata, monospace;
        font-weight: 700;
        line-height: 2.0em;
      }
      form {
        margin-top: 20px;
      }
      input, button {
        border-radius: 3px;
        font-size: 1.0em;
        padding: 5px;
      }
    </style>
    <title>Detect a computer's location by IP address</title>
  </head>
  <body>
    <h4>
      Lookup a location by IP address. Example:
    </h4>
    <code>
      curl http://#{request.env['HTTP_HOST']}/207.97.227.239
    </code>
    <form action="/" method="get" onsubmit="if(this.ip.value) { this.action = '/' + this.ip.value } else { return false }">
      <input type="text" name="ip" value="#{request.env['HTTP_X_REAL_IP']}">
      <button type="submit">Lookup!</button>
    </form>
    <p>
      None of this would be possible without <a href="http://www.maxmind.com/app/geolite">MaxMind</a>.
    </p>
  </body>
</html>
END
end

get /\/(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})$/ do |ip|
  data = GeoIP.new(data_file).city(ip)
  content_type 'application/json;charset=ascii-8bit'
  headers['Cache-Control'] = "public; max-age=31536000" # = 365 (days) * 24 (hours) * 60 (minutes) * 60 (seconds)
  return "{}" unless data
  respond_with(MultiJson.encode(encode(data)))
end

def respond_with json
  # jsonp support
  callback, variable = params[:callback], params[:variable]
  if callback && variable
    "var #{variable} = #{json};\n#{callback}(#{variable});"
  elsif variable
    "var #{variable} = #{json};"
  elsif callback
    "#{callback}(#{json});"
  else
    json
  end
end

def encode data
  {
    # The host or IP address string as requested
    :ip => data.request,
    # The IP address string after looking up the host
    :ip_lookup => data.ip,
    # The ISO3166-1 two-character country code
    :country_code => data.country_code2,
    # The ISO3166-2 three-character country code
    :country_code_long => data.country_code3,
    # The ISO3166 English-language name of the country
    :country => data.country_name,
    # The two-character continent code
    :continent => data.continent_code,
    # The region name
    :region => data.region_name,
    # The city name
    :city => data.city_name,
    # The postal code
    :postal_code => data.postal_code,
    # The latitude
    :lat => data.latitude,
    # The longitude
    :lng => data.longitude,
    # The USA DMA code, if available
    :dma_code => data.dma_code,
    # The area code, if available
    :area_code => data.area_code,
    # Timezone, if available
    :timezone => data.timezone,
  }
end
