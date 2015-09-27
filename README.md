# FlashIt

Welcome to flash_it - the flash helper for translating your flash messages with ease!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'flash_it'
```


## Usage

```ruby
  class UsersController < ApplicationController
    def update
      if current_user.profile.update_attributes(user_params)
        flash_it(:success)
        return redirect_to edit_user_profile_path
      else
        flash_it(:error)
        render :edit
      end
    end
  end
```

flash_it will make a lookup in your translation files for ``flash_messages.users.update.success`` or ``flash_messages.users.update.error``

By default, the `:error` messages will become a `flash[:error]` and everything else becomes a `flash[:success]` but of course you're able to customize it, by given the type of the flash message: ``flash_it(:success, :notice)``

Also this is able ``flash_it(:attention, :warning)`` which will lookup into ``flash_messages.controller.action.attention`` and uses a ``flash[:warning]``

### Controller Namespacing

If you are having namespaced controllers, just edit your yml file to the namespaces
Lets say we have a Admin::Users::PaymentHistoryController, then your yml file needs to look like this
```yml
en:
  flash_messages:
    admin:
      users:
        payment_history:
          key: value

```




## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/krtschmr/flash_it.


## License

Released under the MIT License