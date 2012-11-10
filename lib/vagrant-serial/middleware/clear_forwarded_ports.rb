module Vagrant
  module Serial
    module Middleware
      class ClearForwardedPorts
        def initialize(app, env)
          @app = app
        end

        def call(env)
          FileUtils.mkdir_p(env[:vm].config.serial.sockets_path) if env[:vm].config.serial.set? && !File.directory?(env[:vm].config.serial.sockets_path)

          env[:ui].info "Stopping serial ports forwarding..."
          `/sbin/start-stop-daemon --stop --oknodo --quiet --pidfile #{env[:vm].config.serial.sockets_path}/socat.#{env[:vm].uuid}-com1.pid --exec /usr/bin/socat && rm -f #{env[:vm].config.serial.sockets_path}/socat.#{env[:vm].uuid}-com1.pid`
          `/sbin/start-stop-daemon --stop --oknodo --quiet --pidfile #{env[:vm].config.serial.sockets_path}/socat.#{env[:vm].uuid}-com2.pid --exec /usr/bin/socat && rm -f #{env[:vm].config.serial.sockets_path}/socat.#{env[:vm].uuid}-com2.pid`

          @app.call(env)
        end
      end
    end
  end
end
