class StatusesController < ApplicationController
  include Tubesock::Hijack

  def index
    @statuses = Status.all
  end

  def register
    @@sockets ||= []
    hijack do |tubesock|
      tubesock.onopen do
        @@sockets << tubesock
        tubesock.send_data({success: true, message: "Hello Client"}.to_json)
      end

      tubesock.onmessage do |data|
        begin
          Rails.logger.info data.class
          Rails.logger.info data
          status = Status.create!(JSON.parse(data))
          @@sockets.each do |socket|
            socket.send_data({success: true}.merge(status.attributes).to_json)
          end
        rescue => e
          error_message = {success: false, error: e.message}.to_json
          tubesock.send_data error_message
        end
      end

      tubesock.onclose do
        @@sockets.delete(tubesock)
      end

    end
  end
end
