require "net/http"
require "net/https"
require "uri"
require "json"

class Jira
  def initialize(dependencies:)
    @config = dependencies.fetch(:config)
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
    uri = URI("#{@config.get(:jira, :url)}#{path}")
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https", verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
      http.set_debug_output($stdout) if @logger.debug?

      request = Net::HTTP::Get.new(uri.request_uri)
      request.basic_auth(@config.get(:jira, :email), @config.get(:jira, :api_key))

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