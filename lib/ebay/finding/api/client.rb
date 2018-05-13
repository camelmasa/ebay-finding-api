module Ebay::Finding::Api
  PRODUCTION_ENDPOINT = "https://svcs.ebay.com"
  SANDBOX_ENDPOINT    = "https://svcs.sandbox.ebay.com"
  SERVICE_VERSION     = "1.13.0"

  class Client
    def initialize(app_id, sandbox = true)
      @app_id  = app_id
      @sandbox = sandbox
    end

    def find_items_by_keywords(keyword)
      operation_name = "findItemsByKeywords"
      options = { "OPERATION-NAME" => operation_name, "SERVICE-VERSION" => SERVICE_VERSION, "REST-PAYLOAD" => "TRUE",
                  "SECURITY-APPNAME" => @app_id, "RESPONSE-DATA-FORMAT" => "JSON", "keywords" => keyword }

      Response.new(operation_name, connection.get("/ervices/search/FindingService/v1", options))
    end

    private

    def connection
      @connection ||= Faraday.new(url: @sandbox ? SANDBOX_ENDPOINT : PRODUCTION_ENDPOINT)
    end
  end
end
