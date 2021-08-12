require_relative '../modules/company_info'
require_relative '../modules/validator'
require_relative '../modules/constants'

class Railcar
  include CompanyInfo
  include Validator
  include Constants

  def initialize
    validate!
  end

  private

  def validate!
    raise 'Unknown railcar type' unless Constants::RAILCAR_TYPES.include?(type)
  end

  def type; end
end
