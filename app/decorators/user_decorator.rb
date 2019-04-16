class UserDecorator < Draper::Decorator
  delegate_all

  def hello
    "hello"
  end
end
