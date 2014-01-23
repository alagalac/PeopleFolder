class PagesController < ApplicationController

  after_filter :verify_authorized, :except => :index
  after_filter :verify_policy_scoped, :only => :index


  def index
    @pages = policy_scope(Page)

  end

  def show
    @page = Page.where(organisation_id: current_user.organisation_id, name: params[:name]).first

    authorize @page, :show?
  end

  def new
    @page = Page.new()

    authorize @page, :new?
  end

  def create
    @page = Page.new(page_params)

    @page.name = @page.title.strip.downcase.tr(" ", "_").gsub(/[^0-9a-z_]/i, '')
    @page.organisation = current_user.organisation

    authorize @page, :create?

    if @page.save
      flash.now[:success] = "Page created successfully."
      redirect_to page_path(@page)
    else
      flash.now[:danger] = "Unable to create page."
      render 'new'
    end
  end

  def edit
    @page = Page.where(organisation_id: current_user.organisation_id, name: params[:name]).first

    authorize @page, :edit?
  end

  def update
    @page = Page.where(organisation_id: current_user.organisation_id, name: params[:name]).first

    authorize @page, :update?

    if @page.update_attributes(page_params)
      flash[:success] = "Page updated"
      redirect_to page_path(@page)
    else
      flash.now[:danger] = "Unable to update page."
      render 'edit'
    end
  end

  def destroy
    @page = Page.where(organisation_id: current_user.organisation_id, name: params[:name]).first

    authorize @page, :destroy?

    @page.destroy

    flash[:success] = "Page deleted successfully."
    redirect_to pages_path

  end

  private

  def page_params
    params.require(:page).permit(:content, :title)
  end

end
