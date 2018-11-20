require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  x = 'http://www.swapi.co/api/people/'
  response_string = RestClient.get(x)
  response_hash = JSON.parse(response_string)

  film_urls = []
  #REFACTOR with collect instead of each
  response_hash["results"].each do |characteristics|
    characteristics.each do |categories, values|
      #response_hash["results"][0]["name"] = "Luke Skywalker"
      if character_name == characteristics["name"].downcase #&& categories == response_hash["results"][0]["films"]
        film_urls = characteristics["films"]
      end
    end
  end
  film_urls
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  url_array = []
  film_urls.each do |url|
    x = RestClient.get(url)
    url_hash = JSON.parse(x)
    url_array << url_hash
  end
  url_array
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each do |movie_details|
    puts movie_details["title"]
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
