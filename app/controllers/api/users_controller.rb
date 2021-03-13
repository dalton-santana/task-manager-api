class Api::UsersController < ApplicationController

    def show
        begin
            @user = User.find(params[:id])
            respond_with @user
        rescue
            head 404
        end
    end

end
