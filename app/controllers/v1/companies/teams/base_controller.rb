class V1::Companies::Teams::BaseController < V1::Companies::BaseController
  private

  def team
    company.teams.find(team_id)
  end

  def team_id
    params[:team_id]
  end
end
