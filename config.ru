require './config/environment'
require 'plezi'

class Controller
  def index
    'Hello from Plezi!'
  end
end

Plezi.route '/plezi', Controller

use Plezi
run Hanami.app
