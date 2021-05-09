class Freshdesk < JsonAPI

    LIST_ENDPOINT = '/api/v2/tickets'

    def initialize(data)
        super(data)
    end

    def list()
        auth = {:username => @data.username, :password => @data.password}
        url = @data.uri + LIST_ENDPOINT
        return self.class.get(url, :basic_auth => auth)
    end

end