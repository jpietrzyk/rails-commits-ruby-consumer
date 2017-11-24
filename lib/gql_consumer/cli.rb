require 'gql_consumer'
require 'thor'

# CLI commands
module GQLConsumer
  class CLI < Thor
    desc 'consume', 'consumes new commits from Rails Repository'
    def consume
      GQLConsumer.consume!
    end
  end
end
