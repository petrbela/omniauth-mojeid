# encoding: utf-8
require File.expand_path('../lib/omniauth-mojeid/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name = 'omniauth-mojeid'
  gem.version = OmniAuth::MojeID::VERSION
  gem.summary = %Q{MojeID strategy for OmniAuth}
  gem.description = %q{OmniAuth strategy to work with http://www.mojeid.cz}
  gem.homepage = 'https://github.com/petrbela/omniauth-mojeid'

  gem.authors = ['Petr Bela']
  gem.email = 'github@petrbela.com'
  gem.license = "MIT"
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ['lib']

  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6') if gem.respond_to?(:required_rubygems_version=)

  gem.add_dependency 'omniauth'
  gem.add_dependency 'rack-openid'
  gem.add_dependency 'ruby-openid'
  gem.add_dependency 'omniauth-openid'
  gem.add_dependency 'json'

  gem.add_development_dependency 'rack-test', '~> 0.5'
  gem.add_development_dependency 'rspec', '~> 2.8.0'
  gem.add_development_dependency 'rake', '~> 0.8'
  gem.add_development_dependency 'rdiscount', '~> 1.6'
  gem.add_development_dependency 'simplecov', '~> 0.4'
  gem.add_development_dependency 'webmock', '~> 1.7'
  gem.add_development_dependency 'yard', '~> 0.7'
  # gem 'guard'
  # gem 'guard-rspec'
  # gem 'growl'
  # gem 'rb-fsevent', '~> 0.9.3'
  # gem 'bundler', '~> 1.3.4'

end