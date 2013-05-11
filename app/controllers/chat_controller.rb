class ChatController < ApplicationController
  include ActionController::Live

  def index
    @chats = Chat.all
  end

  def create
    response.headers["Content-Type"] = "text/javascript"
    @chat = Chat.create(name: params[:name], message: params[:message])
    $redis.publish('chat.create', @chat.to_json)
  end

  def events
    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    redis.psubscribe('chat.*') do |on|
      on.pmessage do |pattern, event, data|
        response.stream.write("event: #{event}\n")
        response.stream.write("data: #{data}\n\n")
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure
    redis.quit
    response.stream.close
  end
end
