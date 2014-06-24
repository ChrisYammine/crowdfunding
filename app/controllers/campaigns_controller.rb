class CampaignsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_campaign, only: [:show]
  before_action :find_user_campaign, only: [:edit, :update, :destroy]

  def index
    @campaigns = Campaign.limit(10)
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      redirect_to @campaign, notice: "Campaign successfully created."
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @campaign.update_attributes(campaign_params)
      redirect_to @campaign, notice: "Campaign successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @campaign.destroy
    redirect_to campaigns_path, notice: "Successfully deleted campaign."
  end

  private

  def find_user_campaign
    @campaign = current_user.campaigns.find params[:id]
  end

  def find_campaign
    @campaign = Campaign.find params[:id]
  end

  def campaign_params
    params.require(:campaign).permit(:title, :description, :end_date, :target)
  end

end
