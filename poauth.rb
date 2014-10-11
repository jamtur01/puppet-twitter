#!/usr/bin/env ruby

# Adapted from gasman's bloody useful Gist - https://gist.github.com/524376
# Command line util for acquiring a one-off Twitter OAuth access token
# Based on http://blog.beefyapps.com/2010/01/simple-ruby-oauth-with-twitter/


require 'rubygems'
require 'oauth'
require 'yaml'

puts <<EOS
Set up your application at https://twitter.com/apps/ (as a 'Client' app),
then enter your 'Consumer key' and 'Consumer secret':

Consumer key:
EOS
consumer_key = STDIN.readline.chomp
puts "Consumer secret:"
consumer_secret = STDIN.readline.chomp

consumer = OAuth::Consumer.new(
  consumer_key,
  consumer_secret,
  {
    :site   => 'https://api.twitter.com/',
    :scheme => :header,
  })

request_token = consumer.get_request_token

puts <<EOS
Visit #{request_token.authorize_url} in your browser to authorize the app,
then enter the PIN you are given:
EOS

pin = STDIN.readline.chomp
access_token = request_token.get_access_token(:oauth_verifier => pin)

config = {}
config = { :consumer_key => "#{consumer_key}", :consumer_secret => "#{consumer_secret}", 
           :access_key => "#{access_token.token}", :access_secret => "#{access_token.secret}" }

File.open('twitter.yaml', 'w') {|f| f.write(config.to_yaml) }

