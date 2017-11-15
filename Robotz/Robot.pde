/*
    Author: Alexandre Skipper
    Date: November 2017
*/

public static enum Direction { LEFT, RIGHT };

public class Robot {

    private int speed, tally, numRobots;
    private Direction direction;
    private Node currNode, startNode;
    private float radius;
    private color myColor;

    //instantiate a robot with a random color
    public Robot(int s, Node start, int n) {
        currNode = start;
        startNode = start;
        numRobots = n;
        speed = s;
        tally = 1;
        radius = currNode.getRadius() + 20;
        myColor = color(floor(random(256)), floor(random(256)), floor(random(256)));
    }

    //move the robot speed nodes to the left or right
    public void update() {
        if (tally == numRobots) return; //check if this robot has merged n-1 times
        if (currNode == startNode) chooseNewDirection(); //reached its start point

        for (int i=0; i < speed; i++)
            currNode = direction == Direction.LEFT ? currNode.getLeft() : currNode.getRight();
    }

    //draw the robot
    public void draw() {
        noFill();
        strokeWeight(5);
        stroke(myColor);
        ellipse(currNode.getX(), currNode.getY(), radius, radius);
    }

    //"merge" with another robot
    public void eat(Robot r) {
        tally += r.getTally();
        chooseNewDirection();
    }

    //coin flip when a new direction is necessary
    private void chooseNewDirection() {
        direction = (random(1) > 0.5) ? Direction.LEFT : Direction.RIGHT;
    }

    public int getTally() { return tally; }
    public Node getNode() { return currNode; }

}