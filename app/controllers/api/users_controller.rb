class Api::UsersController < ApplicationController
    before_action :authenticate_with_token!, only: [:show, :update, :destroy]
    respond_to :json

    def show
        begin
            if current_user.id.to_i == params[:id].to_i
                respond_with current_user
            else
                head 401
            end
        rescue
            head 404
        end
    end
    def create
        begin
            user = User.new(user_params)
            
            if user.save
                render json: user, status: 201
            else
                render json: { errors: user.errors }, status: 422
            end
        rescue
            head 404
        end
    end
    def update
        user = current_user
        if current_user.id.to_i == params[:id].to_i
            if user.update(user_params)
                render json: user, status: 200
            else
                render json: { errors: user.errors }, status: 422
            end
        else
            head 401
        end
    end
    def destroy
        current_user.destroy
       
        head 204
    end
    
    private
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
