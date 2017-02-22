require 'rack-flash'

class SongsController < ApplicationController

  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  post "/songs" do

    @song = Song.create(name: params[:song][:name])

    if !Artist.find_by(name: params[:artist][:name])
      @artist = Artist.create(params[:artist])
    else
      @artist = Artist.find_by(name: params[:artist][:name])
    end


    @song.artist = @artist
    @artist.songs << @song
    @genres = params[:song][:genre_id]

    @genres.each do |d|
      genre = Genre.find(d)
      genre.songs << @song
    end

    flash[:message] = "Successfully created song."
    redirect to("/songs/#{@song.slug}")
  end


  get '/songs/new' do
    erb :'/songs/new'
  end

  get "/songs/:slug/edit" do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/edit'
  end

  get "/songs/:slug" do

    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  post '/songs/:slug' do

    @song = Song.find_by_slug(params[:slug])

    genres = params[:genre][:id]

    genres.each do |d|
      @song.genres << Genre.find(d)
    end

    if !Artist.find_by(name: params[:artist][:name])
      @artist = Artist.create(params[:artist])
    else
      @artist = Artist.find_by(name: params[:artist][:name])
    end

    @song.artist = @artist
    @song.save

    flash[:message] = "Successfully updated song."
    redirect to("/songs/#{@song.slug}")

  end


end
