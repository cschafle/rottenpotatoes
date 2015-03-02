# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(:title => movie['title'], :rating => movie['rating'], :release_date => movie['release_date'], :director => movie['director']) 
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #result = page.body[/<([^>]*)>/)]
  elem1 = page.body.index(e1)
  elem2 = page.body.index(e2)
  assert(elem1<elem2)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(", ")
  if (uncheck == "un") 
    ratings.each { |rating| step "I uncheck \"ratings[#{rating}]\"" }
  else 
    ratings.each { |rating| step "I check \"ratings[#{rating}]\""}   #{}"When I check #{rating}
  end 
end


Then /I should not see the following movies with ratings:(.*)/ do |rating_list|
  ratings = rating_list.split(", ")
  all_movies = Movie.all
  #go through list of ratings and make sure the movies they are associated with are NOT there
     #Then /^(?:|I )should see "([^"]*)"$/ do |text|
   ratings.each { |rating|
    all_movies.each { |movie|
      if (movie.rating == rating)
         step "I should not see \"#{movie.title}\""
      end 
    }
  } 
end

Then /I should see the following movies with ratings:(.*)/ do |rating_list|
  ratings = rating_list.split(", ")
  all_movies = Movie.all
  #go through list of ratings and make sure the movies they are associated with are NOT there
     #Then /^(?:|I )should see "([^"]*)"$/ do |text|
   ratings.each { |rating|
    all_movies.each { |movie|
      if (movie.rating == rating)
         step "I should see \"#{movie.title}\""
      end 
    }
  } 
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  all_movies = Movie.all
  all_movies.each {|movie| step "I should see \"#{movie.title}\"" }      #{}"Then I should see the #{movie.title}"} 
end


Then /the director of "(.*)" should be "(.*)"/ do |m1, d1|
  #Affirm that movie has correct director
  assert(Movie.exists?(title: m1, director: d1))
end
