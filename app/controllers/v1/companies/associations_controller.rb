class V1::Companies::AssociationsController < V1::Companies::BaseController
  def index
    render json: {
      accounts: accounts,
      limit: 20,
      offset: 0
    }
  end

  def show
    render json: UserSerializer.new.(team)
  end

  private

  def accounts
    users.map do |u|
      {
        account: UserSerializer.new.(u),
        teams: u.working_teams.map { |t| TeamSerializer.new.(t) },
        admin: admins.exists?(user: u)
      }
    end
  end

  def admins
    @admins ||= company.admins
  end

  def users
    @users ||= company.users.joins(:working_teams)
  end

  def user
    users.find(params[:id])
  end
end
