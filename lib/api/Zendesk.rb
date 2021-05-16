class Zendesk < JsonAPI

    API_VERSION = '/api/v2'
    LIST_ENDPOINT = '/tickets/recent'
    TICKET_FIELDS_ENDPOINT = '/ticket_fields'
    TICKET_GROUPS_ENDPOINT = '/groups'

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
        return self.class.get(url, :basic_auth => @auth).parsed_response['tickets']
    end

    def save(ticket)
        Ticket.where(unique_id: ticket['id'], users_integration_id: @data.id, user_id: @data.user_id)
            .first_or_create(subject: ticket['subject'], department: @fields['groups'][ticket['group_id']], created: ticket['created_at'],
                 status: @fields['statuses'][ticket['status']], priority: @fields['priorities'][ticket['priority']])
    end

    def listTicketFields()
        url = @api_url + TICKET_FIELDS_ENDPOINT
        return self.class.get(url, :basic_auth => @auth, format: :json).parsed_response['ticket_fields']
    end

    def parseTicketFields()
        parsed_fields = {}

        @ticket_fields.each do |ticket_field|
            if ticket_field.exclude?('system_field_options')
                next
            end 
           
            if ticket_field['system_field_options'].nil?
                next
            end 
            parsed_fields[ticket_field['type']] = ticket_field['system_field_options']
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
                    fields['statuses'][status['value']] = status['name']
                end
            when TICKET_FIELD_PRIORITY
                parsed_fields[TICKET_FIELD_PRIORITY].each do |status|
                    fields['priorities'][status['value']] = status['name']
                end
            when TICKET_FIELD_GROUP
                fields['groups'] = self.getGroups
            end
        end
        return fields
    end

    def getGroups()
        url = @api_url + TICKET_GROUPS_ENDPOINT
        groups = self.class.get(url, :basic_auth => @auth).parsed_response['groups']
        return self.parseGroups(groups)
    end

    def parseGroups(groups)
        parsedGroups = {};
        groups.each do |group|
            parsedGroups[group['id']] = group['name']
        end
        return parsedGroups
    end
    
    private :parseTicketFields
    private :parseGroups
end