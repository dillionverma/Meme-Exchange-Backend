module Errors
  class BaseError < StandardError
    attr_reader :message
    attr_reader :title
    attr_reader :status
    attr_reader :code
    attr_reader :cause

    def initialize(title = nil, message: nil, status: nil, code: nil, cause: nil)
      error_code = ERROR_CODE[self.class.name.demodulize]

      @message = message
      @title = title
      @status = status
      @code = code || error_code
      @cause = cause
    end
  end

  class VerificationError < BaseError
    def initialize(msg = 'Verification Failed')
      super(msg)
    end
  end

  ERROR_CODE = {
    VerificationError: 'verification_error'
  }.freeze.with_indifferent_access
end
