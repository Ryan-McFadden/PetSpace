class PetsController < ApplicationController
    before_action :redirect_if_not_logged_in

    def index
        if params[:user_id]
            if @user = User.find_by(id: params[:user_id])
                @pets = @user.pets.alpha.most_comments
            else
                flash[:notice] = "that user doesn't exist"
            end
        else
            @pets = Pet.all.alpha.most_comments
        end
    end

    def new
        @pet = Pet.new
    end

    def create
        @pet = current_user.pets.build(pet_params)

        if @pet.save
            redirect_to pet_path(@pet)
        else
            render :new
        end
    end

    def show
        @pet = Pet.find_by(id: params[:id])
    end

    def edit
        @pet = Pet.find_by(id: params[:id])
    end

    def update
        @pet = Pet.find_by(id: params[:id])

        if @pet.update(pet_params)
            redirect_to pet_path(@pet)
        else
            render :edit
        end
    end

    private

    def pet_params
        params.require(:pet).permit(:name, :animal, :description)
    end
end
