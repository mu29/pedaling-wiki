require './app/application'
require_relative './app/controllers/users_controller'
require_relative './app/controllers/wikis_controller'

use UsersController
use WikisController
use RepliesController
run PedalingWiki
