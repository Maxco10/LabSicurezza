class Users::PasswordsController < Devise::PasswordsController
    layout 'application', only: [:edit]

    def new
        super
    end
    def create
        super
    end
    def edit
        super
    end
    def update
        super
    end
end