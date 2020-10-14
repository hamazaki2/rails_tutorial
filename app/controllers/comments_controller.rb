class CommentsController < ApplicationController

 def create
  blog = Blog.find(params[:blog_id])
  @comment = blog.comments.build(comment_params)
  @comment.user_id = current_user.id
  if @comment.save
   flash[:success] = "コメントを投稿しました"
   redirect_back(fallback_location: root_path)
  else
   flash[:danger] = "コメントを投稿できませんでした"
   redirect_back(fallback_location: root_path)
  end
 end

  private

   def comment_params
    params.require(:comment).permit(:content)
   end
end
