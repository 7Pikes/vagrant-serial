module Vagrant
  module Serial
    class Config < Vagrant::Config::Base
      attr_accessor :forward_com1
      attr_accessor :forward_com2
      attr_accessor :sockets_path

      def sockets_path
        @sockets_path.nil? ? (@sockets_path = "#{Vagrant::Environment::DEFAULT_HOME}/serial") : @sockets_path
        File.expand_path(@sockets_path)
      end

      def set?
        forward_com1 || forward_com2
      end

      def validate(env, errors)
        return unless set?

        errors.add("Host port for com1 forwarding couldn't be below 1024.") if forward_com1 && forward_com1.to_i < 1024
        errors.add("Host port for com2 forwarding couldn't be below 1024.") if forward_com2 && forward_com2.to_i < 1024
      end
    end
  end
end
