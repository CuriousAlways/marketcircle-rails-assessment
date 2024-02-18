module Api
  module V1
    class DetailsController < ::Api::ApiController
      before_action :set_person

      # GET /api/v1/people/:person_id/detail
      def show
        render json: (@person.detail || {})
      end

      # POST /api/v1/people/:person_id/detail
      def create
        @person.update(detail_attributes: permitted_params)

        if @person.errors.blank?
          render json: @person.detail
        else
          render json: { error: @person.errors.full_messages.to_sentence }, status: :unprocessable_entity
        end
      end

      private def set_person
        @person = ::Person.find_by(id: params[:person_id])

        if @person.blank?
          render json: { error: t('api.v1.people.not_found', id: params[:person_id]) }, status: :not_found
        end
      end

      private def permitted_params
        params.permit(:age, :email, :phone, :title)
      end
    end
  end
end
