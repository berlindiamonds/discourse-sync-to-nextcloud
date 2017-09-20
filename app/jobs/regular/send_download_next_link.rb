module Jobs
  class SendDownloadNextLink < ::Jobs::Base

    sidekiq_options queue: 'low'

    def execute(args)
      to_address = args[:to_address]
      file_url = args[:next_url]

      raise Discourse::InvalidParameters.new(:to_address) if to_address.blank?
      raise Discourse::InvalidParameters.new(:file_url) if file_url.blank?

      message = DownloadBackupMailer.send_email(to_address, file_url)
      Email::Sender.new(message, :download_backup_message).send
    end
  end
end
