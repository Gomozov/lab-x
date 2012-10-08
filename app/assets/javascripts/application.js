// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree 
  function CGauge(canvas, color, max, label, symbol) {
    this.canvas = canvas;
    this.ctx = this.canvas.getContext("2d");
    this.W = this.canvas.width;
    this.H = this.canvas.height;
    this.degrees = 0;
    this.new_degrees = 0;
    this.difference = 0;
    this.color = color;                         
    this.bgcolor = "#FFF";
    this.text = "";
    this.animation_loop = 0;
    this.maxvalue = max;
    this.minvalue = 0;
    this.label = label;
    this.symbol = symbol;
  
this.init = function () {
      this.ctx.clearRect(0, 0,this.W, this.H);
      this.ctx.beginPath();
      this.ctx.strokeStyle = "#e3e3e3";
      this.ctx.lineWidth = 12;
      this.ctx.arc(this.W/2, this.H/2, 38, 0, Math.PI*2, false); 
      this.ctx.stroke();
      radians = this.degrees * Math.PI / 180;
      this.ctx.beginPath();
      this.ctx.strokeStyle = this.color;
      this.ctx.lineWidth = 12;
      this.ctx.arc(this.W/2, this.H/2, 38, 0 - 90*Math.PI/180, radians - 90*Math.PI/180, false); 
      this.ctx.stroke();
      this.ctx.fillStyle = this.color;
      this.ctx.font = "28px bebas";  //this.text = Math.round(this.degrees/360*this.maxvalue)+this.symbol;
      text_width = this.ctx.measureText(this.text).width;
      this.ctx.fillText(this.text, this.W/2 - text_width/2, this.H/2 + 10);
      this.ctx.font = "12px bebas";
      label_width = this.ctx.measureText(this.label).width;
      this.ctx.fillText(this.label,this.W - label_width - 10, this.H);
}

this.draw = function (temp) {
  console.info("draw");
  this.text = temp+this.symbol;
  if(this.animation_loop != 0) clearInterval(this.animation_loop);
  if(temp < this.minvalue) this.new_degrees = 0;
  if(temp > this.maxvalue) this.new_degrees = 360;
  if(temp < this.maxvalue && temp > this.minvalue) this.new_degrees = Math.round(360*temp/(this.maxvalue - this.minvalue));
  this.difference = this.new_degrees - this.degrees;
  console.info(this.difference);
  console.info(this.degrees);
  console.info(this.new_degrees);
  this.animation_loop = setInterval((function(self){return function() {self.animate();}})(this), 1000/this.difference);
}

this.animate = function () {
    if(this.degrees == this.new_degrees) 
      clearInterval(this.animation_loop);
    else { if(this.degrees < this.new_degrees)
            this.degrees++;
           else
            this.degrees--;
           this.init();
         }
}
}
