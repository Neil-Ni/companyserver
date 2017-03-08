class V1::Companies::Teams::WorkersController < V1::Companies::Teams::BaseController
  def index
    render json: {
      company_uuid: company.id,
      team_uuid:    team.id,
      workers:      workers.map { |t| UserSerializer.new.(t) }
    }
  end

  def show
    render json: UserSerializer.new.(worker)
  end

  private

  def workers
    team.users
  end

  def worker
    users.find(id)
  end

  def id
    params[:id]
  end
end
