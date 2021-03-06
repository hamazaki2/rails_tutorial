class BlogsController < ApplicationController
  def index
    if params[:keyword].present? || params[:from].present? || params[:to].present?
      @blogs = Blog.search_blogs(params[:keyword], params[:from], params[:to])
    end
    @blogs = Blog.all.order(created_at: "DESC") if @blogs.nil?
    @pagy, @blogs = pagy(@blogs)
  end

  def new
   @blog = Blog.new
  end

  def create
   @blog = Blog.new(blog_params)
   if @blog.save
    redirect_to action: :show, id: @blog.id
    flash[:success] = "記事の投稿に成功しました"
   else
    flash[:danger] = "記事の投稿に失敗しました"
    render :new
   end
  end

  def show
   @blog = Blog.find(params[:id])
   @comments = Comment.where(blog_id: params[:id])
   @comment = @comments.build
  end

  def edit
   @blog = Blog.find(params[:id])
  end

  def update
   @blog = Blog.find(params[:id])
   if @blog.update_attributes(blog_params)
    flash[:success] = "記事の更新に成功しました"
    redirect_to action: :show, id: @blog.id
   else
    flash[:danger] = "記事の更新に失敗しました"
    render :edit
   end
  end

  def destroy
   Blog.find(params[:id]).destroy
   flash[:success] = "記事を削除しました"
   redirect_to blogs_path
  end
  

   private

   def blog_params
    params.require(:blog).permit(:id,:title,:content)
   end

end