class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index]

  def home
  end

  def index
    @communities = policy_scope(Community).limit(5)
  end
end
