source :rubygems

puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>= 2.7']

gem 'rake'
gem 'puppet-lint'
gem 'rspec-puppet'
gem 'puppet', puppetversion
gem 'puppetlabs_spec_helper', '>= 0.1.0'
gem 'coveralls', :require => false if RUBY_VERSION.to_f >= 1.9
