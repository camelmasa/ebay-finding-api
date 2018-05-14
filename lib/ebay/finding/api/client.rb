module Ebay::Finding::Api
  PRODUCTION_ENDPOINT = "https://svcs.ebay.com"
  SANDBOX_ENDPOINT    = "https://svcs.sandbox.ebay.com"
  SERVICE_VERSION     = "1.13.0"
  PRODUCT_TYPES       = %w(ISBN UPC EAN ReferenceID)

  class Client
    def initialize(app_id, sandbox = true)
      @app_id  = app_id
      @sandbox = sandbox
      @base_options = { "SECURITY-APPNAME" => @app_id, "SERVICE-VERSION" => SERVICE_VERSION, "REST-PAYLOAD" => "TRUE",
                        "RESPONSE-DATA-FORMAT" => "JSON" }
    end

    def find_items_by_keywords(keyword)
      operation_name = "findItemsByKeywords"
      options = @base_options.merge("OPERATION-NAME" => operation_name, "keywords" => keyword)

      Response.new(operation_name, connection.get("/services/search/FindingService/v1", options))
    end

    def find_items_by_product(type, product_id)
      operation_name = "findItemsByProduct"

      unless PRODUCT_TYPES.include? type
        raise ArgumentError.new("You need to pass string 'ISBN', 'UPC', 'EAN' or 'ReferenceID' to first argument")
      end
      options = @base_options.merge("OPERATION-NAME" => operation_name, "productId.@type" => type,
                                    "productId" => product_id)

      Response.new(operation_name, connection.get("/services/search/FindingService/v1", options))
    end

    private

    def connection
      @connection ||= Faraday.new(url: @sandbox ? SANDBOX_ENDPOINT : PRODUCTION_ENDPOINT)
    end
  end
end
