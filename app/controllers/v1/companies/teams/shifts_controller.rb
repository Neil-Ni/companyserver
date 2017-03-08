class V1::Companies::Teams::ShiftsController < V1::Companies::Teams::BaseController
  def index
    render json: {
      shifts: shifts.map { |t| ShiftSerializer.new.(t) }
    }
  end

  def show
    render json: ShiftSerializer.new.(job)
  end

  private

  def shifts
    team.shifts
  end

  def job
    shifts.find(id)
  end

  def id
    params[:id]
  end
end
