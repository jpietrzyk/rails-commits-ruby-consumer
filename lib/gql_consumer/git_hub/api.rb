require "graphql/client"
require "graphql/client/http"

module GQLConsumer
  module GitHub
    module Api
      HTTP = GraphQL::Client::HTTP.new(GQLConsumer.configuration.api_url) do
        def headers(context)
          GQLConsumer.configuration.request_headers
        end
      end

      Schema = GraphQL::Client.load_schema(HTTP)

      # However, it's smart to dump this to a JSON file and load from disk
      #
      # Run it from a script or rake task
      #   GraphQL::Client.dump_schema(SWAPI::HTTP, "path/to/schema.json")
      #
      # Schema = GraphQL::Client.load_schema("path/to/schema.json")

      Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
    end
  end
end

