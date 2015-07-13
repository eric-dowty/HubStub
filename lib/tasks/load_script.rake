require 'capybara/poltergeist'

class LoadScript
  include Capybara::DSL
  attr_reader :root
  def initialize(server_url)
    @root = server_url
  end

  def session
    @session ||= Capybara::Session.new(:poltergeist)
  end

  def run
    while true do
      send(actions.sample)
    end
  end

  def actions
    [:home]
  end

  def home
    puts "viewing the home page"
    session.visit "#{root}"
  end

end

namespace :load_script do
  desc "Run a simple load script against your server"
  task :run => :environment do
    5.times.map { Thread.new { LoadScript.new(ENV["SERVER_URL"]).run } }.map(&:join)
  end
end