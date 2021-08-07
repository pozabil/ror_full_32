require_relative '../modules/company_info.rb'
require_relative '../modules/validator.rb'

class Railcar
  include CompanyInfo
  include Validator

  RAILCAR_TYPES = ['cargo', 'passenger']

  def initialize
    validate!
  end

  private

  def validate!
    raise "Unknown railcar type" unless RAILCAR_TYPES.include?(type)
  end

  # Метод был вынесен в приват, так как этот метод не должен вызываться извне.
  # Он нужен только для того, чтобы показать, что он будет присутствовать в наследниках
  # и для того чтобы метод hook_railcar не выкидывал ошибку при проверке
  # @railcars << railcar if railcar.type == type, если пользователь создаст
  # объект класса Train
  def type; end
end
