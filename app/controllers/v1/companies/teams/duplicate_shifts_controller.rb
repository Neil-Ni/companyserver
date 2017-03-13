class V1::Companies::Teams::DuplicateShiftsController < V1::Companies::Teams::BaseController
  before_action :pre_process_params, only: :create

  wrap_parameters Shift

  def create
    create_new_shifts!
    new_shift_start_after = DateTime.strptime(after) + 1.week
    new_shift_start_before = DateTime.strptime(before) + 1.week
    render json: {
      shifts: team.shifts.where('start >= ? and stop <= ?', new_shift_start_after, new_shift_start_before),
      shift_start_after: new_shift_start_after,
      new_shift_start_before: new_shift_start_before,
    }
  end

  private

  def create_new_shifts!
    Shift.bulk_insert do |worker|
      current_shifts.each do |shift|
        worker.add(
          published: shift.published,
          start:     shift.start + 7.days,
          stop:      shift.stop + 7.days,
          team_id:   shift.team_id,
          job_id:    shift.job_id,
          user_id:   shift.user_id,
        )
      end
    end
  end

  def current_shifts
    team.shifts.where('start >= ? and stop <= ?', after, before)
  end

  def after
    params[:shift_start_after]
  end

  def before
    params[:shift_start_before]
  end

  def pre_process_params
    params[:shift].tap do |s|
      s[:shift_start_after] = params[:shift_start_after] if params.key?(:shift_start_after)
      s[:shift_start_before]  = params[:shift_start_before] if params.key?(:shift_start_before)
    end
  end

  def create_params
    params.require(:shift).permit(
      :shift_start_after,
      :shift_start_before
    ).to_h
  end
end
