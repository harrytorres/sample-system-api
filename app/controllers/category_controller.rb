class CategoryController < ApplicationController
    before_action :authorize
    # before_action :set_current_user, only: [:create]

    def index
        @categories = Category.all
        
        render json: @categories
    end 

    def create
        @category = Category.new(category_params)

        if @category.save
            render json: @category, status: :created, location: @category
        else
            render json: @category.errors, status: :unprocessable_entity
        end
    end
        
    private

    def category_params
        params.require(:category).permit(:name, :slug, :description)
    end   
    

  
end
