require "net/http"
require "net/https"
require "uri"
require "json"

class Jira
  include SpecifiesInput

  uses_input :url, context: :jira, description: "The base URL of your Jira domain"
  uses_input :email, context: :jira, description: "The email address of your Jira user"
  uses_input :api_key, context: :jira, description: "API key or Personal Access Token for your Jira user"

  def initialize(dependencies:)
    @dependencies = dependencies
    @logger = dependencies.fetch(:logger)
  end

  def fetch_ticket(key)
    raise ArgumentError.new("Missing 'key' argument") if key.nil?

    @logger.debug("Fetching #{key}")

    response_body = http_get("/rest/api/3/issue/#{key}")
    hash = JSON.parse(response_body)
    {
      key: hash["key"],
      summary: hash["fields"]["summary"]
    }
  end

  private

  def http_get(path)
    uri = URI("#{input_value_for(:url)}#{path}")
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https", verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
      http.set_debug_output($stdout) if @logger.debug?

      request = Net::HTTP::Get.new(uri.request_uri)
      request.basic_auth(input_value_for(:email), input_value_for(:api_key))

      response = http.request(request)
      response.value

      response.body
    end
  end

  def headers
    {
      "Accept" => "application/json",
    }
  end
end
