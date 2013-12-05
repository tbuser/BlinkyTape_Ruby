#!/usr/bin/env ruby -wKU

require 'rubygems'
require 'serialport'

class BlinkyTape
  VERSION = '0.0.1'
  attr_accessor :port, :led_count, :serial
  
  def initialize(port)
    @port = port
    @led_count = 60
    @serial = SerialPort.new(@port, 115200, 8, 1, SerialPort::NONE)

    raise "Cannot connect to #{@port}" if @serial.nil?
    show
  end

  def show
    @serial.write 255.chr
    @serial.flush
  end
  
  def send_pixel(r,g,b)
    data = ""
    r = 254 if r == 255
    g = 254 if g == 255
    b = 254 if b == 255
    data = r.chr + g.chr + b.chr
    @serial.write data
    @serial.flush
  end

  def display_color(r=255, g=255, b=255)
    @led_count.times do
      send_pixel r,g,b
    end
    show
  end
  
end
