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
    redirect_to @company, notice: 'Company was successfully created.'
  else
    render action: 'new'
  end
end

def update
  if @company.update(company_params)
    redirect_to @company, notice: 'Company was successfully updated'
  else
    render action: 'edit'
  end
end

def destroy
  @company.destroy
  redirect_to companies_url
end

private

def company_params
  params.require(:company).permit(:name, :address, :tel, :fax, :url)
end



end
