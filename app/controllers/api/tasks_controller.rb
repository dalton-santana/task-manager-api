class Api::TasksController < ApplicationController
    before_action :authenticate_with_token!

    def index
        @tasks = TaskReduce.apply(params)
        render json: @tasks, status: 200
    end

    def show
        task = current_user.tasks.find(params[:id])
        render json: task, status: 200
    end

    def create
        task = current_user.tasks.build(task_params)
        
        if task.save
            render json: task, status: 201
        else
            render json: { errors: task.errors }, status: 422
        end
    end

    def update
        task = current_user.tasks.find(params[:id])

        if task.status
            render json: { errors: 'Erro! tarefa já concluída'}, status: 422
        else
            if task.update_attributes(task_params)
                render json: task, status: 200
            else
                render json: { errors: task.errors }, status: 422
            end
        end
    end

    def destroy
        task = current_user.tasks.find(params[:id])
        task.destroy

        head 204
    end

    # Responsável por retornar toas as tarefas públicas
    def all_public_tasks
        # Verifiação se existe um usuario logado
        if current_user
            # Filtro e tarefas somente visíveis (publicas)
            params[:is_visible] = true
            @tasks = TaskReduce.apply(params)

            render json: @tasks, status: 200
        else
            head 401
        end
    end

    private
    def task_params
        params.require(:task).permit(:title, :description, :status, :is_visible)
    end

    # Filtro de tasks com parametros (ex: /tasks/?status=0) 
    TaskReduce = Rack::Reducer.new(
    Task.all,
    ->(status:) { where(status: status) },
    ->(is_visible:) { where(is_visible: is_visible) },
  )
end
