class WhoamiController < ApplicationController
  def index
    render json: {
      support:   false,
      user_uuid: current_user.id.to_s,
      worker: {
        user_uuid: current_user.id.to_s,
        teams: current_user.working_teams.map { |t| TeamSerializer.new.(t) }
      },
      admin: {
        user_uuid: current_user.id.to_s,
        companies: current_user.admin_companies.map { |t| CompanySerializer.new.(t) }
      }
    }
  end

  def show
    render json: {}
  end
end
