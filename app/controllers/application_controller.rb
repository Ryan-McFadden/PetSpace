class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    private

    def current_user
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    def logged_in?
        !!session[:user_id]
    end

    def redirect_if_not_logged_in
        if !logged_in?
            redirect_to root_path
        end
    end
end
