class ApplicationController < ActionController::Base
  protect_from_forgery
  #include Mobylette::RespondToMobileRequests
  include SessionsHelper
  
  #private

   # def is_mobile_request?
   #  true
   # end

end
