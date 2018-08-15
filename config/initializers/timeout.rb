if Rails.env.development? && ENV["RACK_TIMEOUT_WAIT_TIMEOUT"].nil?
  ENV["RACK_TIMEOUT_WAIT_TIMEOUT"] = "1000"
  ENV["RACK_TIMEOUT_SERVICE_TIMEOUT"] = "1000"
end

Rack::Timeout.unregister_state_change_observer(:logger) if Rails.env.development?
Rack::Timeout::Logger.disable
