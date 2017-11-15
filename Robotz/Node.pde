/*
    Author: Alexandre Skipper
    Date: November 2017
*/

public class Node {
    
    private Node left, right;
    private int id;
    private float x, y;
    private float radius;

    public Node(int i, float xx, float yy) {
        id = i;
        x = xx;
        y = yy;
        radius = 10;
    }

    //draw the node
    public void draw() {
        fill(0);
        strokeWeight(1);
        stroke(0);
        ellipse(x, y, radius, radius);
    }

    public int getId() { return id; }
    public float getX() { return x; }
    public float getY() { return y; }
    public float getRadius() { return radius; }
    public Node getLeft() { return left; }
    public Node getRight() { return right; }
    public void setLeft(Node n) { left = n; }
    public void setRight(Node n) { right = n; }

}