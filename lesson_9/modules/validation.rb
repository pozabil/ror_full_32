require_relative 'attr_check'

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    include AttrCheck

    def validations
      @validations ||= []
    end

    def validate(attr_name, validation_type, arg = nil)
      attr_name_check(attr_name)
      validations << { attr_name: attr_name, validation_type: validation_type, arg: arg }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    def validate!
      return if self.class.validations.nil?

      self.class.validations.each do |validation|
        send("validate_#{validation[:validation_type]}", validation[:attr_name], validation[:arg])
      end
    end

    private

    def attr_value(attr_name)
      instance_variable_get("@#{attr_name}".to_sym)
    end

    def validate_presence(attr_name, _)
      raise "#{attr_name} value is nil or empty string" if
        attr_value(attr_name).nil? || attr_value(attr_name).to_s.empty?
    end

    def validate_format(attr_name, format)
      raise "#{attr_name} value has mismatched format" unless
        attr_value(attr_name).match?(format)
    end

    def validate_type(attr_name, type)
      raise "#{attr_name} value has mismatched type" unless
        attr_value(attr_name).is_a?(type)
    end
  end
end
