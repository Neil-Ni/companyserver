class V1::CompaniesController < ApplicationController
  def show
    render json: CompanySerializer.new.(company)
  end

  private

  def id
    params[:id]
  end

  def company
    Company.find(id)
  end
end
