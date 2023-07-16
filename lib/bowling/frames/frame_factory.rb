require_relative 'frame'
require_relative 'final_frame'

class FrameFactory
  def new_frame(frame_count)
    return FinalFrame.new if frame_count >= 9

    Frame.new
  end
end
