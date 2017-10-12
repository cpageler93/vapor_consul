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

        consul_params ||= ENV['CONSUL_PARAMS']
        consul_params ||= "agent"
        
        vapor_params ||= ENV['VAPOR_PARAMS']
        vapor_params ||= "serve --env=production"
        
        puts "run consul"
        consul_cmd = "nohup consul #{consul_params}"
        consul_pid = spawn(consul_cmd)
        Process.detach(consul_pid)

        puts "run vapor application"
        vapor_cmd = ".build/release/Run #{vapor_params}"
        `#{vapor_cmd}`

      end
    end

    run!
  end
end

VaporApplication.new.run if $0 == __FILE__