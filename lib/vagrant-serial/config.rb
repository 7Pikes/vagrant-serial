module Vagrant
  module Serial
    class Config < Vagrant::Config::Base
      attr_accessor :forward_com1
      attr_accessor :forward_com2

      def validate(env, errors)
        errors.add("Host port for com1 forwarding couldn't be below 1024.") if forward_com1 && forward_com1.to_i < 1024
        errors.add("Host port for com2 forwarding couldn't be below 1024.") if forward_com2 && forward_com2.to_i < 1024
      end
    end
  end
end
