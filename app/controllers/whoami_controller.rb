class WhoamiController < ApplicationController
  def index
    render json: WhoamiSerializer.new.(current_user)
  end
end
