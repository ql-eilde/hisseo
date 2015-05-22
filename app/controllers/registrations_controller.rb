class RegistrationsController < Devise::RegistrationsController
      def create
        if verify_recaptcha
          super
        else
          build_resource(sign_up_params)
          clean_up_passwords(resource)
          flash.now[:alert] = "Oups ! Une erreur est survenue à cause du recaptcha. Veuillez réessayer svp."      
          flash.delete :recaptcha_error
          render :new
        end
      end
    end