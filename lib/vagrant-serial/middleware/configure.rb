module VagrantSerial
  module Middleware
    class Configure
      def initialize(app, env)
        @app = app
      end

      def call(env)
        command = ["modifyvm", env[:machine].id, "--uart1", "0x3F8", "4", "--uartmode1", "server", "/home/vagrant/serial/#{env[:machine].id}-com1"]
        env[:machine].provider.driver.execute_command(command)
        command = ["modifyvm", env[:machine].id, "--uart2", "0x2F8", "3", "--uartmode1", "server", "/home/vagrant/serial/#{env[:machine].id}-com2"]
        env[:machine].provider.driver.execute_command(command)
        @app.call(env)
      end
    end
  end
end
