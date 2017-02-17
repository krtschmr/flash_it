    require "flash_it/version"
    require 'active_support/concern'

    module FlashIt

      extend ActiveSupport::Concern

      module ClassMethods
        def auto_flash options={}
          before_render :generate_flash_message, only: [:create, :update, :destroy]
        end
      end

      included do

        # override redirect_to to inject a automatic generated flash_message if it's one of our actions
        def redirect_to *args
          generate_flash_message if ["create", "update", "destroy"].include?(action_name)
          super
        end

        def generate_flash_message
          var = instance_variable_get "@#{controller_name.singularize}"
          if var
            type = get_flash_type(var)

            #looking in flash_messages.user.something.action.key
            flash[type] = I18n.t("flash_messages.defaults.#{action_name}.#{type}", obj: var.model_name.human )
          end
        end

        def get_flash_type(var)
          if action_name == "create"
            return var.persisted? ? :success : :error
          end

          if action_name == "update"
            return var.valid? ? :success : :error
          end

          if action_name == "destroy"
            return var.persisted? ? :error : :success
          end
        end



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
