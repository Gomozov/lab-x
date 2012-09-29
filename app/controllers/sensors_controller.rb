class SensorsController < ApplicationController
  before_filter :login_required, :only => [:index, :show]

  def create
    params[:data].map do |key, value|
      Sensor.create :name => key, :value => value
    end
    render :text => '', :status => 200
  end

  def index
    @title = "Measure history"                                                 
    @TemperatureA3 = Sensor.where(:name => "Temperature A3", :created_at => (Time.now - 1.day)..Time.now)
    @TemperatureA4 = Sensor.where(:name => "Temperature A4", :created_at => (Time.now - 1.day)..Time.now)
    @TemperatureD9 = Sensor.where(:name => "Temperature D9", :created_at => (Time.now - 1.day)..Time.now)
    @TemperatureD10 = Sensor.where(:name => "Temperature D10", :created_at => (Time.now - 1.day)..Time.now)
    @HumidityA3 = Sensor.where(:name => "Humidity A3", :created_at => (Time.now - 1.day)..Time.now)
    @HumidityA4 = Sensor.where(:name => "Humidity A4", :created_at => (Time.now - 1.day)..Time.now)
    @PressureA5 = Sensor.where(:name => "Pressure A5", :created_at => (Time.now - 1.day)..Time.now)
    @LightA0 = Sensor.where(:name => "Light A0", :created_at => (Time.now - 1.day)..Time.now)
    @LightA1 = Sensor.where(:name => "Light A1", :created_at => (Time.now - 1.day)..Time.now)
    @GasA2 = Sensor.where(:name => "Gas A2", :created_at => (Time.now - 1.day)..Time.now)
    @LightR = Sensor.where(:name => "Light R", :created_at => (Time.now - 1.day)..Time.now)
    @TemperatureR = Sensor.where(:name => "Temperature R", :created_at => (Time.now - 1.day)..Time.now)
  end

end
