module Tools
  class FeedState
    attr_reader :state

    def initialize
      @file_path = 'tmp/feed_state'
      load
    end

    def state=(state)
      @state = state
      save
    end

    private

    attr_reader :file_path

    def save
      f = File.open(file_path, 'w+')
      f.write parse_state
      f.close
    end

    def load
      if File.exist? file_path
        # we want only first line, and file shouldnt have moar then 1!
        first_line = File.open(file_path, 'r').first
        @state = first_line&.split(',')
      else
        File.new(file_path, 'w+')
        @state = nil
      end
    end

    def parse_state
      raise StandardError, 'State is not an Array' unless state.is_a? Array
      state.join(',')
    end
  end
end
