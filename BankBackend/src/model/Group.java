package model;

import java.util.List;

public class Group {

    private String groupId;
    private String groupName;
    private List<String> memberAccountNumbers;
    private double balance;

    public Group(String groupId, String groupName,
                 List<String> memberAccountNumbers,
                 double balance) {

        this.groupId = groupId;
        this.groupName = groupName;
        this.memberAccountNumbers = memberAccountNumbers;
        this.balance = balance;
    }

    public String getGroupId() {
        return groupId;
    }

    public String getGroupName() {
        return groupName;
    }

    public List<String> getMemberAccountNumbers() {
        return memberAccountNumbers;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public String toJson() {

        StringBuilder membersJson = new StringBuilder("[");
        for (int i = 0; i < memberAccountNumbers.size(); i++) {
            membersJson.append("\"")
                    .append(memberAccountNumbers.get(i))
                    .append("\"");
            if (i < memberAccountNumbers.size() - 1) {
                membersJson.append(",");
            }
        }
        membersJson.append("]");

        return "{"
                + "\"groupId\":\"" + groupId + "\","
                + "\"groupName\":\"" + groupName + "\","
                + "\"members\":" + membersJson + ","
                + "\"balance\":" + balance
                + "}";
    }

    public static Group fromJson(String json) {

        String groupId =
                json.split("\"groupId\":\"")[1].split("\"")[0];

        String groupName =
                json.split("\"groupName\":\"")[1].split("\"")[0];

        String membersPart =
                json.split("\"members\":")[1].split("],")[0] + "]";

        membersPart = membersPart
                .replace("[", "")
                .replace("]", "")
                .replace("\"", "");

        String[] membersArray = membersPart.split(",");

        List<String> members =
                membersPart.isEmpty()
                        ? new java.util.ArrayList<>()
                        : java.util.Arrays.asList(membersArray);

        String balancePart =
                json.split("\"balance\":")[1].replace("}", "");

        double balance = Double.parseDouble(balancePart);

        return new Group(groupId, groupName, members, balance);
    }
}
