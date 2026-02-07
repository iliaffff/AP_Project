package test;

import service.AccountService;

public class AccountTest {

    public static void main(String[] args) {

        System.out.println("=== شروع تست مدیریت حساب‌ها ===");

        // ایجاد حساب جدید
        AccountService.createAccount("1001", "علی", 500000);

        // ایجاد حساب تکراری
        AccountService.createAccount("1001", "رضا", 300000);

        // ایجاد حساب با موجودی منفی
        AccountService.createAccount("1002", "سارا", -1000);

        // نمایش اطلاعات حساب موجود
        AccountService.showAccountInfo("1001");

        // نمایش حسابی که وجود ندارد
        AccountService.showAccountInfo("9999");

        // نمایش همه حساب‌ها
        AccountService.showAllAccounts();

        System.out.println("=== پایان تست مدیریت حساب‌ها ===");

        System.out.println("=== شروع تست انتقال وجه ===");

        // حساب 1001 قبلاً وجود دارد
        AccountService.createAccount("2001", "محمد", 300000);

        // تست انتقال موفق
        AccountService.transferMoney("1001", "2001", 100000);

        // تست موجودی ناکافی
        AccountService.transferMoney("1001", "2001", 1000000);

        // تست مبلغ منفی
        AccountService.transferMoney("1001", "2001", -500);

        // تست حساب نامعتبر
        AccountService.transferMoney("1001", "9999", 50000);

        System.out.println("=== پایان تست انتقال وجه ===");

    }
}
