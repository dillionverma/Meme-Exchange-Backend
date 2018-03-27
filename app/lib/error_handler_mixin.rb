module ErrorHandlerMixin
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing do |e|
      render_exception_error(
        status: :unprocessable_entity,
        code: '422',
        title: 'Missing parameter',
        exception: e
      )
    end

    rescue_from ActiveRecord::RecordNotSaved do |e|
      render_exception_error(
        status: :conflict,
        code: '409',
        title: 'Resource not saved',
        exception: e
      )
    end

    rescue_from ActiveRecord::RecordNotUnique do |e|
      render_exception_error(
        status: :conflict,
        code: '409',
        title: 'Resource not unique',
        exception: e
      )
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      render_exception_error(
        status: :not_found,
        code: '404',
        title: 'Resource not found',
        exception: e
      )
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render_exception_error(
        status: :bad_request,
        code: '400',
        title: 'Resource Invalid',
        exception: e
      )
    end
  end

  protected

  def render_exception_error(status:, code:, title:, exception:)
    Rails.logger.info(
      "Returning error response for exception: #{exception.class.name}: #{exception.message}"
    )
    render_error(status: status, code: code, title: title, detail: exception.message)
  end

  def render_error(status:, code:, title:, detail:)
    render status: status, json: {
      errors: [{
        status: code,
        title: title,
        detail: detail
      }]
    }
  end

  def render_validation_errors(instance)
    list_of_errors = []
    instance.errors.messages.each do |attr, errors|
      errors.each do |error|
        list_of_errors.push(title: "#{attr} #{error}", detail: attr, code: '400')
      end
    end
    render status: '400', json: { errors: list_of_errors }
  end
end
