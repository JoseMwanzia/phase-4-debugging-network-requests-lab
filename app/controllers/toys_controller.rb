class ToysController < ApplicationController
  wrap_parameters format: []
rescue_from ActiveRecord::RecordInvalid, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid

  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toy.create(toy_params)
    render json: toy, status: :created
  end

  def update
    toy = Toy.find(params[:id])
    toy.update(toy_params)
  end

  def destroy
    toy = Toy.find(params[:id])
    toy.destroy
    head :no_content
  end

  private

  def render_invalid
    render json: {errors: errors.invalid.messages }, status: :unauthorized
  end
  
  def toy_params
    params.permit(:id, :name, :image, :likes)
  end

  def render_not_found
    render json: { error: "Toy not found" }, status: :not_found
  end
end
