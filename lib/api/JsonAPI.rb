require 'rubygems'
require 'httparty'

class JsonAPI
    include HTTParty
    headers 'Accept' => 'application/json'
    
    def initialize(data)
        @data = data
    end

    def list
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def save
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
end
