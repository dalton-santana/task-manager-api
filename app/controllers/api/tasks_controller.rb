class Api::TasksController < ApplicationController
    before_action :authenticate_with_token!

    def index
        # Atribuicao para filtrar tasks do usuario logado com paramentros enviados (ex: /tasks/?status=0&is_visible=1)
        params[:user_id] = current_user.id
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

        # Verificacao necessaria para nao permitir a atualizacao de atividades ja concluidas
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
        # Atribuicao para filtrar tarefas somente visíveis (publicas)
        params[:is_visible] = true
        @tasks = TaskReduce.apply(params)

        render json: @tasks, status: 200
    end

    private
    def task_params
        params.require(:task).permit(:title, :description, :status, :is_visible)
    end

    # Filtro de tasks com parametros (ex: /tasks/?status=0)
    TaskReduce = Rack::Reducer.new(
    Task.all,
    ->(user_id:) { where(user_id: user_id) },
    ->(status:) { where(status: status) },
    ->(is_visible:) { where(is_visible: is_visible) },
  )
end
