class CommentsController < ApplicationController
    def create
        @user = User.find_by_id(params[:user_id])
        @comment = Comment.new(comment_params)
        @comment.user_id = @user.id
        @comment.commenter_id = current_user.id

        if @comment.valid?
            @comment.save
        else
            flash[:notice] = "Comment cannot be blank."
        end 
        redirect_to user_path(@user)
    end

    private

    def comment_params
        params.require(:comment).permit(:content)
    end
end
