module Constants
  NAME_FORMAT = /\A[a-zA-Z ]+[a-zA-Z]\z/.freeze
  NUMBER_FORMAT = /\A[a-zA-Z0-9]{3}-?[a-zA-Z0-9]{2}\z/.freeze
  TRAIN_TYPES = /\Acargo\z|\Apassenger\z/.freeze
  RAILCAR_TYPES = TRAIN_TYPES
  VALIDAION_TYPES = %i[presence format type].freeze
end
