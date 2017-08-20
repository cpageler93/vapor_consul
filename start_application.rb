require 'rubygems'
require 'commander'

class VaporApplication
  include Commander::Methods

  def run
    program :name, 'Vapor Application'
    program :version, '1.0.0'
    program :description, 'Helper Application to start Vapor+Consul Application'

    command :start do |c|
      c.syntax = 'start'
      c.description = 'Starts the application'
      c.action do |args, options|

        puts "run consul"
        consul_pid = spawn("nohup consul agent -dev -ui -client 0.0.0.0")
        Process.detach(consul_pid)

        puts "run vapor application"
        `.build/release/Run serve --env=production`

      end
    end

    run!
  end
end

VaporApplication.new.run if $0 == __FILE__