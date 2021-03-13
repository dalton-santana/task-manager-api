class Api::TasksController < ApplicationController
    before_action :authenticate_with_token!

    def index
        tasks = current_user.tasks
        render json: { tasks }, status: 200
    end

    def show
        task = current_user.tasks.find(params[:id])
        render json: task, status: 200
    end
end
