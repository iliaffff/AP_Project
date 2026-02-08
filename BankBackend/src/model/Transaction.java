package model;

public class Transaction {

    private String fromAccount;
    private String toAccount;
    private double amount;
    private String type;
    private String date;

    public Transaction(String fromAccount,
                       String toAccount,
                       double amount,
                       String type,
                       String date) {

        this.fromAccount = fromAccount;
        this.toAccount = toAccount;
        this.amount = amount;
        this.type = type;
        this.date = date;
    }

    public String getFromAccount() {
        return fromAccount;
    }

    public String getToAccount() {
        return toAccount;
    }

    public double getAmount() {
        return amount;
    }

    public String getType() {
        return type;
    }

    public String getDate() {
        return date;
    }

    public String toJson() {
        return "{"
                + "\"from\":\"" + fromAccount + "\","
                + "\"to\":\"" + toAccount + "\","
                + "\"amount\":" + amount + ","
                + "\"type\":\"" + type + "\","
                + "\"date\":\"" + date + "\""
                + "}";
    }

    public static Transaction fromJson(String json) {

        String from =
                json.split("\"from\":\"")[1].split("\"")[0];

        String to =
                json.split("\"to\":\"")[1].split("\"")[0];

        String amountPart =
                json.split("\"amount\":")[1].split(",")[0];

        double amount = Double.parseDouble(amountPart);

        String type =
                json.split("\"type\":\"")[1].split("\"")[0];

        String date =
                json.split("\"date\":\"")[1].split("\"")[0];

        return new Transaction(from, to, amount, type, date);
    }
}
