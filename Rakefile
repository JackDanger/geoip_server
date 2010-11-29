begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "geoip_server"
    gem.summary = %Q{Query the MaxMind GeoIP data records via a web service}
    gem.description = %Q{Query the MaxMind GeoIP data records via a web service}
    gem.email = "gitcommit@6brand.com"
    gem.homepage = "http://github.com/JackDanger/geoip_server"
    gem.authors = ["Jack Danger Canty"]
    gem.add_dependency "sinatra", ">= 1.0.0"
    gem.add_dependency "active_support", ">= 0"
    gem.add_dependency "geoip", ">= 0"
    gem.add_development_dependency "shoulda", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end



task :default => :test

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << '.'
  test.pattern = 'test.rb'
  test.verbose = true
end




namespace :geoip do
  desc "Update GeoIP City data file"
  task :update_city_lite => :vendor do
    %x{wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz && gzip -d GeoLiteCity.dat.gz && mv GeoLiteCity.dat ./vendor}
  end

  desc "Update GeoIP Country data file"
  task :update_country_lite => :vendor do
    %x{wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz && gzip -d GeoIP.dat.gz && mv GeoIP.dat ./vendor}
  end

  task :vendor do
    %x{mkdir -p vendor}
  end
end