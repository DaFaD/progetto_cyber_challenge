class History < ActiveRecord::Base

    def History.destroySelective(pid_user)
        History.all.where(id_user: pid_user).each do |riga|
            riga.destroy
        end
    end

end
