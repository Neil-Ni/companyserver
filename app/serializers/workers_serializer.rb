class WorkerSerializer
  def call(job)
    {
      uuid:         job.id.to_s,
      company_uuid: job.team.company_id.to_s,
      team_uuid:    job.team_id.to_s,
      name:         job.name,
      archived:     job.archived,
      color:        job.color
    }
  end
end
