class Kayako < JsonAPI

    API_VERSION = '/api/v1'
    LIST_ENDPOINT = '/cases.json'
    TICKET_FIELDS_ENDPOINT = '/cases/fields.json'

    TICKET_FIELD_STATUS = 'status'
    TICKET_FIELD_PRIORITY = 'priority'
    TICKET_FIELD_GROUP = 'assigned_team'

    TICKET_STATUS_ENDPOINT = '/cases/statuses'
    TICKET_PRIORITY_ENDPOINT = '/cases/priorities'
    TICKET_GROUP_ENDPOINT = '/teams'
    
    attr_reader :fields

    def initialize(data)
        super(data)
        @api_url =  @data.uri + API_VERSION
        @auth = {:username => @data.username, :password => @data.password}
        @fields = self.getTicketFields(TICKET_FIELD_STATUS, TICKET_FIELD_PRIORITY, TICKET_FIELD_GROUP)
    end

    def list()
        url = @api_url + LIST_ENDPOINT
        return self.class.get(url, :basic_auth => @auth).parsed_response['data']
    end

    def save(ticket)
        Ticket.where(unique_id: ticket['id'], users_integration_id: @data.id, user_id: @data.user_id)
            .first_or_create(subject: ticket['subject'], department: @fields['groups'][ticket['assigned_team']['id']], created: ticket['created_at'],
                 status: @fields['statuses'][ticket['status']['id']], priority: @fields['priorities'][ticket['priority']['id']])
    end

    def getTicketFields(*fieldTypes) 
        fields = {"statuses" => {}, "priorities" => {}, "groups" => {}}
        fieldTypes.each do |fieldType|
            case fieldType
            when TICKET_FIELD_STATUS
                statuses_fields = self.getStatuses()
                statuses_fields['data'].each do |status|
                    fields['statuses'][status['id']] = status['label']
                end
            when TICKET_FIELD_PRIORITY
                priority_fields = self.getPriorities()
                priority_fields['data'].each do |status|
                    fields['priorities'][status['id']] = status['label']
                end
            when TICKET_FIELD_GROUP
                groups_fields = self.getGroups()
                groups_fields['data'].each do |status|
                    fields['groups'][status['id']] = status['title']
                end
            end
        end
        return fields
    end

    def getStatuses()
        url = @api_url + TICKET_STATUS_ENDPOINT
        return self.class.get(url, :basic_auth => @auth).parsed_response
    end

    def getPriorities()
        url = @api_url + TICKET_PRIORITY_ENDPOINT
        return self.class.get(url, :basic_auth => @auth).parsed_response
    end

    def getGroups()
        url = @api_url + TICKET_GROUP_ENDPOINT
        return self.class.get(url, :basic_auth => @auth).parsed_response
    end
    
    private :getStatuses
    private :getPriorities
    private :getGroups
end