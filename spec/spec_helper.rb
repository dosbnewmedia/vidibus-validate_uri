$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "rubygems"
require "active_support/core_ext"
require "active_record"
require "action_controller"
require "spec"
require "rr"
require "vidibus-validate_uri"

I18n.load_path += Dir[File.join('config', 'locales', '**', '*.{rb,yml}')]

Spec::Runner.configure do |config|  
  config.mock_with RR::Adapters::Rspec
end