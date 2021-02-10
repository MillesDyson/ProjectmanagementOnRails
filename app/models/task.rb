class Task < ApplicationRecord
  belongs_to :project

  validates :status, inclusion: { in: ['Finalizado', 'Em progresso', 'Não Iniciado']}

  STATUS_OPTIONS = [
    ['Não Iniciado', 'Não Iniciado'],
    ['Em progresso', 'Em progresso'],
    ['Finalizado', 'Finalizado']
  ]

  # Metodos para decidir STATUS do projeto
  def complete
  status == 'Finalizado'
  end

  def in_progress
  status == 'Em progresso'
  end

  def not_started
  status == 'Não Iniciado'
  end

  def delayt
  end_date > project.end_date
  end
  
end
