package service;

import model.Account;
import storage.AccountStorage;
import utils.Messages;

import java.util.List;

public class AccountService {

    public static void createAccount(String accountNumber, String ownerName, double balance) {

        if (balance < 0) {
            System.out.println(Messages.INVALID_BALANCE);
            return;
        }

        Account existing = AccountStorage.findByAccountNumber(accountNumber);
        if (existing != null) {
            System.out.println(Messages.ACCOUNT_ALREADY_EXISTS);
            return;
        }

        Account account = new Account(accountNumber, ownerName, balance);
        AccountStorage.save(account);

        System.out.println(Messages.ACCOUNT_CREATED_SUCCESSFULLY);
    }

    public static void showAccountInfo(String accountNumber) {

        Account account = AccountStorage.findByAccountNumber(accountNumber);
        if (account == null) {
            System.out.println(Messages.ACCOUNT_NOT_FOUND);
            return;
        }

        System.out.println("شماره حساب: " + account.getAccountNumber());
        System.out.println("نام صاحب حساب: " + account.getOwnerName());
        System.out.println("موجودی: " + account.getBalance());
    }

    public static void showAllAccounts() {

        List<Account> accounts = AccountStorage.loadAll();

        if (accounts.isEmpty()) {
            System.out.println("هیچ حسابی ثبت نشده است.");
            return;
        }

        for (Account account : accounts) {
            System.out.println("--------------------");
            System.out.println("شماره حساب: " + account.getAccountNumber());
            System.out.println("نام: " + account.getOwnerName());
            System.out.println("موجودی: " + account.getBalance());
        }
    }

    public static void transferMoney(
            String fromAccountNumber,
            String toAccountNumber,
            double amount) {

        if (amount <= 0) {
            System.out.println(Messages.INVALID_TRANSFER_AMOUNT);
            return;
        }

        if (fromAccountNumber.equals(toAccountNumber)) {
            System.out.println(Messages.SAME_ACCOUNT_TRANSFER);
            return;
        }

        Account fromAccount =
                AccountStorage.findByAccountNumber(fromAccountNumber);
        Account toAccount =
                AccountStorage.findByAccountNumber(toAccountNumber);

        if (fromAccount == null || toAccount == null) {
            System.out.println(Messages.ACCOUNT_NOT_FOUND);
            return;
        }

        if (fromAccount.getBalance() < amount) {
            System.out.println(Messages.INSUFFICIENT_BALANCE);
            return;
        }

        fromAccount.setBalance(fromAccount.getBalance() - amount);

        toAccount.setBalance(toAccount.getBalance() + amount);

        AccountStorage.overwriteAll(AccountStorage.loadAll());

        System.out.println(Messages.TRANSFER_SUCCESS);
    }
}