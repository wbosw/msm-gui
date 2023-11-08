class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create
    #open a new actor
    new_actor = Actor.new
    # input traits
    new_actor.name = params.fetch("the_name")
    new_actor.dob = params.fetch("the_dob")
    new_actor.bio = params.fetch("the_bio")
    new_actor.image = params.fetch("the_image")
    #save
    new_actor.save
    #redirect
    redirect_to("/actors")
  end

  def destroy
    #pick which actor to delete
    actor_id = params.fetch("an_id")
    #pull recort
    the_actor = Actor.all.where(:id => actor_id).at(0)
    #destroy
    the_actor.destroy
    #redirect
    redirect_to("/actors")
  end


end
