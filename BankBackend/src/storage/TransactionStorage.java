package storage;

import model.Transaction;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class TransactionStorage {

    private static final String FILE_PATH = "BankBackend/transactions.json";

    public static void save(Transaction transaction) {
        try (FileWriter writer = new FileWriter(FILE_PATH, true)) {
            writer.write(transaction.toJson());
            writer.write("\n");
        } catch (IOException e) {
            System.out.println("خطا در ذخیره تراکنش.");
        }
    }

    public static List<Transaction> loadAll() {
        List<Transaction> transactions = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                transactions.add(Transaction.fromJson(line));
            }
        } catch (IOException e) {
        }

        return transactions;
    }
}
