package model;

public class Account {
    private String accountNumber;
    private String ownerName;
    private double balance;

    public Account(String accountNumber, String ownerName, double balance) {
        this.accountNumber = accountNumber;
        this.ownerName = ownerName;
        this.balance = balance;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public String toJson() {
        return "{"
                + "\"accountNumber\":\"" + accountNumber + "\","
                + "\"ownerName\":\"" + ownerName + "\","
                + "\"balance\":" + balance
                + "}";
    }

    public static Account fromJson(String json) {

        String accountNumber =
                json.split("\"accountNumber\":\"")[1].split("\"")[0];

        String ownerName =
                json.split("\"ownerName\":\"")[1].split("\"")[0];

        String balancePart =
                json.split("\"balance\":")[1].replace("}", "");

        double balance = Double.parseDouble(balancePart);

        return new Account(accountNumber, ownerName, balance);
    }
}