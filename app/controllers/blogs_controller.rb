class BlogsController < ApplicationController
  def index
   @blogs = Blog.all.order(created_at: "DESC")
  end

  def new
   @blog = Blog.new
  end

  def create
   @blog = Blog.new(blog_params)
   if @blog.save
    redirect_to action: :show, id: @blog.id
    flash[:success] = "記事の登録に成功しました"
   else
    flash[:danger] = "記事の登録に失敗しました"
    render :new
   end
  end

  def show
    binding.pry
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
