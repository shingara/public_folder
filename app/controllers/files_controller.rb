class FilesController < ApplicationController

  expose(:file, :attributes => :file_params, :model => :node)
  expose(:file_decorate) {
    FileDecorator.new(file)
  }

  def new
    file.dirname = params[:dirname] || ''
  end

  def create
    if file.save
      redirect_to file_decorate.url
    else
      render :new
    end
  end

  private

  def file_params
    params.require(:file).permit(:content, :dirname)
  end

end
