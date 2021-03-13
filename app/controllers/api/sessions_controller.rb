class Api::SessionsController < ApplicationController
    def create
        user = User.find_by(email: session_params[:email])

        if user && user.valid_password?(session_params[:password])
            sign_in user, store: false
            user.generate_authentication_token!
            user.save
            render json: user, status: 200
        else
            render json: { erros: 'Email ou senha inválida' }, status: 401
        end
    end

    def destroy
        user = User.find_by(auth_token: params[:id])
        if user
            user.generate_authentication_token!
            user.save
            head 204
        else
            head 404
        end
    end

    private
    
    def session_params
        params.require(:session).permit(:email, :password)
    end
end
