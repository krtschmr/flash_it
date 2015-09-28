require "flash_it/version"
require 'active_support/concern'

module FlashIt

  extend ActiveSupport::Concern

  included do

    # setting flash messages, based on controller/action/key
    def flash_it(key = :success, style=nil)

      # default style is "success"
      (style = (key == :error ? :error : :success)) unless style

      # namespace lookup
      # User::SomethingController
      # => ["user", "something"]
      namespacing = self.class.to_s.split("::").map{|x| x.underscore.gsub("_controller", "")}

      #looking in flash_messages.user.something.action.key
      lookup  = "flash_messages."
      lookup << namespacing.join(".") << "."
      lookup << "#{action_name}."
      lookup << "#{key}"

      #set the flash message
      flash[style] = t(lookup)
    end
  end
end
ActionController::Base.include FlashIt
