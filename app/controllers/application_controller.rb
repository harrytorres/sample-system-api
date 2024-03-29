class ApplicationController < ActionController::API
    # before_action :set_current_user, if: :user_signed_in?
    

    def encode_token(payload)
        JWT.encode(payload, 'secret')
    end

    def decode_token
        auth_header = request.headers['Authorization']

        if auth_header
            token = auth_header.split(' ')[1]
            begin
                JWT.decode(token, 'secret', true, algorithm: 'HS256')
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def authorized_user
        decoded_token = decode_token()

        if decoded_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    def authorize
        render json: { message: 'You have to login.' }, status: :unauthorized unless 
        authorized_user    
    end

    # def set_current_user
    #     if session[:user_id]
    #         # Current.user = User.find_by(id: session[:user_id])
    #         @current_user = User.find_by(id: session[:user_id])

    #         if @current_user.user.admin > 0
    #             render json: { message: 'You are admin.' }, status: :ok
    #         else
    #             render json: { message: 'You have to login as admin.' }, status: :unauthorized 
    #         end
    #     end

        
            
    # end
    
end
