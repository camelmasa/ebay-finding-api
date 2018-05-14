module Ebay::Finding::Api
  class Response
    attr_reader :response

    def initialize(key_name, response)
      @key_name = key_name
      @response = response
    end

    def items
      return [] unless success?

      result = JSON.parse(@response.body)["#{@key_name}Response"].first["searchResult"].first

      return [] if result["@count"] === "0"

      @items ||= result["item"]
    end

    def success?
      @response.success?
    end
  end
end
