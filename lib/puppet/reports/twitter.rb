require 'puppet'

begin
  require 'grackle'
rescue LoadError => e
  Puppet.info "You need the `grackle` gem to use the IRC report"
end

Puppet::Reports.register_report(:twitter) do

  configfile = File.join([File.dirname(Puppet.settings[:config]), "extlookup.yaml"])
  raise(Puppet::ParseError, "Extlookup config file #{configfile} not readable") unless File.exist?(configfile)

  desc <<-DESC
  Send report information to an IRC channel.
  DESC

  def process
    if self.status == 'failed'
      Puppet.debug "Sending status for #{self.host} to IRC #{IRC}"
      ShoutBot.shout("#{IRC}") do |channel|
        channel.say "Puppet run for #{self.host} #{self.status} at #{Time.now.asctime}"
      end
    end
  end
end
