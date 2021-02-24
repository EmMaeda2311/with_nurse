class BlogsController < ApplicationController

  def blog_params
    params.require(:blog).permit(:title, :content)
  end
end
