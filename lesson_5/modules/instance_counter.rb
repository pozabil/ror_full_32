module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.prepend InstanceMethods
    base.instance_variable_set(:@instances, 0)
  end

  module ClassMethods
    attr_reader :instances

    private

    attr_writer :instances

    def inherited(subclass)
      subclass.instance_variable_set(:@instances, 0)
    end
  end

  # Чтобы автоматически вызывался из конструктора
  # и не нужно было править код классов, в которые подключается модуль
  module InstanceMethods
    def initialize(*args)
      super
      register_instance
    end

    private

    def register_instance
      self.class.send(:instances=, (self.class.instances + 1))
    end
  end
end