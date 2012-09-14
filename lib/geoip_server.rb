require 'sinatra'
require 'geoip'
require 'multi_json'

data_file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'vendor', 'GeoLiteCity.dat'))

configure :production do
  ENV['APP_ROOT'] ||= File.dirname(__FILE__)
  begin
    $:.unshift "#{ENV['APP_ROOT']}/vendor/plugins/newrelic_rpm/lib"
    require 'newrelic_rpm'
  rescue LoadError
  rescue
  end
end

get '/' do
  %Q{
    <html><title>Detect a computer's location by IP address</title>
    <body style='line-height: 1.8em; font-family: Archer, Museo, Helvetica, Georgia; font-size 25px; text-align: center; padding-top: 20%;'>
      Lookup a location by IP address. Example:
      <pre style='font-family: Iconsolata, monospace;background-color:#EEE'>curl http://#{request.host}/207.97.227.239</pre>
      <br />
      <form action=/ method=GET onsubmit='if(\"\"==this.ip.value)return false;else{this.action=\"/\"+this.ip.value}'>
        <input type=text name='ip' value='#{request.env['HTTP_X_REAL_IP']}' />
        <input type=submit value='Lookup!' />
      </form>
      <div>None of this would be possible without <a href='http://www.maxmind.com/app/geolitecity'>MaxMind</a></div>
    </body></html>
}
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
