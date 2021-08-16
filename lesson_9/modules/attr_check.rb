module AttrCheck
  private

  def attr_name_check(name)
    raise TypeError, 'invalid attribute name type, expected String or Symbol' unless
      name.is_a?(String) || name.is_a?(Symbol)
    raise NameError, 'invalid attribute name' if
      name.to_s != name.to_s.tr('^a-zA-Z0-9_', '') || name.to_s.nil? || name.to_s[0].match?(/\d/)
  end

  def type_check(type)
    raise TypeError, 'invalid type, expected Class' unless type.is_a?(Class)
  end
end
