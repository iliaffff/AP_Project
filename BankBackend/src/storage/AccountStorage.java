package storage;

import model.Account;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class AccountStorage {

    private static final String FILE_PATH = "BankBackend/accounts.json";

    public static void save(Account account) {
        try (FileWriter writer = new FileWriter(FILE_PATH, true)) {
            writer.write(account.toJson());
            writer.write("\n");
        } catch (IOException e) {
            System.out.println("خطا در ذخیره اطلاعات حساب");
        }
    }

    public static List<Account> loadAll() {
        List<Account> accounts = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                accounts.add(Account.fromJson(line));
            }
        } catch (IOException e) {
        }

        return accounts;
    }

    public static Account findByAccountNumber(String accountNumber) {
        for (Account account : loadAll()) {
            if (account.getAccountNumber().equals(accountNumber)) {
                return account;
            }
        }
        return null;
    }

    public static void overwriteAll(List<Account> accounts) {
        try (FileWriter writer = new FileWriter(FILE_PATH, false)) {
            for (Account account : accounts) {
                writer.write(account.toJson());
                writer.write("\n");
            }
        } catch (IOException e) {
            System.out.println("خطا در بروزرسانی اطلاعات حساب‌ها");
        }
    }
}