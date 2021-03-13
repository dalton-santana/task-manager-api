class Api::SessionsController < ApplicationController
    def create
        user = user.find_by(email: session_params[:email])

        if user && user.valid_password?(session_params[:password])
            sign_in user, store: false
            user.generate_authentication_token!
            user.save
            render json: user, status: 200
        else
            render json: { erros: 'Invalid password or email' }, status: 401
        end
    end

    private
    
    def session_params
        params.require(:session).permit(:email, :password)
    end
end
