class V1::Companies::Teams::JobsController < V1::Companies::Teams::BaseController
  wrap_parameters Job

  def index
    render json: {
      jobs: jobs.map { |t| JobSerializer.new.(t) }
    }
  end

  def show
    render json: JobSerializer.new.(job)
  end

  def create
    job = jobs.create!(create_params)
    render json: JobSerializer.new.(job)
  end

  def update
    job.update!(update_params)
    job.shifts.destroy_all if update_params[:archived]
    render json: JobSerializer.new.(job)
  end

  def destroy
    job.destroy!
    render json: {}
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

  def create_params
    params.require(:job).permit(:name, :color).to_h
  end

  def update_params
    params.require(:job).permit(:name, :color, :archived).to_h
  end
end
