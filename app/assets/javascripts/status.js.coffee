window.Status = class @Status
  constructor: (url = 'http://localhost:3000/statuses/register') ->
    @ws = new WebSocket(url)

    @ws.onopen = (evt) =>
      console.log "Websocket opened"

    @ws.onclose = (evt) ->
      console.log "Websocket closed"
      @isOpen = false

    @ws.onmessage = (evt) =>
      data = JSON.parse(evt.data)
      console.log "Data received from WebSocket: ", data
      @handleData(data)

  send: (data) ->
    json = JSON.stringify(data)
    console.log "Sending json to server", json
    if @isOpen
      console.log "Sending data", json
      @ws.send(json)
    else
      console.log "Queueing data", json
      @queue.push json
      console.log "@queue = ", @queue

  handleData: (data) ->
    if data.success

    else
      console.log data.error

$("form").submit (evt) ->
  evt.preventDefault()
