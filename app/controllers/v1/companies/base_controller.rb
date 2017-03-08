class V1::Companies::BaseController < ApplicationController
  private

  def company
    Company.find(company_id)
  end

  def company_id
    params[:company_id]
  end
end
