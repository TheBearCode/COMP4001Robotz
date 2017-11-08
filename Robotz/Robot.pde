public static enum Direction { LEFT, RIGHT };

public class Robot {

    private int speed, tally;
    private Direction direction;
    private Node currNode, startNode;
    private float radius;
    private color myColor;

    public Robot(int s, Node start) {
        currNode = start;
        startNode = start;
        speed = s;
        tally = 1;
        radius = currNode.getRadius() + 20;
        myColor = color(floor(random(256)), floor(random(256)), floor(random(256)));
    }

    public void update() {
        if (currNode == startNode) chooseNewDirection();

        for (int i=0; i < speed; i++)
            currNode = direction == Direction.LEFT ? currNode.getLeft() : currNode.getRight();
    }

    public void draw() {
        noFill();
        strokeWeight(5);
        stroke(myColor);
        ellipse(currNode.getX(), currNode.getY(), radius, radius);
    }

    public void eat(Robot r) {
        tally += r.getTally();
        chooseNewDirection();
    }

    private void chooseNewDirection() {
        direction = (random(1) > 0.5) ? Direction.LEFT : Direction.RIGHT;
    }

    public int getTally() { return tally; }
    public Node getNode() { return currNode; }

}