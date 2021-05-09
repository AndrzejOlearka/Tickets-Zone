class TicketJob < ApplicationJob
    queue_as :default

    def perform_now()
        puts 'Hello';
    end
end