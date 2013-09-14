class ApplicationController < ActionController::Base
  protect_from_forgery
  include Mobylette::RespondToMobileRequests
  include SessionsHelper
    
  
    mobylette_config do |config|
      config[:skip_xhr_requests] = false
    end
	
  #private
    #def is_mobile_request?
    #  true
    #end


end
