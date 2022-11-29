class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity 
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

    def index
        campers = Camper.all
         render json: campers, status: :ok
    end 

    def show
        camper = find_camper
        if camper
        render json: camper, status: :ok
        else
        render json: { error: "Camper not found" }, status: :not_found 
        end
    end 

    def create 
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end 


    private 

    def find_camper
        camper = Camper.find_by(id: params[:id])
    end 

    def camper_params
        params.permit(:name, :age)
    end 

    def render_record_not_found
        render json: { errors: "Camper doesn't exist" }, status: :not_found 
    end 

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end 

end
