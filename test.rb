ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'rack/test'
require File.expand_path(File.join(File.dirname(__FILE__), 'lib/geoip_server'))

class GeoipServerTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context "on GET to /" do
    setup {
      get '/'
    }
    should "return ok" do
      assert last_response.ok?
    end
    should "have some kind of welcome" do
      assert last_response.body =~ /curl/
    end
  end

  context "on GET to /:ip" do
    setup {
      get '/67.161.92.71'
    }
    should "return ok" do
      assert last_response.ok?
    end
    should "return json conent-type" do
      assert_equal 'application/json;charset=ascii-8bit', last_response.headers['Content-Type']
    end
  end

  context "on GET to /:ip?callback=myCallbackFunction" do
    setup {
      get '/67.161.92.71?callback=myCallbackFunction'
    }
    should "return ok" do
      assert last_response.ok?
    end
    should "return json content-type" do
      assert_equal 'application/json;charset=ascii-8bit', last_response.headers['Content-Type']
    end
    should "have a function as result" do
      assert last_response.body =~ /myCallbackFunction\(\{.*\}\)/
    end
  end

  context "converting array" do
    setup {
      array = [
        "67.161.92.71",
        "67.161.92.71",
        "US",
        "USA",
        "United States",
        "NA",
        "WA",
        "Seattle",
        "98117",
        47.6847,
        -122.3848,
        819,
        206,
        "America/Los_Angeles"
      ]
      @hash = encode(array)
    }
    should "find city" do
      assert_equal 'Seattle', @hash[:city]
    end
    should "find country" do
      assert_equal 'United States', @hash[:country]
    end
    should "find lat" do
      assert_equal 47.6847, @hash[:lat]
    end
    should "find lng" do
      assert_equal -122.3848, @hash[:lng]
    end
  end
end
