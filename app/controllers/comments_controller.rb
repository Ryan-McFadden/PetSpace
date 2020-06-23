class CommentsController < ApplicationController
    before_action :redirect_if_not_logged_in

    def index
        if params[:pet_id]
            if @pet = Pet.find_by(id: params[:pet_id])
                @comments = @pet.comments
            else
                flash[:notice] = "that pet doesn't exist"
                @comments = Comment.all
            end
        end
    end

    def new
        if params[:pet_id]
            if @pet = Pet.find_by(id: params[:pet_id])
                @comment = @pet.comments.build
            else
                flash[:notice] = "that pet doesn't exist"
                @comment = Comment.new
            end
        end
    end

    def create
        @comment = current_user.comments.build(comment_params)

        if @comment.save
            redirect_to pet_path(@comment.pet)
        else
            render :new
        end
    end

    def show
        @comment = Comment.find_by(id: params[:id])
    end

    def edit
        @comment = Comment.find_by(id: params[:id])
    end

    def update
        @comment = Comment.find_by(id: params[:id])

        if @comment.update(comment_params)
            redirect_to comment_path(@comment)
        else
            render :edit
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :pet_id)
    end
end
