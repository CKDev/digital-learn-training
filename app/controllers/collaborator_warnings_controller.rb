class CollaboratorWarningsController < ApplicationController
  def destroy
    session[:dismissed_collaborator_warning] = true
    redirect_back(fallback_location: root_path)
  end
end
