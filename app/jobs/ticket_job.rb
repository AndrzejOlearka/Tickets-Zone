class TicketJob < ApplicationJob
    queue_as :default

    def perform_now()
        User.all.each do |user|
            users_integrations = UsersIntegration.where(user_id: user.id)
            users_integrations.each do |integration|
                single_integration = integration.integration.name.capitalize
                instance = single_integration.constantize.new(integration)
                tickets = instance.list
                tickets.each do |ticket| 
                    instance.save(ticket)
                end
            end
        end
    end
end