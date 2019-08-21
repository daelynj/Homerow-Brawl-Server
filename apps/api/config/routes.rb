# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/rooms', to: 'rooms#index'
post '/rooms', to: 'rooms#create'
delete '/rooms/:id', to: 'rooms#destroy'
get '/rooms/:id', to: 'rooms#show'
post '/slack/oauth', to: 'slack#oauth'
get '/players_rooms', to: 'players_rooms#show'
