class CompanySerializer
  def call(company)
    {
      uuid:                    company.id.to_s,
      name:                    company.name,
      archived:                company.archived,
      default_timezone:        company.default_timezone,
      default_day_week_starts: company.default_day_week_starts
    }
  end
end
