module ApplicationHelper
  def form_invalid(obj, key)
    "is-invalid" if obj.errors.key?(key)
  end
end
