# flash_it
### Welcome to flash_it !
The long desired flash message translation helper


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'flash_it'
```


## Usage

### Default usage
```ruby
  class UsersController < ApplicationController
    def update
      if current_user.profile.update_attributes(user_params)
        flash_it :success
        redirect_to :back
      else
        flash_it :error
        render :edit
      end
    end
  end
```

flash_it will make a lookup in your translation files for
```yml
en:
  flash_messages:
    users:
      update:
        success: This was sucessfully
        error: Oops, there was something wrong
```


### Advanced usage

By default, the type of the flash message is `success` if the argument was not `:error`.
You can change this behavior and set the type of the flash message by passing a second argument.
``flash_it :success, :notice`` then will be a ``flash[:notice]``

Also you can do something like ``flash_it(:attention, :warning)``


### Controller Namespacing

If you are having namespaced controllers, just edit your yml file to the namespaces
Lets say we have a Admin::Users::PaymentHistoryController, then your yml file needs to look like this
```yml
en:
  flash_messages:
    admin:
      users:
        payment_history:
          update:
            success: "This was successfull!" 


```




## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/krtschmr/flash_it.


## License

Released under the MIT License