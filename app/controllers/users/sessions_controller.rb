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
    
    protected
    def after_sign_in_path_for(resource)
        if resource.is_a?(User) && resource.ban == 1
          flash[:notice] = "Questo account è bananto perche: #{resource.motivo_ban}"
          sign_out resource
          root_path
        else
          super
        end
    end
end