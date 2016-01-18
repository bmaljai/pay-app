class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end

def vectorize(object_to_vectorize)
  if object_to_vectorize.class == Debt
    return "You Owe"
  else object_to_vectorize.class == Invoice
    return "You are Owed"
  end
end