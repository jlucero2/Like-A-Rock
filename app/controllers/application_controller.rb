class ApplicationController < ActionController::Base
  protect_from_forgery
  prepend_before_filter :application

  def application
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
