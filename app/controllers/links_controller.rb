class LinksController < ApplicationController

	def index
		@links = Link.search params[:search]
		@link = Link.new
	end

	def create

		@link = Link.new params[:link]
		if @link.save
			flash[:success] = "Yeah"
			redirect_to links_path
		else
			@links = Link.all
			flash[:error] = "Nope"
			render 'index'
		end
	end

	def edit
		@link = Link.find params[:id]
	end

	def update
		@link = Link.find params[:id]
		if @link.update_attributes params[:link]
			flash[:success] = "Yeah"
			redirect_to links_path
		else
			flash[:error] = "Nope"
			render 'edit'
		end
	end

  def destroy
    Link.find(params[:id]).destroy
    flash[:success] = "Link deleted"
    redirect_to links_path
  end

end
