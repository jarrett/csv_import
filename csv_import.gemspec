# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "csv_import/version"

Gem::Specification.new do |s|
  s.name        = "csv_import"
  s.version     = CsvImport::VERSION
  s.authors     = ["Paul McMahon"]
  s.email       = ["paul@mobalean.com"]
  s.homepage    = "http://www.mobalean.com"
  s.summary     = %q{Easy CSV importing in Rails}
  s.description = %q{Use this Rails 3 plugin to easily import data via csv files}

  s.rubyforge_project = "csv_import"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rails', '~> 3.0'
  s.add_dependency 'haml', '~> 3.1'

  s.add_development_dependency 'rspec', '~> 2.5.0'
  s.add_development_dependency 'steak'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'launchy'
end
