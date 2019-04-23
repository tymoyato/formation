class BaseValidator < SimpleDelegator
  include ActiveModel::Validations

  # delegates validator errors to base model
  def valid?
    result = super
    errors.details.each do |attribute, attribute_errors|
      attribute_errors.each do |error_hash|
        message_key = error_hash.delete(:error)
        __getobj__.errors.add(attribute, message_key, error_hash)
      end
    end
    result
  end
end
