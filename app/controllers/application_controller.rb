class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :bannato?

  

  def bannato?
    if current_user.present? && current_user.ban == 1
      flash[:notice] = "Questo account è bannato perche: #{current_user.motivo_ban}"
      sign_out current_user
      root_path
    end
  end
end
