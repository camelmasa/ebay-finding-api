module Ebay::Finding::Api
  class Response
    attr_reader :response

    def initialize(key_name, response)
      @key_name = key_name
      @response = response
    end

    def items
      return [] unless success?

      @items ||= JSON.parse(@response.body)["#{@key_name}Response"].first["searchResult"]
    end

    def success?
      @response.success?
    end
  end
end
