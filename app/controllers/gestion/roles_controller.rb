module Gestion
	class RolesController < Gestion::GestionController
	  load_and_authorize_resource

	end
end