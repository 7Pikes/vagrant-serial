module Vagrant
  module Serial
    module Middleware
      class Forward
        def initialize(app, env)
          @app = app
        end

        def call(env)
          `start-stop-daemon --quiet --start --pidfile #{ENV['HOME']}/serial/socat.#{env[:vm].uuid}-com1.pid --background --make-pidfile --exec /usr/bin/socat -- tcp-l:30001,reuseaddr,fork UNIX-CONNECT:#{ENV['HOME']}/serial/#{env[:vm].uuid}-com1`
          `start-stop-daemon --quiet --start --pidfile #{ENV['HOME']}/serial/socat.#{env[:vm].uuid}-com2.pid --background --make-pidfile --exec /usr/bin/socat -- tcp-l:30002,reuseaddr,fork UNIX-CONNECT:#{ENV['HOME']}/serial/#{env[:vm].uuid}-com2`
          @app.call(env)
        end
      end
    end
  end
end
