class ShiftSerializer
  def call(shift)
    {
      uuid:         shift.id.to_s,
      company_uuid: shift.team.company_id.to_s,
      team_uuid:    shift.team_id.to_s,
      job_uuid:     shift.job_id.to_s,
      user_uuid:    shift.user_id.to_s,
      start:        shift.start,
      stop:         shift.stop,
      published:    shift.published
    }
  end
end
