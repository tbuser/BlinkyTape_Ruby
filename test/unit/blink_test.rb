require File.dirname(__FILE__) + '/../test_helper'
require "test/unit"
require "BlinkyTape"

class BlinkTest < Test::Unit::TestCase

  def setup
    @blinkytape = BlinkyTape.new(BLINKYTAPE_PORT)
    @blinkytape.display_color 255,255,255
    @blinkytape.reset
  end

  def teardown
    @blinkytape.close
  end
  
  def test_send_pixel
    @blinkytape.send_pixel 255,0,0
    @blinkytape.send_pixel 0,255,0
    @blinkytape.send_pixel 0,0,255
    @blinkytape.show
    sleep 2
  end
  
  def test_display_color
    @blinkytape.display_color 255,0,0
    sleep 2
    @blinkytape.display_color 0,255,0
    sleep 2
    @blinkytape.display_color 0,0,255
    sleep 2
    @blinkytape.display_color 0,0,0
    sleep 2
  end
  
  def test_led_count
    assert_equal 60, @blinkytape.led_count
  end
  
  def test_xmas
    0.upto(@blinkytape.led_count) do |i|
      if i.even?
        @blinkytape.send_pixel 255,0,0
      else
        @blinkytape.send_pixel 0,255,0
      end
    end
    @blinkytape.show
    sleep 2
  end
  
  def test_speed
    0.upto(@blinkytape.led_count) do |high_led|
      0.upto(@blinkytape.led_count) do |i|
        if i <= high_led
          @blinkytape.send_pixel 255,0,0
        else
          @blinkytape.send_pixel 0,0,0
        end
      end
      @blinkytape.show
      sleep 0.1
    end
    
  end
end
