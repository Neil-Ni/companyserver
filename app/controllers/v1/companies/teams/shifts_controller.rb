class V1::Companies::Teams::ShiftsController < V1::Companies::Teams::BaseController
  wrap_parameters :shift, include: [
    :company_uuid,
    :job_uuid,
    :published,
    :start,
    :stop,
    :team_uuid,
    :user_uuid,
    :uuid
  ]

  def index
    render json: {
      shifts: shifts.map { |t| ShiftSerializer.new.(t) }
    }
  end

  def show
    render json: ShiftSerializer.new.(shift)
  end

  def update
    shift.update!(update_params)
    render json: ShiftSerializer.new.(shift)
  end

  private

  def shifts
    team.shifts
  end

  def shift
    shifts.find(id)
  end

  def id
    params[:id]
  end

  def update_params
    _params = params.require(:shift).permit(
      :company_uuid,
      :job_uuid,
      :published,
      :start,
      :stop,
      :team_uuid,
      :user_uuid,
      :uuid
    )

    _params.
      slice(:published, :start, :stop).
      merge(
        job_id: _params[:job_uuid],
        user_id: _params[:user_uuid]
      )
  end
end
