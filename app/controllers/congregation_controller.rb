class CongregationController < ApplicationController

  def new
    @congregation = Congregation.new
  end

  @congregations = Congregation.all
end
