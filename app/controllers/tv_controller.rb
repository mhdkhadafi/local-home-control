require 'uri'
require 'net/http'

class TvController < ApplicationController
	protect_from_forgery with: :null_session

	def power
		system("irsend SEND_ONCE tv KEY_POWER")
		render plain: "Success"
	end

	def james
		if request.get?
			state = get_current_state('james')
			render json: {state: state}
		elsif request.put?
			next_state = JSON.parse(request.body.read)['state']

			url = URI("http://192.168.1.165/api/#{ENV['HUE_TOKEN']}/lights/3/state")

			http = Net::HTTP.new(url.host, url.port)

			request = Net::HTTP::Put.new(url)
			request["content-type"] = 'application/json'
			request["cache-control"] = 'no-cache'
			request.body = "{\n\t\"on\": #{next_state}\n}"
		  	http.request(request)

		 	render json: {state: next_state}
		end
	end

	def jessica
		if request.get?
			state = get_current_state('jessica')
			render json: {state: state}
		elsif request.put?
			next_state = JSON.parse(request.body.read)['state']

			url = URI("http://192.168.1.165/api/#{ENV['HUE_TOKEN']}/lights/1/state")

			http = Net::HTTP.new(url.host, url.port)

			request = Net::HTTP::Put.new(url)
			request["content-type"] = 'application/json'
			request["cache-control"] = 'no-cache'
			request.body = "{\n\t\"on\": #{next_state}\n}"
		  	http.request(request)

		 	render json: {state: next_state}
		end
	end

	private
	def get_current_state(device)
		light_number = device == 'jessica' ? 1 : 3
		url = URI("http://192.168.1.165/api/#{ENV['HUE_TOKEN']}/lights/#{light_number}")

		http = Net::HTTP.new(url.host, url.port)

		request = Net::HTTP::Get.new(url)
		request["cache-control"] = 'no-cache'

		response = http.request(request)
		state = JSON.parse(response.body)["state"]["on"]

		return state
	end

end
