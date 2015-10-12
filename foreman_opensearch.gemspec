require File.expand_path('../lib/foreman_opensearch/version', __FILE__)
require 'date'

Gem::Specification.new do |s|
  s.name        = 'foreman_opensearch'
  s.version     = ForemanOpensearch::VERSION
  s.date        = Date.today.to_s
  s.authors     = ['Shim Shtein']
  s.email       = ['sshtein@redhat.com']
  s.homepage    = 'https://github.com/ShimShtein/foreman-opensearch'
  s.summary     = 'Foreman plugin to enable omnibox/search box integration.'
  # also update locale/gemspec.rb
  s.description = 'Small plugin that publishes opensearch XML file declaration.'

  s.files = Dir['{app,config,db,lib,locale}/**/*'] + ['LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.extra_rdoc_files = ['LICENSE', 'README.md']
  s.licenses = ['GPL-3']

  s.add_dependency 'deface'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rdoc'
end
