# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'lkml/version'

Gem::Specification.new do |s|
  s.name        = 'lkml'
  s.version     = Lkml::VERSION
  s.authors     = ['Sylvain Utard']
  s.email       = 'sylvain.utard@gmail.com'
  s.homepage    = ''
  s.summary     = 'LookML Ruby Parser'
  s.description = ''
  s.license     = 'MIT'
  s.required_ruby_version = '>= 3.3'
  s.files         = Dir['lib/**/*', '*.md']
  s.require_paths = %w[lib]
  s.metadata['rubygems_mfa_required'] = 'true'
end
