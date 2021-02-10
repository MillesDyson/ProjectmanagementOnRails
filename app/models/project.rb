class Project < ApplicationRecord
    has_many :tasks, :dependent => :destroy

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

    def complete
        return 0 if tasks.none?
        tasks_complete = tasks.select { |task| task.complete }.count
        ((tasks_complete.to_f / tasks.count) * 100).round
    end

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
    

