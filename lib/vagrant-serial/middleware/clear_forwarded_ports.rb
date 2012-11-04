module Vagrant
  module Serial
    module Middleware
      class ClearForwardedPorts
        def initialize(app, env)
          @app = app
        end

        def call(env)
          if env[:vm].config.serial.set?
            FileUtils.mkdir_p(env[:vm].config.serial.sockets_path) if !File.directory?(env[:vm].config.serial.sockets_path)

            if env[:vm].config.serial.forward_com1
              `/sbin/start-stop-daemon --stop --quiet --pidfile #{env[:vm].config.serial.sockets_path}/socat.#{env[:vm].uuid}-com1.pid --exec /usr/bin/socat && rm #{env[:vm].config.serial.sockets_path}/socat.#{env[:vm].uuid}-com1.pid`
            end

            if env[:vm].config.serial.forward_com2
              `/sbin/start-stop-daemon --stop --quiet --pidfile #{env[:vm].config.serial.sockets_path}/socat.#{env[:vm].uuid}-com2.pid --exec /usr/bin/socat && rm #{env[:vm].config.serial.sockets_path}/socat.#{env[:vm].uuid}-com2.pid`
            end
          end

          @app.call(env)
        end
      end
    end
  end
end
