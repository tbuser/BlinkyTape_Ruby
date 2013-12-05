$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require File.expand_path("../lib/BlinkyTape", __FILE__)

Gem::Specification.new do |s|
  s.name              = "BlinkyTape"
  s.rubyforge_project = "BlinkyTape"

  s.version           = BlinkyTape::VERSION
  s.platform          = Gem::Platform::RUBY

  s.summary           = "BlinkyTape Control"
  s.description       = "Control a strip of RGB LEDs from http://blinkinlabs.com/blinkytape/"
  s.authors           = ["Tony Buser"]
  s.email             = 'tbuser@gmail.com'
  s.homepage          = 'http://github.com/tbuser/BlinkyTape_Ruby'
  s.license           = 'GPL-3.0'

  s.require_paths     = ["lib"]
  s.files             = Dir["{lib}/**/*.rb", "test/*", "LICENSE", "README.rdoc"]
  
  s.add_dependency("serialport")
end
