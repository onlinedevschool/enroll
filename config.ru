# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
require "rack-timeout"

use Rack::Timeout
Rack::Timeout.timeout = 5

use Rack::Deflater
run Rails.application
