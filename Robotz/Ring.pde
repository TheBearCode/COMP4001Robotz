

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