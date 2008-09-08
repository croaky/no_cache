module Thoughtbot
  module NoCache
    def self.included(base)
      base.class_eval do
        extend Thoughtbot::NoCache::ClassMethods
        include Thoughtbot::NoCache::InstanceMethods
      end
    end

    #
    # Example:
    #
    #   # Controller
    #   class PurchasesController < ApplicationController
    #     no_cache [:new]
    #   end
    #
    module ClassMethods
      def no_cache(actions)
        before_filter :dont_cache, :only => actions
      end
    end
    
    module InstanceMethods # :nodoc:
      def dont_cache
        response.headers["Last-Modified"] = Time.now.httpdate
        response.headers["Expires"] = '0'
        response.headers["Pragma"] = "no-cache"
        response.headers["Cache-Control"] = 'no-store, no-cache, must-revalidate, max-age=0, pre-check=0, post-check=0'
      end
    end
  end
  
  module NoCacheHelpers
    #
    # Example:
    #
    #   # View
    #   <%= hidden_iframe %>
    #
    def hidden_iframe
      html = '<iframe style="height:0px;width:0px;visibility:hidden" src="about:blank">'
      html << 'this frame prevents back forward cache'
      html << '</iframe>'
      html
    end
  end
end