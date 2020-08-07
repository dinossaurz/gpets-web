class PetsController < ApplicationController
  def new
    @pet = Pet.new
  end

  def index
    @pets = current_user.pets
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def create
    @pet = Pet.new(pet_params.merge(user_id: current_user.id))
    if @pet.save
      flash[:notice] = 'Pet cadastrado com sucesso!'
      redirect_to @pet
    else
      flash[:alert] = 'Algo deu errado'
      render :new
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :pet_type, :gender, :bearing, :castrated)
  end
end