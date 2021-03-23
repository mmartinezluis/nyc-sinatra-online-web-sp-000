require 'pry'
class FiguresController < ApplicationController
  # add controller methods
  get '/figures' do
    @figures= Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles= Title.all
    @landmarks= Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    @figure= Figure.create(:name => params[:figure][:name])

    if !params[:title][:name].empty?
      @figure.titles << Title.create(:name => params[:title][:name])
    else
      @figure.title_ids= params[:figure][:title_ids]
    end

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    else
      @figure.landmark_ids= params[:figure][:landmark_ids]
    end

    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    
    @figure= Figure.find(params[:id])
    @titles= Title.all
    @landmarks= Landmark.all
    erb :'figures/edit'
  end

  get '/figures/:id' do
    @figure= Figure.find(params[:id])
    erb :'figures/show'
  end

  patch '/figures/:id' do
    @figure= Figure.find(params[:id])
    @figure.name = params[:figure][:name]

    #@figure.titles.clear
    if !params[:title][:name].empty?
      @figure.titles << Title.create(:name => params[:title][:name])
    else
      @figure.title_ids= params[:figure][:title_ids]
    end

    #@figure.landmarks.clear
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    else
      @figure.landmark_ids= params[:figure][:landmark_ids]
    end

    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  
end
