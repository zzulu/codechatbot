class ApplicationController < ActionController::Base
  def user_root_path
    bots_path
  end
end
