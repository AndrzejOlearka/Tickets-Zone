require 'rubygems'
require 'httparty'

class JsonAPI
    include HTTParty

    def freshdesk
        auth = {:username => "mateusz.to@modulesgarden.com", :password => "testmgtest123"}
        url = "https://modulesgardendev.freshdesk.com/api/v2/tickets"
        return self.class.get(url, :basic_auth => auth)
    end
end