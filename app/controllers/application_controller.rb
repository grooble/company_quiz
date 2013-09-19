class ApplicationController < ActionController::Base
  protect_from_forgery
  include Mobylette::RespondToMobileRequests
  include SessionsHelper
    
  before_filter :set_cache_buster

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
	response.headers['Last-Modified'] = Time.now.httpdate
  end
  
  mobylette_config do |config|
    config[:skip_xhr_requests] = false
  end
	
  #private
    #def is_mobile_request?
    #  true
  #end


end