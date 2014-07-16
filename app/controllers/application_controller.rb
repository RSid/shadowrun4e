class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  protected

  def render_unauthorized
    respond_to do |format|
      format.html do
        redirect :back, notice: "Unauthorized"
      end

      format.json do
        render json: { errors: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end
