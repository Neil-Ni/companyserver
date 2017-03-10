class V1::Companies::DirectoryController < V1::Companies::BaseController
  before_action :pre_process_params, only: [:create, :update]

  wrap_parameters User

  def index
    render json: {
      accounts: company.users.map { |t| UserSerializer.new.(t) },
      limit: 20,
      offset: 0
    }
  end

  def show
    render json: UserSerializer.new.(user)
  end

  def create
    user = users.create!(create_params.merge(last_name: ''))

    company.teams.each do |team|
      team.workers.create!(user: user)
    end

    render json: UserSerializer.new.(user)
  end

  def update
    user.update!(update_params)

    render json: UserSerializer.new.(user)
  end

  private

  def users
    company.users
  end

  def user
    users.find(params[:id])
  end

  def pre_process_params
    params[:user].tap do |s|
      s[:first_name]  = params[:name] if params.key?(:name)
      s[:email]       = params[:email] if params.key?(:email)
      s[:phonenumber] = params[:phonenumber] if params.key?(:phonenumber)
    end
  end

  def create_params
    params.require(:user).permit(:first_name, :email, :phonenumber).to_h
  end

  def update_params
    params.require(:user).permit(:first_name, :email, :phonenumber).to_h
  end
end
