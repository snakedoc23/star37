class LinksController < ApplicationController

	def index
		@links = Link.all
		@link = Link.new
	end

	def create

		@link = Link.new params[:link]
		if @link.save
			redirect_to links_path
		else
			@links = Link.all
			render 'index'
		end
	end

end
