class CommentsController < ApplicationController
  before_action :require_user
    def create
      @recipe = Recipe.find(params[:recipe_id])
      @comment = @recipe.comments.build(comment_prams)
      @comment.chef = current_chef
      if @comment.save
        ActionCable.server.broadcast "comments", render(partial: 'comments/comment', object: @comment)
        #flash[:success] = "Comment was created successfully"
        #redirect_to recipe_path(@recipe)

      else
        flash[:danger] = "comment was not created"
        render(partial: 'comments/comment', object: @comment)
      end
    end
    private
    def comment_prams
      params.require(:comment).permit(:description)

    end
end
