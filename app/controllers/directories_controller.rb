class DirectoriesController < ApplicationController

  expose(:directory, :attributes => :directory_params)
  expose(:directory_decorate) {
    DirectoryDecorator.new(directory)
  }

  def new; end

  def create
    if directory.save
      redirect_to directory_decorate.url
    else
      render :new
    end
  end

  private

  def directory_params
    params.require(:directory).permit(:name)
  end

end
