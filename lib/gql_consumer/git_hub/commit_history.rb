require 'gql_consumer/git_hub/api'

module GQLConsumer
  module GitHub
    module CommitHistory
      Query = GQLConsumer::GitHub::Api::Client.parse <<-'GRAPHQL'
        query($since:GitTimestamp){
          repository(owner: "rails", name: "rails") {
            id
            ref(qualifiedName: "refs/heads/master") {
              target {
                ... on Commit {
                  history(since:$since, first:100) {
                    totalCount
                    pageInfo {
                      hasPreviousPage
                      startCursor
                      endCursor
                      hasNextPage
                    }
                    edges {
                      cursor
                      node {
                        id
                        messageBodyHTML
                        commitUrl
                        committedDate
                        author {
                          name
                          email
                          avatarUrl
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      GRAPHQL
    end
  end
end
