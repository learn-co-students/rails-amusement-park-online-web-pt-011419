class User < ActiveRecord::Base
    has_secure_password
    has_many :rides
    has_many :attractions, through: :rides

    def mood
        if !happiness.nil? && !nausea.nil?
            happiness > nausea ? "happy" : "sad"
        end
    end
end
