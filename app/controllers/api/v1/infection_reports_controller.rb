class Api::V1::InfectionReportsController < ApplicationController
  def create
    @report=InfectionReport.new(report_params)
    if @report.save
      render json: {success: true, message: "Infection successfully saved."}
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  private
  
  def report_params
    params.require(:report).permit(:reporter_id, :survivor_id )
  end
end
  