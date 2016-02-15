class PubsController < ApplicationController
  def index
    @pubs = Pub.all
  end
  def new
  end
  def create
  end
end