# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'japanese_deinflector/version'

Gem::Specification.new do |s|
  s.name = 'japanese_deinflector'
  s.version = JapaneseDeinflector::VERSION
  s.date = '2012-12-07'
  s.summary = "Deinflect (unconjugate/undecline) Japanese words."
  s.description = "Deinflect (unconjugate/undecline) Japanese words."
  s.authors = ["Peter Graham"]
  s.email = ["pete@gigadrill.com"]
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
  s.homepage = 'http://github.com/6/japanese_deinflector'

  s.add_development_dependency "json"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
