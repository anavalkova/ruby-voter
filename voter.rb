require 'sinatra'
require 'yaml/store'

get '/' do
  @title = "Машина за гласуване"
  erb :index
end

get '/cast' do
  @title = 'Благодарим за вашия глас!'
  @vote  = params['vote']

  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    if @store['votes'] == nil
      @store['votes'] = {}
    end

    @store['votes'][@vote] = @store['votes'].fetch(@vote, 0) + 1
  end

  erb :cast
end

get '/results' do
  @title = 'Резултати'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end


