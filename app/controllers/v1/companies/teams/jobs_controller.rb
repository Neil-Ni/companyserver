class V1::Companies::Teams::JobsController < V1::Companies::Teams::BaseController
  def index
    render json: {
      jobs: jobs.map { |t| JobSerializer.new.(t) }
    }
  end

  def show
    render json: JobSerializer.new.(job)
  end

  private

  def jobs
    team.jobs
  end

  def job
    jobs.find(id)
  end

  def id
    params[:id]
  end
end
