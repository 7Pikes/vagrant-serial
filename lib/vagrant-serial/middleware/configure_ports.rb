module Vagrant
  module Serial
    module Middleware
      class ConfigurePorts
        def initialize(app, env)
          @app = app
        end

        def call(env)
          if env[:vm].config.serial.set?
            FileUtils.mkdir_p(env[:vm].config.serial.sockets_path) if !File.directory?(env[:vm].config.serial.sockets_path)

            env[:ui].info "Configuring serial ports..."
            if env[:vm].config.serial.forward_com1
              command = ["modifyvm", env[:vm].uuid, "--uart1", "0x3F8", "4", "--uartmode1", "server", "#{env[:vm].config.serial.sockets_path}/#{env[:vm].uuid}-com1"]
              env[:vm].driver.execute_command(command)
            end

            if env[:vm].config.serial.forward_com2
              command = ["modifyvm", env[:vm].uuid, "--uart2", "0x2F8", "3", "--uartmode2", "server", "#{env[:vm].config.serial.sockets_path}/#{env[:vm].uuid}-com2"]
              env[:vm].driver.execute_command(command)
            end
          end

          @app.call(env)
        end
      end
    end
  end
end
