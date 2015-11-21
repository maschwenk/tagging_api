class Api::ProductsController < ApplicationController
  def show
    product = Product.find(params[:id])
    render json: product, status: 200
  rescue ActiveRecord::RecordNotFound
    render json: {message: "Could not find resource"}, status: 500
  end

  def destroy
    id = params[:id]
    product = Product.find(id)

    if product.destroy
      render json: {message: "Successfully deleted product: " + id}, status: 200
    else
      render json: {message: "Something went wrong"}, status: 500
    end

  rescue ActiveRecord::RecordNotFound
    render json: {message: "Could not find resource to delete."}, status: 500
  end
end
