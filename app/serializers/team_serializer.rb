class TeamSerializer
  def call(team)
    {
      uuid:            team.id,
      company_uuid:    team.company_id,
      name:            team.name,
      archived:        team.archived,
      timezone:        team.timezone,
      day_week_starts: team.day_week_starts,
      color:           team.color
    }
  end
end
