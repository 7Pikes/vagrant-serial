module Vagrant
  module Serial
    module Middleware
      class ClearConfiguredPorts
        def initialize(app, env)
          @app = app
        end

        def call(env)
          FileUtils.mkdir_p(env[:vm].config.serial.sockets_path) if !File.directory?(env[:vm].config.serial.sockets_path)

          env[:ui].info "Clearing any previously configured serial ports..."

          command = ["modifyvm", env[:vm].uuid, "--uart1", "off"]
          env[:vm].driver.execute_command(command)

          command = ["modifyvm", env[:vm].uuid, "--uart2", "off"]
          env[:vm].driver.execute_command(command)

          @app.call(env)
        end
      end
    end
  end
end

