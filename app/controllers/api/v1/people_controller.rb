module Api
  module V1
    class PeopleController < ::Api::ApiController
      before_action :set_person, only: :show

      RESULT_PER_PAGE = 25

      # GET /api/v1/people
      def index
        page_no = params[:page].to_i || 1
        offset = (page_no - 1) * RESULT_PER_PAGE
        @people = ::Person.limit(RESULT_PER_PAGE).offset(offset)

        render json: @people
      end

      # GET /api/v1/people/:id
      def show
        render json: @person
      end

      # POST /api/v1/people
      def create
        @person = ::Person.new(permitted_params)

        if @person.save
          render json: @person
        else
          render json: { error: @person.errors.full_messages.to_sentence }, status: :unprocessable_entity
        end
      end

      private def set_person
        @person = ::Person.find_by(id: params[:id])

        if @person.blank?
          render json: { error: t('.not_found', id: params[:id]) }, status: :not_found
        end
      end

      private def permitted_params
        params.permit(:name)
      end
    end
  end
end
