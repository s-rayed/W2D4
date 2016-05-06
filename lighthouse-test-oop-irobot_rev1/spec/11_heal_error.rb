require 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
    @plasmacannon = PlasmaCannon.new
  end

  describe '#heal!' do
    it "should NOT heal a robot that is already dead and raise an error!" do
      @robot.health = 0
      expect {@robot.heal!}.to raise_error(Robot::RobotAlreadyDeadError, 'Robot is already dead, it cant be healed fool! this aint no game')
    end
  end

  describe '#attack!' do
    it "should raise an error if enemy being attacked is not a Robot" do
      expect {@robot.attack!(@plasmacannon)}.to raise_error(Robot::UnattackableEnemy, 'You cannot attack an enemy that is not a Robot, You wanna start a war?')
    end
  end

  
end