class ApplicationController < ActionController::Base
  protect_from_forgery
  prepend_before_filter :application

  def application
     @pageTitle = "University of South Florida"
     @TickerResponses = Response.order('created_at DESC').all(:limit => 3)
    if !admin_signed_in? && !user_signed_in?
      if User.where(:name => "Guest" + request.remote_ip).empty?
        user = User.new
        user.name = "Guest" + request.remote_ip
        user.ip = request.remote_ip
        user.email = user.ip + "@likearock.com"
        user.password = "password"
        user.password_confirmation = "password"
        user.save
      end
    end
  end
end
