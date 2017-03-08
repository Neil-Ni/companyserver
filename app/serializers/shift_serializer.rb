class ShiftSerializer
  def call(shift)
    {
      uuid:         shift.id,
      company_uuid: shift.team.company_id,
      team_uuid:    shift.team_id,
      job_uuid:     shift.job_id,
      user_uuid:    shift.user_id,
      start:        shift.start,
      stop:         shift.stop,
      published:    shift.published
    }
  end
end
