require 'net/http'
require 'uri'

class FileDeliveryService
  def initialize(file, filename)
    @file = file
    @filename = filename
  end

  def send_file_to_controller(controller)
    file_options = { filename: @filename, disposition: 'inline' }
    file_options[:x_sendfile] = true unless Rails.application.config.s3_enabled

    attachment_reader = AttachmentReader.new(@file)

    controller.send_data attachment_reader.read_attachment_data, file_options
  end
end
