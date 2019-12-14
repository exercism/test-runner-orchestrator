module Orchestrator

  class TestRun
    attr_reader :status_code, :status_message, :results
    def initialize(data)
      @status_code = data&.fetch("status", nil)&.fetch("status_code", nil).to_i
      @status_message = data&.fetch("status", nil)&.fetch("message", nil)
      @results = data&.fetch("response", nil)
    end

    def ran_successfully?
      status_code == SUCCESS
    end

    def no_wokers_available?
      status_code == PLATFORM_NO_WORKER_AVAILABLE
    end

    private
    attr_reader :data

    SUCCESS = 200

    PLATFORM_NO_WORKER_AVAILABLE = 503
  end
end
=begin

  def catastrophic_error?
    !VALID_STATUSES.include?(status_code)
  end

  def should_immediately_retry?
    IMMEDIATE_RETRYABLE_ERRORS.include?(status_code)
  end

  def should_backoff_and_retry?
    BACKOFF_RETRYABLE_ERRORS.include?(status_code)
  end



  PLATFORM_ERROR = 500
  PLATFORM_UNRECOGNISED_ACTION = 501
  PLATFORM_MALFORMED_REQUEST = 502
  PLATFORM_REQUEST_TIMED_OUT = 504

  WORKER_ERROR = 510
  CONTAINER_VERSION_UNAVALIABLE = 511
  CONTAINER_SETUP_FAILURE = 512
  CONTAINER_INVOCATION_FAILURE = 513
  CONTAINER_OUTPUT_ERROR = 514

  BAD_INPUT = 400
  TIMEOUT = 401
  EXCESSIVE_IO = 402
  FORCED_EXIT = 403

  BACKOFF_RETRYABLE_ERRORS = [
    PLATFORM_NO_WORKER_AVAILABLE,
    PLATFORM_REQUEST_TIMED_OUT,
    CONTAINER_VERSION_UNAVALIABLE,
  ]
  IMMEDIATE_RETRYABLE_ERRORS = [
    CONTAINER_SETUP_FAILURE
  ]

  VALID_STATUSES = [
    SUCCESS,
    PLATFORM_ERROR, PLATFORM_UNRECOGNISED_ACTION, PLATFORM_MALFORMED_REQUEST, PLATFORM_NO_WORKER_AVAILABLE, PLATFORM_REQUEST_TIMED_OUT,
    WORKER_ERROR, CONTAINER_VERSION_UNAVALIABLE, CONTAINER_SETUP_FAILURE, CONTAINER_INVOCATION_FAILURE, CONTAINER_OUTPUT_ERROR,
    BAD_INPUT, TIMEOUT, EXCESSIVE_IO, FORCED_EXIT,
  ]
end
=end
