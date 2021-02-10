class Project < ApplicationRecord
    has_many :tasks, :dependent => :destroy

    # Metodo para decidir qual é o progresso atual do projeto com base no status das tarefas
    def status
        return 'Não Iniciado' if tasks.none?

        if tasks.all? { |task| task.complete }
            'Finalizado'
        elsif tasks.any? { |task| task.in_progress}
            'Em progresso'
        else tasks.all? { |task| task.not_started }
            'Não Iniciado'
        end
    end

    # Decidir qual cor do botão será usada com base no andamento do projeto
    def badgecolor
        case status
        when 'Não Iniciado'
            'secondary'
        when 'Em progresso'
            'info'
        when 'Finalizado'
            'success'
        end
    end

    # Calculo da porcentagem do andamento
    def complete
        return 0 if tasks.none?
        tasks_complete = tasks.select { |task| task.complete }.count
        ((tasks_complete.to_f / tasks.count) * 100).round
    end

    # Método para verificar se projeto está atrasado ou não
    def delay
        return "Não Iniciado" if tasks.none?

        if tasks.all? { |task| task.complete }
            'Finalizado'
        elsif tasks.any? { |task| task.delayt}
            'Sim'
        else
            'Não'
        end
    end

end
    

