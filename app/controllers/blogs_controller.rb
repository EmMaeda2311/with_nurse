class BlogsController < ApplicationController
  # before_action :correct_user, only:[:create,:destroy,:show]


  def new
    @blog = Blog.new
  end
  
  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      flash[:success] = "あなたの看護を発信しました"
      redirect_to user_path(id: current_user.id)
    else
      render new_blog_path
      flash[:alert] = "投稿に失敗しました"  
    end
  end


  private
  
  def blog_params
    params.require(:blog).permit(:title, :content)
  end
end
