class WorkerSerializer
  def call(job)
    {
      uuid:         job.id,
      company_uuid: job.team.company_id,
      team_uuid:    job.team_id,
      name:         job.name,
      archived:     job.archived,
      color:        job.color
    }
  end
end
