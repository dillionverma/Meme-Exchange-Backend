class Reddit
    attr_accessor :client
    def initialize
        @client = Redd.it(user_agent: 'Meme Exchange Client', client_id: ENV['reddit_client_id'], secret: ENV['reddit_secret_key'])
    end

    def get
        @client.client.refresh if @client.client.access.expired?
        @client
    end
end

Reddit = Reddit.new