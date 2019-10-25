# class CategoriesController < ApplicationController
#   def show
#     require 'base64'
#     @category = Category.find(params[:id])
#     @categorys = Category.where("ancestry LIKE ?", "@category.id")
#   end
# end
