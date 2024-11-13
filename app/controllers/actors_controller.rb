class ActorsController < ApplicationController
  def update

    # Get the ID out of params
    a_id = params.fetch("the_id")

    # Look up the existing record
    matching_records = Actor.where({ :id => a_id })

    the_actor = matching_records.at(0)

    # Overwrite each column with the values from user inputs
    the_actor.name = params.fetch("actor_name")

    the_actor.dob = params.fetch("actor_dob")

    the_actor.bio = params.fetch("actor_bio")

    the_actor.image = params.fetch("actor_image")
    # Save

    the_actor.save

    # Redirect to the movie details page
    redirect_to("/ators/#{the_actor.id}")
  end

  def create
    @actor_name = params.fetch("actor_name")
    @actor_dob = params.fetch("actor_dob")
    @actor_bio = params.fetch("actor_bio")
    @actor_image = params.fetch("actor_image")

    actor_n = Actor.new
    actor_n.name = @actor_name
    actor_n.dob = @actor_dob
    actor_n.bio = @actor_bio
    actor_n.image = @actor_image

    actor_n.save

    redirect_to("/actors")
  end

  def destroy

    the_id = params.fetch("an_id")

    matching_records = Actor.where({ :id => the_id })

    the_actor = matching_records.at(0)

    the_actor.destroy

    redirect_to("/actors")
  end
  
  
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
end
