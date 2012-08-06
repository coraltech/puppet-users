#
# Thanks to: http://projects.puppetlabs.com/projects/1/wiki/User_Fact_Patterns
#
require 'puppet'

def getusers
  @users = Array.new
  Puppet::Type.type("user").instances.find_all do |user|
    @values = user.retrieve
    @users.push(user.name) unless @values[user.property(:uid)].to_i < 500
  end
  @users unless @users.empty?
end

Facter.add("users") do
  setcode do
    getusers.join(",")
  end
end