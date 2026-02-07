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
    }
}
