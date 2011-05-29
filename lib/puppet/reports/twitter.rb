require 'puppet'
require 'yaml'

begin
  require 'twitter'
rescue LoadError => e
  Puppet.info "You need the `twitter` gem to use the Twitter report"
end

Puppet::Reports.register_report(:twitter) do

  configfile = File.join([File.dirname(Puppet.settings[:config]), "twitter.yaml"])
  raise(Puppet::ParseError, "Twitter report config file #{configfile} does not exist - did you run the poauth.rb script?") unless File.exist?(configfile)
  CREDS = YAML.load_file(configfile)

  desc <<-DESC
  Send report information to Twitter using a custom Twitter application. Please create a custom Twitter 
  application and run the poauth.rb script to create Twitter credentials in the `twitter.yaml` configuration 
  file.
  DESC

  def process
    if self.status == 'failed'
      Puppet.debug "Sending status for #{self.host} to Twitter"
      Twitter.configure do |config|
        config.consumer_key = "#{CREDS[:consumer_key]}"
        config.consumer_secret = "#{CREDS[:consumer_secret]}"
        config.oauth_token = "#{CREDS[:access_key]}"
        config.oauth_token_secret = "#{CREDS[:access_secret]}"
      end

      Twitter.update("Puppet run for #{self.host} #{self.status}")
    end
  end
end
