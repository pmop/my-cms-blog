module Errors
  class UninitializedParamsError < StandardError
    def initialize
      super('Uninitialized params error')
    end
  end
  class InvalidParamError < StandardError
    def initialize(msg)
      super("Invalid param #{msg}")
    end
  end
end
