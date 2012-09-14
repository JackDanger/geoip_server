Gem::Specification.new do |s|
  s.name = 'geoip_server'
  s.version = '1.2.0'
  s.authors = ["Jack Danger Canty"]
  s.description = 'Query the MaxMind GeoIP data records via a web service'
  s.email = 'gitcommit@6brand.com'
  s.files = %w(Gemfile Gemfile.lock README.markdown Rakefile config.ru geoip_server.gemspec test.rb)
  s.files += Dir.glob('lib/**/*.rb')
  s.test_files = %w(test.rb)
  s.homepage = 'http://github.com/JackDanger/geoip_server'
  s.require_paths = ['lib']
  s.summary = s.description
  s.add_dependency 'sinatra', '~> 1.1'
  s.add_dependency 'geoip', '~> 1.1'
  s.add_dependency 'multi_json', '~> 1.3'
  s.add_dependency 'newrelic_rpm', '~> 3.4'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'shoulda'
  s.add_development_dependency 'rack-test'
end
