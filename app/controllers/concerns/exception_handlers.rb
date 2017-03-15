module Concerns::ExceptionHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from Exceptions::UnprocessableEntity, with: :handle_exception
  end

  protected

  def handle_exception(e)
    render json: { errors: e.message }, status: 422
  end
end