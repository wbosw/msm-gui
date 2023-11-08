class DirectorsController < ApplicationController
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

  def create
    #Create new director
    new_d = Director.new
    #Grab the params
    new_d.name = params.fetch("the_name")
    new_d.dob = params.fetch("the_dob")
    new_d.bio = params.fetch("the_bio")
    new_d.image = params.fetch("the_image")
    #save
    new_d.save
    #redirect
    redirect_to("/directors")
  end

  def destroy
  #define the director
  the_d = params.fetch("an_id")
  # find the record
  to_destroy = Director.all.where({ :id => the_d}).at(0)
  #destroy
  to_destroy.destroy
  #redirect
    redirect_to("/directors")
  end

  def update
    #who are they trying to update
    the_d = params.fetch("an_id")

    the_update = Director.all.where(:id => the_d).at(0)
    #grab new data
    the_update.name = params.fetch("the_name")

    #save
    the_update.save
    #redirect
    redirect_to("/directors/#{the_d}")
    
  end

end
