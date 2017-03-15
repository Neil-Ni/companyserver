class ApplicationController < ActionController::Base
  include Concerns::ExceptionHandlers
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

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
