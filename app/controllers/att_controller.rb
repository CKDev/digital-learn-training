class AttController < ApplicationController
  skip_before_action :authenticate_user!, only: [:login]

  def login
  end
end
