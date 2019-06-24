# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/players', to: 'players#list'
# get '/players/list', to: 'players#list' was the default generation, keeping it
# to think about later
