# frozen_string_literal: true

module FlashHelper
  def classes_for_flash(key)
    case key
    when :error, "error"
      "bg-red-50 text-red-500 border border-red-400"
    when :success, "success"
      "bg-green-50 text-green-500 border border-green-400"
    else
      "bg-blue-50 text-blue-500 border border-blue-400"
    end
  end

  def classes_for_flash_dismiss(key)
    case key
    when :error, "error"
      "bg-red-50 text-red-500 hover:bg-red-100 focus:ring-offset-red-50 focus:ring-red-600"
    when :success, "success"
      "bg-green-50 text-green-500 hover:bg-green-100 focus:ring-offset-green-50 focus:ring-green-600"
    else
      "bg-blue-50 text-blue-500 hover:bg-blue-100 focus:ring-offset-blue-50 focus:ring-blue-600"
    end
  end
end
