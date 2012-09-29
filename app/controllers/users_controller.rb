class UsersController < ApplicationController
  before_filter :login_required, :only => [:index, :edit, :update, :show, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy          

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
    @TemperatureA3 = Sensor.where(:name => "Temperature A3").last
    @TemperatureA4 = Sensor.where(:name => "Temperature A4").last
    @TemperatureD9 = Sensor.where(:name => "Temperature D9").last
    @TemperatureD10 = Sensor.where(:name => "Temperature D10").last
    @HumidityA3 = Sensor.where(:name => "Humidity A3").last
    @HumidityA4 = Sensor.where(:name => "Humidity A4").last
    @PressureA5 = Sensor.where(:name => "Pressure A5").last
    @LightA0 = Sensor.where(:name => "Light A0").last
    @LightA1 = Sensor.where(:name => "Light A1").last
    @GasA2 = Sensor.where(:name => "Gas A2").last
    @LightR = Sensor.where(:name => "Light R").last
    @TemperatureR = Sensor.where(:name => "Temperature R").last
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
