class StatusesController < ApplicationController
  include Tubesock::Hijack

  def index
    @jobs = Job.all
  end

  def register
    hijack do |tubesock|
      tubesock.onopen do
        tubesock.send_data({success: true, message: "Hello Client"}.to_json)
      end

      tubesock.onmessage do |data|
        begin
          Status.create(data)
          tubesock.send_data {success: true}
        rescue => e
          error_message = {success: false, error: e.message}.to_json
          tubesock.send_data error_message
        end
      end
    end

end
