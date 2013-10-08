class MainController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    UserLogJob.new.async.perform
  end
end
