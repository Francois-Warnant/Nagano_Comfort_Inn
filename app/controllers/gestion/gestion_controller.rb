module Gestion
	class GestionController < ApplicationController
		def current_ability
			
			@current_ability ||= GestionAbility.new(current_user)#GestionAbility.new(current_user)
		end
	end
end	