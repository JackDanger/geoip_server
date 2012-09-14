require 'bundler'
Bundler::GemHelper.install_tasks

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
