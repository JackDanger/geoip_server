# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{geoip_server}
  s.version = "1.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jack Danger Canty"]
  s.date = %q{2011-04-10}
  s.description = %q{Query the MaxMind GeoIP data records via a web service}
  s.email = %q{gitcommit@6brand.com}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "README.markdown",
    "Rakefile",
    "VERSION",
    "config.ru",
    "geoip_server.gemspec",
    "lib/geoip_server.rb",
    "test.rb"
  ]
  s.homepage = %q{http://github.com/JackDanger/geoip_server}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.2}
  s.summary = %q{Query the MaxMind GeoIP data records via a web service}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_runtime_dependency(%q<geoip>, [">= 0"])
      s.add_runtime_dependency(%q<i18n>, [">= 0"])
      s.add_runtime_dependency(%q<newrelic_rpm>, [">= 0"])
      s.add_runtime_dependency(%q<sinatra>, [">= 1.0.0"])
      s.add_runtime_dependency(%q<active_support>, [">= 0"])
      s.add_runtime_dependency(%q<geoip>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
    else
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<geoip>, [">= 0"])
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<newrelic_rpm>, [">= 0"])
      s.add_dependency(%q<sinatra>, [">= 1.0.0"])
      s.add_dependency(%q<active_support>, [">= 0"])
      s.add_dependency(%q<geoip>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<geoip>, [">= 0"])
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<newrelic_rpm>, [">= 0"])
    s.add_dependency(%q<sinatra>, [">= 1.0.0"])
    s.add_dependency(%q<active_support>, [">= 0"])
    s.add_dependency(%q<geoip>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
  end
end

