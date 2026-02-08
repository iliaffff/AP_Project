package test;

import model.Transaction;
import storage.TransactionStorage;

public class TransactionTest {

    public static void main(String[] args) {

        System.out.println("===== شروع تست تراکنش‌ها =====");

        Transaction t1 = new Transaction(
                "1001",
                "2001",
                50000,
                "TRANSFER",
                "2026-02-07"
        );

        Transaction t2 = new Transaction(
                "2001",
                "GROUP-G1",
                30000,
                "DEPOSIT",
                "2026-02-07"
        );

        TransactionStorage.save(t1);
        TransactionStorage.save(t2);

        System.out.println("تراکنش‌ها ذخیره شدند.");

        System.out.println("----- لیست تراکنش‌ها -----");
        for (Transaction t : TransactionStorage.loadAll()) {
            System.out.println(
                    t.getType()
                            + " | از: " + t.getFromAccount()
                            + " | به: " + t.getToAccount()
                            + " | مبلغ: " + t.getAmount()
                            + " | تاریخ: " + t.getDate()
            );
        }

        System.out.println("===== پایان تست تراکنش‌ها =====");
    }
}
