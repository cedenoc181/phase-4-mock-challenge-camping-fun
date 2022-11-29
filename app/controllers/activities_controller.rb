class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity 
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

    def index
        activities = Activity.all
        render json: activities, status: :ok
    end 
 

    def destroy
      activity = find_activity
      activity.destroy
      head :no_content
    end 


    private 

    def find_activity
         activity = Activity.find_by(id: params[:id])
    end 

    def render_record_not_found
        render json: { errors: errors.full_messages }, status: :not_found 
    end 

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end 


end
