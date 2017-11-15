/*
    Author: Alexandre Skipper
    Date: November 2017
*/

class Log {

    ArrayList<String> entries;
    int entryCount;

    public Log(int r, int n, int s) {
        entries = new ArrayList<String>();
        entries.add("Robot Count: " + str(r) + "," + 
                    "Node Count: " + str(n) + "," + 
                    "Robot Speed: " + str(s));
        entryCount = 1;
    }

    public void addEntry(String s) {
        entries.add(str(entryCount++) + "," + s);
    }

    public void saveToFile() {
        String[] strings = entries.toArray(new String[entries.size()]);
        int fileNumber = 0;
        while ((new File(sketchPath("logs\\log" + str(fileNumber) + ".csv"))).getAbsoluteFile().exists())
            fileNumber++;
        saveStrings("logs\\log" + str(fileNumber) + ".csv", strings);
    }

}