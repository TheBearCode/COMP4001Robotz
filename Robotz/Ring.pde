

public class Ring {

    private int numRobots, numNodes, speed, iterations;
    private ArrayList<Node> nodes;
    private ArrayList<Robot> robots;

    public Ring(int r, int n, int s) {
        numRobots = r;
        numNodes = n;
        speed = s;
        iterations = 0;
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

    public void updateRobotPositions() {
        if (robots.size() == 1) {
            return;
        }

        iterations++;
        for (Robot r : robots) r.update();
    }

    public boolean updateRobotList() {
        if (robots.size() == 1) {
            return false;
        }

        ArrayList<Robot> newList = new ArrayList<Robot>();
        while (robots.size() > 0) {
            Robot currRobot = robots.get(0);

            for (int j=1; j<robots.size(); j++) {
                if (nodeDistance(currRobot.getNode(), robots.get(j).getNode(), speed)) {
                    currRobot.eat(robots.get(j));
                    robots.remove(j--);
                }
            }
            newList.add(currRobot);
            robots.remove(0);
        }
        robots = newList;
        return true;
    }

    public boolean nodeDistance(Node a, Node b, int dist) {
        if (a == b) return true;

        Node temp = a;
        for (int i=0; i<dist; i++) {
            temp = temp.getLeft();
            if (temp == b) return true;
        }

        temp = a;
        for (int i=0; i<dist; i++) {
            temp = temp.getRight();
            if (temp == b) return true;
        }

        return false;
    }

    public void draw() {
        for (Node n : nodes) n.draw();
        for (int i=robots.size()-1; i>=0; i--) robots.get(i).draw();
    }

    public int getNumRobots() { return numRobots; }
    public int getNumNodes() { return numNodes; }
    public int getSpeed() { return speed; }
    public int getIterations() { return iterations; }
}