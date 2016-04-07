$:.push File.expand_path('../lib', __FILE__)

require 'grape_on_rails_routes/version'
require 'rake'

Gem::Specification.new do |s|
  s.name        = 'grape_on_rails_routes'
  s.version     = GrapeOnRailsRoutes::VERSION
  s.license     = 'MIT'
  s.summary     = 'Grape API routes'
  s.description = "View routes for all Grape API's mounted on Rails"
  s.authors     = %w(syedmusamah)
  s.email       = %w(syed@thredup.com)
  s.homepage    = 'https://github.com/syedmusamah/grape_on_rails_routes'

  s.files = FileList['lib/**/*.rb'].to_a

  s.add_dependency 'grape', '~> 0.16.1'
  s.add_dependency 'rails', '>= 3.1.1', '< 5'

  s.add_development_dependency 'sqlite3', '~> 1'
end
