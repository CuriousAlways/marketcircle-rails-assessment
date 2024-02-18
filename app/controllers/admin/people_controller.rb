class Admin::PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update destroy ]

  # GET /admin/people
  def index
    @people = Person.all
  end

  # GET /admin/people/:id
  def show
    @detail = @person.detail
  end

  # GET /admin/people/new
  def new
    @person = Person.new
    @person.build_detail
  end

  # GET /admin/people/:id/edit
  def edit
  end

  # POST /admin/people
  def create
    @person = Person.new(person_params)

    if @person.save
      redirect_to admin_person_path(@person), notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/people/1
  def update
    if @person.update(person_params)
      redirect_to admin_person_path(@person), notice: t('.success'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/people/1
  def destroy
    @person.destroy!
    redirect_to admin_people_url, notice: t('.success'), status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find_by(id: params[:id])

      if @person.blank?
        flash.notice = t('.not_found', id: params[:id])
        redirect_to admin_people_path
      end
    end

    # Only allow a list of trusted parameters through.
    def person_params
      params.require(:person).permit(:name, detail_attributes: [:title, :age, :email, :phone])
    end
end
