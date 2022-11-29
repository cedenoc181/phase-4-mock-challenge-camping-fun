class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity 
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

    def index
        signups = Signup.all
        render json: signups, status: :ok
    end

    def create 
        sign = Signup.create!(sign_params)
        render json: sign, status: :created
    end 


    private 

    def sign_params
        params.permit(:time, :camper_id, :activity_id)
    end 

    def render_record_not_found
        render json: { errors: errors.full_messages }, status: :not_found 
    end 

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end 

end
