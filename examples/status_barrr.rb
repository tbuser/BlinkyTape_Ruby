#!/usr/bin/env ruby -wKU

# Monitors MakerBot MakerWare Conveyor looking for progress messages and display
# it on your blinkytape

require 'rubygems'
require 'socket'
require 'stringio'
require '../lib/BlinkyTape'

blinkytape = BlinkyTape.new("/dev/tty.usbmodemfd121")
socket = UNIXSocket.new("/var/tmp/conveyord.socket")

puts "Ready!"

blinkytape.show
blinkytape.display_color 0,0,0

# can't find a ruby jsonrpc gem that supports unixsocket
# conveyor doesn't put a newline at the end of each message :(
# so do a quick hack to just look for progress messages

buffer = StringIO.new
while(c = socket.getc) do
  buffer.putc c
  
  if buffer.string =~ /\"progress\"\: (\d*)\,/
    percent = $1.to_i
    
    puts "Percent: #{percent}"

    if (percent == 0)
      blinkytape.display_color 0,0,0
    else
      leds = (blinkytape.led_count * (percent/100.0)).to_i

      0.upto(blinkytape.led_count) do |i|
        if i <= leds
          blinkytape.send_pixel 255,0,0
        else
          blinkytape.send_pixel 0,0,0
        end
        sleep 0.001
      end
      blinkytape.show
    end

    buffer.reopen
  end
end

socket.close
blinkytape.close
