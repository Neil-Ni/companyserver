class V1::Companies::Teams::WorkersController < V1::Companies::Teams::BaseController
  before_action :pre_process_params, only: [:create]

  wrap_parameters Worker

  def index
    render json: {
      company_uuid: company.id.to_s,
      team_uuid:    team.id.to_s,
      workers:      workers.map { |t| UserSerializer.new.(t) }
    }
  end

  def show
    render json: UserSerializer.new.(worker)
  end

  def create
    user = company.users.find(create_params[:user_id])
    team.workers.create!(user: user)
    render json: UserSerializer.new.(user)
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

  def pre_process_params
    params[:worker].tap do |s|
      s[:user_id] = params[:user_uuid] if params.key?(:user_uuid)
    end
  end

  def create_params
    params.require(:worker).permit(:user_id).to_h
  end
end
