class PagesGeneraleController < ApplicationController
  def home

  end

  def registration_form
    @test = current_user
  end
end
