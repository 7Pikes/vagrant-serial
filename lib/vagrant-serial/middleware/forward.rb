module Vagrant
  module Serial
    module Middleware
      class Forward
        def initialize(app, env)
          @app = app
        end

        def call(env)
          env[:vm].channel.execute("socat tcp-l:30001,reuseaddr,fork UNIX-CONNECT:$HOME/serial/#{env[:vm].id}-com1 &")
          env[:vm].channel.execute("socat tcp-l:30002,reuseaddr,fork UNIX-CONNECT:$HOME/serial/#{env[:vm].id}-com2 &")
          @app.call(env)
        end
      end
    end
  end
end
