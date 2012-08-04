require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir     = 'spec/cassettes'
  c.hook_into                :fakeweb
  c.default_cassette_options = { :record => :new_episodes }
  c.configure_rspec_metadata!
end


RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
  RSpec.configure do |c|
    c.treat_symbols_as_metadata_keys_with_true_values = true
  end
end

