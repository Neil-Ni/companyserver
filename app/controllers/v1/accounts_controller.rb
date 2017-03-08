class V1::AccountsController < ApplicationController
  def show
    render json: UserSerializer.new.(account)
  end

  private

  def id
    params[:id]
  end

  def account
    User.find(id)
  end
end
