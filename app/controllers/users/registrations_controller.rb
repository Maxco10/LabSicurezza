class Users::RegistrationsController < Devise::RegistrationsController
    layout 'application', only: [:edit]

    def new
        super
    end
    def cancel
        super
    end
    def create
        super
        @user.nome = params[:user][:nome]
        @user.sesso = params[:user][:sesso]
        @user.save
        
    end
    def edit
        
        render layout: "per_annunci"
    end
    def update
        super
        @user.nome = params[:user][:nome]
        @user.sesso = params[:user][:sesso]
        uploaded_io = params[:user][:foto]
        if uploaded_io != nil
            Rails.logger.debug "#{current_user.inspect}"
            if current_user.foto != ""
                file_veccchio = current_user.foto.split('/')[-1]
                File.delete(Rails.root.join('app','assets','images','foto_utenti', "#{file_veccchio}"))
            end
            estensione = uploaded_io.original_filename.split('.')[-1]
            File.open(Rails.root.join('app','assets','images','foto_utenti', "utente#{@user.id}.#{estensione}"), 'wb') do |file|
                file.write(uploaded_io.read)
            end
            @user.foto = "foto_utenti/utente#{@user.id}.#{estensione}"
        end
        @user.save
    end
    def destroy
        super
    end
end