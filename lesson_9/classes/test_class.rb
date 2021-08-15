require_relative '../modules/accessors'

class TestClass
  extend Accessors

  attr_accessor_with_history :oak, :pine, 'maple'
  strong_attr_accessor :t_string, String
  strong_attr_accessor 't_int', Integer
end
