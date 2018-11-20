require'rest-client'
require 'json'
require 'pry'

# JSON.parse(character_data)

def get_character_movies_from_api(character)
x = 'http://www.swapi.co/api/people/'
  #make the web request COMPARABLE TO GET_SEARCH_TERMS
  response_string = RestClient.get(x)

  response_hash = JSON.parse(response_string)
  films = nil
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`

  response_hash["results"].each do |element|

    if element["name"].downcase ==  character
      films = element["films"]
    end
  end
  return films

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film

  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film

  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each do |film|

  response = RestClient.get(film)
  puts JSON.parse(response.body)["title"]
end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
