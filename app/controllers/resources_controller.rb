class ResourcesController < ApplicationController
  def create    
    selected_resources = params[:selected_resources] || []
    puts selected_resources
  end
end
