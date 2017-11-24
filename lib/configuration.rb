module GQLConsumer
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  # Handles configuration and default values
  class Configuration
    attr_accessor :api_url,
                  :api_access_token,
                  :max_feed_size,
                  :request_headers

    def initialize
      @api_url = ENV['GITHUB_GQL_API_URL'] || 'https://api.github.com/graphql'
      @api_access_token = ENV['GITHUB_API_ACCESS_TOKEN'] || 'this_is_secret'
      @request_headers = { "Authorization" => "Bearer #{@api_access_token}" }
      @max_feed_size = 100
    end
  end
end
