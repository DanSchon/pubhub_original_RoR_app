class RelationshipsController < ApplicationController
  def index
    @relationships = current_user.following_relationships
  end
  def create
    leader = User.find(params[:leader_id])
    Relationship.create(leader_id: params[:leader_id], follower: current_user) unless current_user.already_follows?(leader) || current_user == leader
    redirect_to following_path
  end
end