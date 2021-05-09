require "JsonAPI"

class HomeController < ApplicationController
  def index
    integrations = UsersIntegration.where(user_id: current_user.id)
    integrations.each do |integration|
      integ = integration.integration.name.capitalize
      @tickets = integ.constantize.new(integration).list
    end
  end
end
