# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

source = new EventSource("/chat/events")
source.addEventListener "chat.create", (e) ->
  console.log e
  chat = $.parseJSON(e.data).chat
  $("ul#chat_room").append($("<li>").text("#{chat.name}: #{chat.message}"))
