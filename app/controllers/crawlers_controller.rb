class CrawlersController < ApplicationController
  before_filter :authenticate_user!

  def show 
    @crawler = Crawler.find_or_create_by_user_id(user_id:current_user.id)

    respond_to do |format|
      format.html # show.html.erb
      format.text { 
        render json: @crawler.sweep_links.ai({html:true, index:false}) 
      } 
    end
  end
  
  def edit
    @crawler = Crawler.find_by_user_id current_user.id
  end
  
  def update
    erro_msg = ""
    @crawler = Crawler.find_by_user_id current_user.id

    respond_to do |format|
      if !erro_msg.present? and @crawler.update_attributes(_params)
        format.html { redirect_to crawler_url, notice: 'Parameters was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit", alert: erro_msg }
        format.json { render json: @crawler.errors, status: :unprocessable_entity }
      end
    end

  end
  
  private
  def _params
    params.require(:crawler).permit(:configuration, :parametrize)
  end
end
