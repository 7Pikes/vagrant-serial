module Vagrant
  module Serial
    module Middleware
      class ForwardPorts
        def initialize(app, env)
          @app = app
        end

        def call(env)
          if env[:vm].config.serial.forward_com1
            `/sbin/start-stop-daemon --quiet --start --pidfile #{ENV['HOME']}/serial/socat.#{env[:vm].uuid}-com1.pid --background --make-pidfile --exec /usr/bin/socat -- tcp-l:#{env[:vm].config.serial.forward_com1},reuseaddr,fork UNIX-CONNECT:#{ENV['HOME']}/serial/#{env[:vm].uuid}-com1`
          end

          if env[:vm].config.serial.forward_com2
            `/sbin/start-stop-daemon --quiet --start --pidfile #{ENV['HOME']}/serial/socat.#{env[:vm].uuid}-com2.pid --background --make-pidfile --exec /usr/bin/socat -- tcp-l:#{env[:vm].config.serial.forward_com2},reuseaddr,fork UNIX-CONNECT:#{ENV['HOME']}/serial/#{env[:vm].uuid}-com2`
          end

          @app.call(env)
        end
      end
    end
  end
end
