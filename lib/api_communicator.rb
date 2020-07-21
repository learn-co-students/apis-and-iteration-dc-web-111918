require 'rest-client'
require 'json'
require 'pry'

def get_character_movies(character)
  response_hash = get_character_movies_from_api(character)
  response_hash["results"].map do |hash|
    # binding.pry
    if hash["name"] == character
      return hash["films"]
    end
  end
end

def get_film_info(character)
  get_character_movies(character).map do |film|
    film_name_response_string = RestClient.get(film)
    film_name_response_hash = JSON.parse(film_name_response_string)
  end
end

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
#binding.pry


  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end





def show_character_movies(character)
  get_film_info(character).each do |hash|
    puts hash["title"] 
  end
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
