require './config/environment'
require 'plezi'

class Controller
  def index
    'Hello from Plezi!'
  end
end

Plezi.route '/plezi', Controller

app = proc { |_env| [200, { 'Content-Length' => '11' }, ['Hello Rack!']] }

use Plezi
run Hanami.app
