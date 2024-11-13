class DirectorsController < ApplicationController
  def update

    # Get the ID out of params
    d_id = params.fetch("the_id")

    # Look up the existing record
    matching_records = Director.where({ :id => d_id })

    the_director = matching_records.at(0)

    # Overwrite each column with the values from user inputs
    the_director.name = params.fetch("director_name")

    the_director.dob = params.fetch("director_dob")

    the_director.bio = params.fetch("director_bio")

    the_director.image = params.fetch("director_image")
    # Save

    the_director.save

    # Redirect to the movie details page
    redirect_to("/directors/#{the_director.id}")
  end

  def new_director
    @director_name = params.fetch("director_name")
    @director_dob = params.fetch("director_dob")
    @director_bio = params.fetch("director_bio")
    @director_image = params.fetch("director_image")

    director_n = Director.new
    director_n.name = @director_name
    director_n.dob = @director_dob
    director_n.bio = @director_bio
    director_n.image = @director_image

    director_n.save

    redirect_to("/directors")
  end

  def destroy

    the_id = params.fetch("an_id")

    matching_records = Director.where({ :id => the_id })

    the_director = matching_records.at(0)

    the_director.destroy

    redirect_to("/directors")
  end
  
  
  
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
end
