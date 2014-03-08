class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter :flash_to_headers

  def render404
    render :file => File.join(Rails.root, 'public', '404.html'), :status => 404, :layout => false
    return true
  end
  
  def flash_to_headers
    if request.xhr?
      #avoiding XSS injections via flash
      flash_json = Hash[flash.map{|k,v| [k,ERB::Util.h(v)] }].to_json
      response.headers['X-Flash-Messages'] = flash_json
      flash.discard
    end
  end
  def after_sign_in_path_for(resource)
    if current_user.present?
      return root_path;
    else
      return edit_user_registration_path(resource)
    end    
  end
end
