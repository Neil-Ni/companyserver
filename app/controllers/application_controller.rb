class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def current_user
    # TODO: uncomment after devise login is implemented
    # @current_user
    @current_user ||= User.first
  end

  def current_company
    current_user.company
  end
end
