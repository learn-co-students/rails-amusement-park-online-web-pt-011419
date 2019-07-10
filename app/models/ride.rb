class Ride < ActiveRecord::Base
    belongs_to :user
    belongs_to :attraction

    def take_ride
        if valid_ticket_amount && valid_height
            return "Sorry. You do not have enough tickets to ride the #{self.attraction.name}. You are not tall enough to ride the #{self.attraction.name}."
        elsif valid_ticket_amount
            return "Sorry. You do not have enough tickets to ride the #{self.attraction.name}."
        elsif valid_height
            return "Sorry. You are not tall enough to ride the #{self.attraction.name}."
        else
            self.user.tickets -= self.attraction.tickets
            user.happiness += attraction.happiness_rating
            user.nausea += attraction.nausea_rating

            user.save
            "Thanks for riding the #{self.attraction.name}!"
        end
    end

    def valid_height
        self.user.height < self.attraction.min_height
    end

    def valid_ticket_amount
        self.user.tickets < self.attraction.tickets
    end
end
