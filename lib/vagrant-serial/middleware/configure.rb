module Vagrant
  module Serial
    module Middleware
      class Configure
        def initialize(app, env)
          @app = app
        end

        def call(env)
          command = ["modifyvm", env[:vm].uuid, "--uart1", "0x3F8", "4", "--uartmode1", "server", "$HOME/serial/#{env[:vm].uuid}-com1"]
          env[:vm].driver.execute_command(command)
          command = ["modifyvm", env[:vm].uuid, "--uart2", "0x2F8", "3", "--uartmode1", "server", "$HOME/serial/#{env[:vm].uuid}-com2"]
          env[:vm].driver.execute_command(command)
          @app.call(env)
        end
      end
    end
  end
end
