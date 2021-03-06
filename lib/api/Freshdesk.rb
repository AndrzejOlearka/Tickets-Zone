class Freshdesk < JsonAPI

    API_VERSION = '/api/v2'
    LIST_ENDPOINT = '/tickets'
    TICKET_FIELDS_ENDPOINT = '/ticket_fields'

    TICKET_FIELD_STATUS = 'status'
    TICKET_FIELD_PRIORITY = 'priority'
    TICKET_FIELD_GROUP = 'group'
    
    attr_reader :fields

    def initialize(data)
        super(data)
        @api_url =  @data.uri + API_VERSION
        @auth = {:username => @data.username, :password => @data.password}
        @fields = self.getTicketFields(TICKET_FIELD_STATUS, TICKET_FIELD_PRIORITY, TICKET_FIELD_GROUP)
    end

    def list()
        url = @api_url + LIST_ENDPOINT
        return self.class.get(url, :basic_auth => @auth)
    end

    def save(ticket)
        Ticket.where(unique_id: ticket['id'], users_integration_id: @data.id, user_id: @data.user_id)
            .first_or_create(subject: ticket['subject'], department: @fields['groups'][ticket['group_id']], created: ticket['created_at'],
                 status: @fields['statuses'][ticket['status']], priority: @fields['priorities'][ticket['priority']])
    end

    def listTicketFields()
        url = @api_url + TICKET_FIELDS_ENDPOINT
        return self.class.get(url, :basic_auth => @auth)
    end

    def parseTicketFields()
        parsed_fields = {}
        @ticket_fields.each do |ticket_field|
            if ticket_field['choices'].nil?
                next
            end 
            parsed_fields[ticket_field['name']] = ticket_field['choices']
        end
        return parsed_fields
    end

    def getTicketFields(*fieldTypes) 
        @ticket_fields = self.listTicketFields
        parsed_fields = self.parseTicketFields

        fields = {"statuses" => {}, "priorities" => {}, "groups" => {}}
        fieldTypes.each do |fieldType|
            case fieldType
            when TICKET_FIELD_STATUS
                parsed_fields[TICKET_FIELD_STATUS].each do |status|
                    fields['statuses'][status[0].to_i] = status[1][0]
                end
            when TICKET_FIELD_PRIORITY
                parsed_fields[TICKET_FIELD_PRIORITY].each do |status|
                    fields['priorities'][status[1]] = status[0]
                end
            when TICKET_FIELD_GROUP
                parsed_fields[TICKET_FIELD_GROUP].each do |status|
                    fields['groups'][status[1]] = status[0]
                end
            end
        end
        return fields
    end
    
    private :parseTicketFields
end