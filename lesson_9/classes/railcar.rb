require_relative '../modules/company_info'
require_relative '../modules/validation'
require_relative '../modules/constants'

class Railcar
  include CompanyInfo
  include Validation
  include Constants

  attr_reader :type

  validate :type, :presence
  validate :type, :type, String
  validate :type, :format, Constants::RAILCAR_TYPES

  def self.inherited(subclass)
    super
    subclass.validate :type, :presence
    subclass.validate :type, :type, String
    subclass.validate :type, :format, Constants::RAILCAR_TYPES
  end

  def self.type
    @type = ''
  end

  def initialize
    @type = self.class.type
    validate!
  end
end
