class V1::Companies::Teams::ShiftsController < V1::Companies::Teams::BaseController
  before_action :pre_process_params, only: [:update, :create]

  wrap_parameters Shift

  def index
    render json: {
      shifts: shifts.where('start >= ? and stop <= ?', after, before).map { |t| ShiftSerializer.new.(t) },
      shift_start_after: after,
      shift_start_before: before
    }
  end

  def show
    render json: ShiftSerializer.new.(shift)
  end

  def create
    shift = shifts.create!(create_params)
    render json: ShiftSerializer.new.(shift)
  end

  def update
    shift.update!(update_params)
    render json: ShiftSerializer.new.(shift)
  end

  def destroy
    shift.destroy!
    render json: {}
  end

  private

  def shifts
    team.shifts
  end

  def after
    params[:shift_start_after]
  end

  def before
    params[:shift_start_before]
  end

  def shift
    shifts.find(id)
  end

  def id
    params[:id]
  end

  def pre_process_params
    params[:shift].tap do |s|
      s[:user_id] = params[:user_uuid] if params.key?(:user_uuid)
      s[:job_id]  = params[:job_uuid] if params.key?(:job_uuid)
    end
  end

  def create_params
    params.require(:shift).permit(
      :published,
      :start,
      :stop,
      :user_id,
      :job_id
    ).to_h
  end

  def update_params
    params.require(:shift).permit(
      :job_id,
      :published,
      :start,
      :stop,
      :user_id
    ).to_h
  end
end
