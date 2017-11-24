require 'gql_consumer/git_hub/api'

module GQLConsumer
  module GitHub
    module Repository
      Query = GQLConsumer::GitHub::Api::Client.parse <<-'GRAPHQL'
        query {
          repository(owner:"rails",name:"rails") {
            id
            ref(qualifiedName:"refs/heads/master") {
              target {
                ... on Commit {
                  id
                }
              }
            }
          }
        }
      GRAPHQL
    end
  end
end
