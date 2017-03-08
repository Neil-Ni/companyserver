class V1::Companies::TeamsController < V1::Companies::BaseController
  def index
    render json: {
      teams: teams.map { |t| TeamSerializer.new.(t) }
    }
  end

  def show
    render json: TeamSerializer.new.(team)
  end

  private

  def teams
    company.teams
  end

  def team
    company.teams.find(params[:id])
  end
end
