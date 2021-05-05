require "JsonAPI"

class HomeController < ApplicationController
  def index
    @article_votes = JsonAPI.new.freshdesk
  end
end
