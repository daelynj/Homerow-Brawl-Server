# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/players', to: 'players#index'
get '/players/:id', to: 'players#show'
delete '/players', to: 'players#destroy'
post '/players', to: 'players#create'
get '/rooms', to: 'rooms#index'
post '/rooms', to: 'rooms#create'
delete '/rooms/:id', to: 'rooms#destroy'
