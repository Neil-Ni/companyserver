class WhoamiController < ApplicationController
  def index
    render json: {
      support:   false,
      user_uuid: user.id,
      worker: {
        user_uuid: user.id,
        teams: user.working_teams.map { |t| TeamSerializer.new.(t) }
      },
      admin: {
        user_uuid: user.id,
        companies: user.admin_companies.map { |t| CompanySerializer.new.(t) }
      }
    }
  end
end
