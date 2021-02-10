class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  # Nostrar todos projetos
  def index
    @projects = Project.all
  end

  # Ir para pagina Novo projeto
  def new
    @project = Project.new
  end

  # Ir para pagina editar
  def edit
  end

  # Criar novo projeto
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # Atualização na opção Editar
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Fatoração + Indicação de ID
    def set_project
      @project = Project.find(params[:id])
    end

    # Permissão de parâmetros autorizados
    def project_params
      params.require(:project).permit(:name, :description, :start_date, :end_date)
    end
end
