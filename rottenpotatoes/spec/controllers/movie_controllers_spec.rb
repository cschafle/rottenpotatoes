require 'spec_helper'
require 'movies_controller'

describe MoviesController do
  # helper function:
  describe '#similar_movies' do
    it 'should display Star Wars' do
      #m = mock('Movie',:title=>'Rambo',:director => 'nil', :id => '1')
      m2 = mock('Movie', :title => 'Star Wars',:director => 'bob', :id => '2')
      Movie.should_receive(:find).with('2').and_return(m2)
      Movie.should_receive(:find_all_by_director).with('bob')
      get :similar_movies, {:id => '2'}
    end 
  end
  describe 'correct information' do
    it 'movie title should be Star Wars' do
      m = mock('Movie',:title=>'Rambo', :director => nil, :id => '1')
      m2 = mock('Movie', :title => 'Star Wars',:director => 'bob', :id => '2')
      m2.title.should == 'Star Wars'
      m2.director.should == 'bob'
      m.director.should be_nil
    end 
  end
  describe '#similar_movies' do
    it 'should redirect to home page' do
      m = mock('Movie',:title=>'Rambo', :director => nil, :id => '1')
      Movie.should_receive(:find).with('1').and_return(m)
      Movie.should_receive(:find_all_by_director).with(nil)
      get :similar_movies, {:id => '1'}
      response.should redirect_to(movies_path)
    end
  end
  describe '#destroy' do
    it 'should delete movie' do
      m = mock('Movie',:title=>'Rambo', :director => nil, :id => '1')
      #Movie.should_receive(:destroy).with('1').and_return(m)
      Movie.should_receive(:find).with('1').and_return(m)
      m.should_receive(:destroy)
      delete :destroy, {:id => '1'}
      response.should redirect_to(movies_path)
    end
  end
  describe '#create' do
    it 'should create a movie' do
      m = mock('Movie')
      m.stub!(:title)
      #Movie.should_receive(:destroy).with('1').and_return(m)
      Movie.should_receive(:create!).and_return(m)
      post :create, {:movie => m}
      response.should redirect_to(movies_path)
    end
  end
end
