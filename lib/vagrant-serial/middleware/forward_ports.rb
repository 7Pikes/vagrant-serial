module Vagrant
  module Serial
    module Middleware
      class ForwardPorts
        def initialize(app, env)
          @app = app
        end

        def call(env)
          `/sbin/start-stop-daemon --quiet --start --pidfile #{ENV['HOME']}/serial/socat.#{env[:vm].uuid}-com1.pid --background --make-pidfile --exec /usr/bin/socat -- tcp-l:30001,reuseaddr,fork UNIX-CONNECT:#{ENV['HOME']}/serial/#{env[:vm].uuid}-com1`
          `/sbin/start-stop-daemon --quiet --start --pidfile #{ENV['HOME']}/serial/socat.#{env[:vm].uuid}-com2.pid --background --make-pidfile --exec /usr/bin/socat -- tcp-l:30002,reuseaddr,fork UNIX-CONNECT:#{ENV['HOME']}/serial/#{env[:vm].uuid}-com2`
          @app.call(env)
        end
      end
    end
  end
end
