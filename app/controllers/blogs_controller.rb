class BlogsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit,:update, :destroy]
  before_action :correct_user, only: :destroy

  def new
    @blog = Blog.new
  end
  
  def create
    @blog = current_user.blogs.build(blog_params)
    tag_list = params[:blog][:tag_ids].split(',').uniq
    
    delete_tags = [" ","　"]
    tag_list.delete_if do |str|
      delete_tags.include?(str)
    end

    if @blog.save
      @blog.save_tags(tag_list)
      flash[:success] = "記事 「#{@blog.title}」 を投稿しました"
      redirect_to @blog
    else
      render "new"
      flash.now[:alert] = "投稿に失敗しました"  
    end
  end

  def edit
    @blog = Blog.find(params[:id])
    @tag_list = @blog.tags.pluck(:name).join(",")
  end

  def update
    @blog = Blog.find(params[:id])
    tag_list = params[:blog][:tag_ids].split(',').uniq
    if @blog.update(blog_params)
      @blog.save_tags(tag_list)
      redirect_to blog_path
    else
      render "edit"
    end
  end

  def show
    @blog = Blog.find_by(id: params[:id])
    @like = Like.new
  end
  

  def index
    # @blogs = Blog.all.paginate(page: params[:page]) 
    #Blog.search(params[:search]).paginate(page: params[:page])

      # unless (params[:tag_id] and params[:search]).present?
      #   Blog.all.paginate(page: params[:page])
      # elsif params[:tag_id].present?
      #   Tag.find(params[:tag_id]).blogs.paginate(page: params[:page])
      # elsif params[:search].present?
      #   Blog.search(params[:search]).blogs.paginate(page: params[:page])
      # end
     @blogs = 
      if params[:tag_id].present?
        Tag.find(params[:tag_id]).blogs.paginate(page: params[:page])
      else
        if params[:search].present?
          Blog.search(params[:search]).paginate(page: params[:page])
        else
        Blog.all.paginate(page: params[:page])
        end 
      end



    #@blogs = params[:tag_id].present? ? Tag.find(params[:tag_id]).blogs.paginate(page: params[:page]) : Blog.all.paginate(page: params[:page])
    
  end

  def destroy
    @blog.destroy
    flash[:success] = "記事 「#{@blog.title}」 を削除しました"
    redirect_to root_url
  end



  private
  
  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  def correct_user
   @blog = current_user.blogs.find_by(id: params[:id])
   redirect_to root_url if @blog.nil?
  end

end