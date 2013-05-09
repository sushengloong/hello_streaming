class TestController < ApplicationController
  include ActionController::Live

  def index
    10.times do |i|
      response.stream.write "#{i+1}.hello world<br />\n"
      sleep 1
    end
    response.stream.close
  end

  def random
    lang = ["Ruby", "Python", "Node.JS", "Java", "Scala", "PHP"]
    100.times do
      random = rand(lang.length).to_i
      response.stream.write "I love #{lang[random]}<br />\n"
      sleep random
    end
    response.stream.close
  end
end
