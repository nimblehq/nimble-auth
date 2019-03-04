module NimbleAuth
  class SessionsController < Devise::SessionsController
    # In Rails 5, `protect_from_forgery` is no longer prepended to the `before_action` chain,
    # so using `authenticate_user` before `protect_from_forgery` results in "Can't verify CSRF token authenticity."
    # To resolve this, either change the order in which you call them, or use `protect_from_forgery prepend: true`.
    protect_from_forgery prepend: true

    # DELETE /signout
    #
    # Passes a block to the parent implementation to clear flash message.
    def destroy
      super { flash.clear }
    end

    private

    def after_sign_in_redirect_path(_resource)
      root_path
    end

    def after_sign_out_redirect_path(_resource)
      new_user_session_path
    end

    alias after_sign_in_path_for after_sign_in_redirect_path
    alias after_sign_out_path_for after_sign_out_redirect_path
  end
end
