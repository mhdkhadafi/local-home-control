class TvController < ApplicationController
	def power
		system("irsend SEND_ONCE tv KEY_POWER")
		render plain: "Success"
	end
end
