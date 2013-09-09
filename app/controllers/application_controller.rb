class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  rescue_from ActionController::ParameterMissing, with: :parameters_missing
  
  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end
  
  private
  
  def parameters_missing
    respond_to do |wants|
      wants.json { render json: { success: false, error: 'Required parameters missing', status: 'bad request', code: 400 }, status: :bad_request }
    end
  end

  
end
