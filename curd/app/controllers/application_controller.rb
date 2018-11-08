class ApplicationController < ActionController::Base
 # protect_from_forgery with: :execption
  
  before_action :set_company, :set_group

  def set_company
    id = params[:company_id] ? params[:company_id] : params[:id]
    @company = Company.find(id)
  end

  def set_group
    group_id = params[:group_id] ? params[:group_id] : params[:id]
    @group = @company.groups.find(group_id)
  end

  def set_user
    user_id = params[:user_id] ? params[:user_id] : params[:id]
    @user = @group.users.find(user_id)
  end

  #def set_name_card
  #  name_card_id = params[:name_card] ? params[:name_card_id] : params[:id]
  #  @name_card = @user.name_cards.find(name_card_id)
  #end

end
