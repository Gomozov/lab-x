class ReportsController < ApplicationController
  before_filter :login_required, :only => [:index, :show]

  def create
    @key = params[:report].delete(:key)
    @id = User.find_by_key @key
    Report.create :key => @key, :user_id => @id.id
    render :text => 'success', :status => 200
  end

  def index
    @title = "Reports history"
    @reports = Report.all
    @counts = {}
    ((Date.today-30)..Date.today).each do |d|
      @counts[d.to_time.utc.to_i*1000+14400000] = Report.count(:conditions => ["created_at >= ? AND created_at < ?", d.to_time, (d+1).to_time])
    end
  end  

  def show
    @title = "Reports history"
    @user = User.find(params[:id])
    @counts = {}
    ((Date.today-30)..Date.today).each do |d|
      @counts[d.to_time.utc.to_i*1000+14400000] = @user.reports.count(:conditions => ["created_at >= ? AND created_at < ?", d.to_time, (d+1).to_time])
    end
  end

end
