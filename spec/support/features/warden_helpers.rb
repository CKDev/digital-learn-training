include Warden::Test::Helpers

Warden.test_mode!

RSpec.configure do |config|
  config.after do
    Warden.test_reset!
  end
end
