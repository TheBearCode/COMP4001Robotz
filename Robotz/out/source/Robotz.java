import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Robotz extends PApplet {



//Window params
int[] screen = { 1080, 1080 };
float screenX, screenY;
int sensitivity = 50;

Ring ring;

//initial screen settings
public void settings() {
    size(screen[0], screen[1]);
}

//setup the game
public void setup() {
    screenX = screen[0]/2;
    screenY = screen[1]/2;
    frameRate(30);

    ring = new Ring(42, 111, 1);
}

public void draw() {
    ring.update();
    //delay(100);
    background(255);

    drawRing(ring);
}

public void drawRing(Ring r) {
    pushMatrix();
    translate(screenX, screenY);
    r.draw();
    popMatrix();
}

public void keyPressed() {
    if (key == CODED) {
        if (keyCode == UP) {
            screenY += sensitivity;
        } else if (keyCode == DOWN) {
            screenY -= sensitivity;
        } else if (keyCode == RIGHT) {
            screenX -= sensitivity;
        } else if (keyCode == LEFT) {
            screenX += sensitivity;
        }
    }
}


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


public class Ring {

    private int numRobots, numNodes, speed;
    private ArrayList<Node> nodes;
    private ArrayList<Robot> robots;

    public Ring(int r, int n, int s) {
        numRobots = r;
        numNodes = n;
        speed = s;
        nodes = new ArrayList<Node>(numNodes);
        robots = new ArrayList<Robot>(numRobots);
        
        float rad = screen[1]/2 - 50;
        float samples = 360/(float)numNodes;
        nodes.add(new Node(0, cos(radians(samples*0))*rad, sin(radians(samples*0))*rad));
        for (int i=1; i<numNodes; i++) {
            nodes.add(new Node(i, cos(radians(samples*i))*rad, sin(radians(samples*i))*rad));
            nodes.get(i).setLeft(nodes.get(i-1));
            nodes.get(i-1).setRight(nodes.get(i));
        }
        nodes.get(0).setLeft(nodes.get(nodes.size()-1));
        nodes.get(nodes.size()-1).setRight(nodes.get(0));

        for (int i=0; i<numRobots; i++)
            robots.add(new Robot(speed, nodes.get(floor(random(numNodes)))));
    }

    public void update() {
        if (robots.size() == 1) {
            System.out.println(robots.get(0).getTally());
            return;
        }

        for (Robot r : robots) r.update();

        ArrayList<Robot> newList = new ArrayList<Robot>();
        while (robots.size() > 0) {
            Boolean flag = false;
            for (int i=0; i<robots.size(); i++) {
                Robot currRobot = robots.get(i);

                for (int j=i+1; j<robots.size(); j++) {
                    if (currRobot.getNode() == robots.get(j).getNode()) {
                        currRobot.eat(robots.get(j));
                        robots.remove(j);
                        flag = true;
                    }
                }
                newList.add(currRobot);
                robots.remove(i);
                if (flag) break;
            }
        }
        robots = newList;
    }

    public void draw() {
        for (Node n : nodes) n.draw();
        for (Robot r : robots) r.draw();
    }

}
public static enum Direction { LEFT, RIGHT };

public class Robot {

    private int speed, tally;
    private Direction direction;
    private Node currNode, startNode;
    private float radius;
    private int myColor;

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
        direction = (random(1) > 0.5f) ? Direction.LEFT : Direction.RIGHT;
    }

    public int getTally() { return tally; }
    public Node getNode() { return currNode; }

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Robotz" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
