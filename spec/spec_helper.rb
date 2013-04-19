require 'codependency'

Dir[ './spec/support/*.rb' ].each { |f| require f }

RSpec.configure do |config|
  config.color_enabled                    = true
  config.fail_fast                        = false
  config.run_all_when_everything_filtered = true
  config.filter_run_including :focus  => true
  config.filter_run_excluding :broken => true
end
