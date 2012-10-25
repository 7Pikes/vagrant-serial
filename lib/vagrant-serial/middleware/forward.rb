module Vagrant
  module Serial
    module Middleware
      class Forward
        def initialize(app, env)
          @app = app
        end

        def call(env)
          `socat tcp-l:30001,reuseaddr,fork UNIX-CONNECT:$HOME/serial/#{env[:machine].id}-com1 &`
          `socat tcp-l:30002,reuseaddr,fork UNIX-CONNECT:$HOME/serial/#{env[:machine].id}-com2 &`
          @app.call(env)
        end
      end
    end
  end
end
