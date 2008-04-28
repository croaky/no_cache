require File.join(File.dirname(__FILE__), 'lib', 'no_cache')
ActionController::Base.send :include, Thoughtbot::NoCache
ActionController::Base.helper Thoughtbot::NoCacheHelpers
