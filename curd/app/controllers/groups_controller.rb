class GroupsController < ApplicationController
  before_action :set_company
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = @company.groups
  end

  def show
  end

  def new
    @group = @company.groups.new
  end

  def create
   @group = @company.groups.new(group_params)

   if @group.save
     redirect_to [@company, @group], notice: '部署を追加しました'
   else
     render action: 'new'
   end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to [@company, @group], notice: '更新しました'
    else
      render action: 'edit'
    end
  end

  def destroy
    @group.destroy
    redirect_to company_groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

end
