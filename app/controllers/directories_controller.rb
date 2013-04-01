class DirectoriesController < ApplicationController

  expose(:directory, :attributes => :directory_params)
  expose(:directory_decorate) {
    DirectoryDecorator.new(directory)
  }

  def new
    directory.dirname = params[:dirname] || ''
  end

  def create
    if directory.save
      redirect_to directory_decorate.url
    else
      render :new
    end
  end

  private

  def directory_params
    params.require(:directory).permit(:name, :dirname)
  end

end
