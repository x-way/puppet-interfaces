if RUBY_VERSION.to_f >= 1.9
  require 'coveralls'
  Coveralls.wear_merged!
end

require 'rubygems'
require 'puppetlabs_spec_helper/module_spec_helper'
