require 'gql_consumer/version'

# ENV vars have to be loaded first
require 'dotenv/load'
require 'configuration'

GQLConsumer.configure do |config|
  # nothing to setup here... for now
end

require 'gql_consumer/git_hub/api'
require 'gql_consumer/git_hub/commit_history'

require 'tools/feed_state'

# Main gem module
module GQLConsumer
  class << self
    def consume!
      since = state.state&.last

      feed_vars = {
        since: since
      }
      p feed_vars

      result = GQLConsumer::GitHub::Api::Client.query(
        GQLConsumer::GitHub::CommitHistory::Query,
        variables: feed_vars
      )

      push_results(result.data.repository.ref.target.history.edges)
    end

    def save_state(entry)
      node = entry.node
      state.state = [entry.cursor, node.id, node.committed_date]
    end

    def push_results(feed)
      save_state(feed[0])

      if feed.size <= 1
        p "{ nothing new }"
      else
        feed[0..-1].each do |entry|
          p "{ cursor: #{entry.cursor}, node_id: #{entry.node.id}, ... }"
        end
      end
    end

    def state
      @feed_state ||= Tools::FeedState.new
    end
  end
end
