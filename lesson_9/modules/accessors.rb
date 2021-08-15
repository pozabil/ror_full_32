require_relative 'attr_check'

module Accessors
  include AttrCheck

  def attr_accessor_with_history(*attr_names)
    attr_names.each do |attr_name|
      attr_name_check(attr_name)
      attr_getter(attr_name)
      attr_setter_with_history(attr_name)
      attr_history_getter(attr_name)
    end
  end

  def strong_attr_accessor(attr_name, type)
    attr_name_check(attr_name)
    type_check(type)
    attr_getter(attr_name)
    strong_attr_setter(attr_name, type)
  end

  private

  def attr_getter(attr_name)
    var_name = "@#{attr_name}".to_sym
    define_method(attr_name.to_sym) { instance_variable_get(var_name) }
  end

  def attr_setter_with_history(attr_name)
    var_name = "@#{attr_name}".to_sym
    var_history_name = "@#{attr_name}_history".to_sym
    define_method("#{attr_name}=".to_sym) do |value|
      previous_value = instance_variable_get(var_name)
      previous_history = instance_variable_get(var_history_name)
      break if value == previous_value

      history = previous_history.nil? ? [] : previous_history
      history << value
      instance_variable_set(var_name, value)
      instance_variable_set(var_history_name, history)
    end
  end

  def attr_history_getter(attr_name)
    var_history_name = "@#{attr_name}_history".to_sym
    define_method("#{attr_name}_history".to_sym) { instance_variable_get(var_history_name) }
  end

  def strong_attr_setter(attr_name, type)
    var_name = "@#{attr_name}".to_sym
    define_method("#{attr_name}=".to_sym) do |value|
      raise TypeError, 'invalid value type' unless value.is_a?(type)

      instance_variable_set(var_name, value)
    end
  end
end
