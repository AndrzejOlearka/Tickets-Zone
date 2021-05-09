require 'rubygems'
require 'httparty'

class JsonAPI
    include HTTParty

    def initialize(data)
        @data = data
    end

    def list
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
end
