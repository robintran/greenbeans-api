class Api::MatrixsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def min_weigth_path
    matrix = contruct_matrix
    unless validate_matrix(matrix)    
      render json: {status: 205, message: "invalid matrix"}
      return
    end
    min_path = []
    total_path = 1
    matrix.each do |row|
      min_ele = row.min
      t = []
      row.each do |ele|
        t << ele if ele == min_ele
      end 
      total_path = total_path*t.length
      min_path << min_ele
    end
    path = "["
    path << min_path.join(",")
    path << "]"

    render json: {status: 200, min_path: path, total_path: total_path}
  end

  protected
  def contruct_matrix 
    matrix = []
    temp = params[:matrix].gsub(/[^\[\]\d\,]/, "")
    temp = temp.split("],[")
    temp.each do |row|
      row = row.gsub(/[^\d\,]/, "")
      matrix << row.split(",")
    end
    matrix 
  end

  def validate_matrix(matrix)
    valid = true
    matrix.each do |row|  
      valid = false if row.empty?
    end
    valid
  end
end
