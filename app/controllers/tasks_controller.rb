class TasksController < ApplicationController
  before_action :find_project
  before_action :set_project
  before_action :set_task, only: %i[ show edit update destroy ]

  # Mostrar todas as tarefas
  def index
    @tasks = @project.tasks
  end

  # Ir para Mostrar
  def show
  end

  # Ir para pagina de novo
  def new
    @task = Task.new
  end

  # Ir para pagina Editar
  def edit
  end

  # Criar uma nova tarefa
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_tasks_path(id: @task.id), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # Atualizar na opção Edit
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_tasks_path, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_path, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Fatoração + Indicação de ID
    def set_task
      @task = Task.find(params[:id])
    end

    def set_project
      @task = Project.find(params[:project_id])
    end
    
    def find_project
      @project = Project.find(params[:project_id])
    end

    # Permissão de parâmetros autorizados
    def task_params
      output = params.require(:task).permit(:name, :description, :start_date, :project_id, :end_date, :status)
      output.merge(project_id: @project.id)
    end
end
