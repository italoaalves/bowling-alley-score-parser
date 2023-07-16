require_relative 'frames/frame_factory'
require_relative 'errors/invalid_roll_error'

class Player
  attr_reader :curr_frame, :name

  MAX_FRAMES = 10

  def initialize(name, frame_factory = FrameFactory.new)
    @name = name
    @frame_factory = frame_factory
    @head_frame = frame_factory.new_frame(0)
    @curr_frame = @head_frame
    @frame_count = 1
  end

  def add_roll(roll_value)
    add_frame(@frame_factory.new_frame(@frame_count)) if @curr_frame.finished?
    @curr_frame.add_roll(roll_value)
  end

  def pinfalls
    pinfalls = []
    cursor = @head_frame
    until cursor.nil?
      pinfalls.push(cursor.rolls_tree)
      cursor = cursor.next
    end
    pinfalls
  end

  def score_list
    score_list = []
    score = 0
    cursor = @head_frame
    until cursor.nil?
      score += cursor.score
      score_list.push(score)
      cursor = cursor.next
    end
    score_list
  end

  def total_score
    score_list.last
  end

  private

  def add_frame(new_frame)
    raise InvalidRollError, "Player #{@name} has already #{MAX_FRAMES} frames" if @frame_count >= MAX_FRAMES

    @curr_frame.next = new_frame
    @curr_frame = new_frame
    @frame_count += 1
  end
end
