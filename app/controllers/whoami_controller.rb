class WhoamiController < ApplicationController
  def index
    render json: {
      support:   false,
      user_uuid: current_user.id,
      worker: {
        user_uuid: current_user.id,
        teams: current_user.working_teams.map { |t| TeamSerializer.new.(t) }
      },
      admin: {
        user_uuid: current_user.id,
        companies: current_user.admin_companies.map { |t| CompanySerializer.new.(t) }
      }
    }
  end

  def show
    render json: {}
  end
end
