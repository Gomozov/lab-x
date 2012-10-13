class UsersController < ApplicationController
  before_filter :login_required, :only => [:index, :edit, :update, :show, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy          
  respond_to :json, :html, :xml

  def new             
    @user = User.new  
    @title = "Sign up"
  end                 

  def index
    @title = "All users"                                                 
    @users = User.paginate(:page => params[:user_page], :per_page => 10 )
  end

  def show
    @user = User.find(params[:id])
    @reports = @user.reports.where("created_at > ?", Time.at(params[:after].to_i + 1)).paginate(:page => params[:report_page], :per_page => 20)
  end  

  def edit
    @user = User.find(params[:id])
  end

  def create                                                
    @user = User.new(params[:user])                         
    if @user.save                                           
      flash[:success] = "Welcome to the Laboratory Control System"
      session[:user_id] = @user.id                          
      redirect_to @user                                     
    else                                                    
      @title = "Sign up"                                    
      render 'new'                                          
    end                                                     
  end                                                       

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private                                                

  def correct_user                                     
    @user = User.find(params[:id])                     
    redirect_to(root_path) unless @user == current_user
  end                                                  
                                                           
  def admin_user                                       
    redirect_to(root_path) unless current_user.admin?  
  end                                                  

end
