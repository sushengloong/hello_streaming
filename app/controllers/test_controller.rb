class TestController < ApplicationController
  include ActionController::Live

  def index
    10.times do |i|
      response.stream.write "#{i+1}.hello world<br />\n"
      sleep 1
    end
    response.stream.close
  end
end
