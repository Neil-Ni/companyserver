class TeamSerializer
  def call(team)
    {
      uuid:            team.id.to_s,
      company_uuid:    team.company_id.to_s,
      name:            team.name,
      archived:        team.archived,
      day_week_starts: team.day_week_starts,
      color:           team.color,
      timezone:        team.timezone
    }
  end
end
