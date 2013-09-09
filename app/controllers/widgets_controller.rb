class WidgetsController < ApplicationController
  
  expose(:widgets)
  expose(:widget, attributes: :widget_params)
  
  def create
    success = widget.save && widget.errors.none?
    # status = if success then :success else :unprocessable_entity end
    if success
      render locals: { success: success }, status: :success
    else
      render locals: { success: success }, status: :unprocessable_entity
    end
  end
  
  private
  
  def widget_params
    params.require(:widget).permit(:name, :description)
  end
  
end
