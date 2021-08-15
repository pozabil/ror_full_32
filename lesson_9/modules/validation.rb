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
      type_and_arg_check(validation_type, arg)
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
        validate_by_type(validation[:attr_name], validation[:validation_type], validation[:arg])
      end
    end

    private

    def validate_by_type(attr_name, validation_type, arg)
      attr_value = instance_variable_get("@#{attr_name}".to_sym)
      case validation_type
      when :presence
        raise "#{attr_name} value is nil or empty string" unless validate_presence(attr_value)
      when :format
        raise "#{attr_name} value has mismatched format" unless validate_format(attr_value, arg)
      when :type
        raise "#{attr_name} value has mismatched type" unless validate_type(attr_value, arg)
      end
    end

    def validate_presence(attr_value)
      !attr_value.nil? && !attr_value.to_s.empty?
    end

    def validate_format(attr_value, format)
      attr_value.match?(format)
    end

    def validate_type(attr_value, type)
      attr_value.is_a?(type)
    end
  end
end
