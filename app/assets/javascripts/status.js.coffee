window.Status = class @Status
  constructor: (url = 'ws://localhost:3000/statuses/register') ->
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
    @ws.send(json)

  handleData: (data) ->
    if data.success
      $('#message').text "Success!"
      @insertRow(data)
    else
      $('#message').text "A problem occurred."
      console.log data.error

  insertRow: (status) ->
    tbody = $('tbody')
    tr = """
    <tr>
      <td>#{status.job_id}</td>
      <td>#{status.state}</td>
      <td>#{status.status_time}</td>
    </tr>
    """
    tbody.append(tr)

$ ->
  window.stat = new window.Status()

  $("form").submit (evt) ->
    data =
      job_id: $('#job_id').val()
      state:  $('#state').val()
      status_time: new Date()

    window.stat.send(data)
    evt.preventDefault()
