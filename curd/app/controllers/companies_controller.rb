class CompaniesController < ApplicationController
before_action :set_company, except: [:index, :new, :create]
skip_before_action :set_group

def index
  @companies = Company.all
end

def show
end

def new
  @company = Company.new
end

def edit
end

def create
  @company = Company.new(company_params)

  if @company.save
    redirect_to @company, notice: '会社を追加しました'
  else
    render action: 'new'
  end
end

def update
  if @company.update(company_params)
    redirect_to @company, notice: '更新しました'
  else
    render action: 'edit'
  end
end

def destroy
  @company.destroy
  redirect_to companies_url
end


def comment
  @company_comment = Company.find(params[:id])
  @comment = Comment.new(comment_params.merge(company_id: @company_comment.id))
  @comment.save!
    redirect_to action: :show, notice: '成功'
  rescue
    render action: :show, notice: '失敗'
end


private

def company_params
  params.require(:company).permit(:name, :address, :tel, :fax, :url)
end

def comment_params
  params.require(:comment).permit(:name, :body)
end

end
