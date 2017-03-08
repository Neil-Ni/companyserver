class V1::Companies::DirectoryController < V1::Companies::BaseController
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

  private

  def users
    company.users
  end

  def user
    users.find(params[:id])
  end
end
