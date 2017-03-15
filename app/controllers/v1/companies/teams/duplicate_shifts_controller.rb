class V1::Companies::Teams::DuplicateShiftsController < V1::Companies::Teams::BaseController
  before_action :pre_process_params, only: :create

  wrap_parameters Shift

  def create
    validate_time_range
    create_new_shifts!
    render json: {
      shifts: team_shifts.where('start >= ? and stop <= ?', after, before).map { |t| ShiftSerializer.new.(t) },
      shift_start_after: after,
      shift_start_before: before,
    }
  end

  private

  def validate_time_range
    return unless team_shifts.where('start >= ? and stop <= ?', after, before).any?
    raise ::Exceptions::UnprocessableEntity, 'Shifts exist in the specified range'
  end

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
    team_shifts.where(
      'start >= ? and stop <= ?',
      DateTime.strptime(after, '%Y-%m-%dT%H:%M:%S') - 1.week,
      DateTime.strptime(before, '%Y-%m-%dT%H:%M:%S') - 1.week
    )
  end

  def team_shifts
    @team_shifts ||= team.shifts
  end

  def after
    params[:start]
  end

  def before
    params[:stop]
  end

  def pre_process_params
    params[:shift].tap do |s|
      s[:start] = params[:start] if params.key?(:start)
      s[:stop]  = params[:stop] if params.key?(:stop)
    end
  end

  def create_params
    params.require(:shift).permit(
      :start,
      :stop
    ).to_h
  end
end
