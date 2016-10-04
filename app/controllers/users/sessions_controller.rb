class Users::SessionsController < Devise::SessionsController
    layout 'application', only: [:edit]

    def new
        super
    end
    def cancel
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
    def destroy
        super
    end
end