module Vagrant
  module Serial
    module Middleware
      class Configure
        def initialize(app, env)
          @app = app
        end

        def call(env)
          command = ["modifyvm", env[:vm].id, "--uart1", "0x3F8", "4", "--uartmode1", "server", "$HOME/serial/#{env[:vm].id}-com1"]
          env[:vm].provider.driver.execute_command(command)
          command = ["modifyvm", env[:vm].id, "--uart2", "0x2F8", "3", "--uartmode1", "server", "$HOME/serial/#{env[:vm].id}-com2"]
          env[:vm].provider.driver.execute_command(command)
          @app.call(env)
        end
      end
    end
  end
end
