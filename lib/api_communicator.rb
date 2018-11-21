require 'rest-client'
require 'json'
require 'pry'

def get_film_array(character_name)
  response_hash = get_character_movies_from_api(character_name)
  response_hash["results"].map do |array|
    if array["name"] == character_name
      return array["films"]
    end
  end
end

def get_films_info_collection(character_name)
  film_array = get_film_array(character_name)
  film_array.map do |film|
    film_name_response_string = RestClient.get(film)
    film_name_response_hash = JSON.parse(film_name_response_string)
  end
end


def get_character_movies_from_api(character_name)
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)


  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def show_character_movies(character_name)
  films = get_films_info_collection(character_name)
  films.each do |hash|
    hash.each do |attribute, value|
      if attribute == "title"
        puts value
      end
    end
  end
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
