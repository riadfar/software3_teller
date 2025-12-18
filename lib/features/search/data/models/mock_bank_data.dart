import 'Account.dart';
import 'customer.dart';

class MockBankData {
  static final List<Customer> customers = [
    // --- السيناريو 1: عميل فردي عادي (حسابات بسيطة) ---
    Customer(
      id: "CUST-1001",
      name: "Ahmad Al-Saeed",
      phone: "+963 933 111 222",
      email: "ahmad.saeed@gmail.com",
      accounts: [
        Account(id: "SAV-101", name: "Personal Savings", balance: "\$12,500.00",isSub: false),
        Account(id: "CHK-102", name: "Daily Checking", balance: "\$4,200.50",isSub: false),
      ],
    ),

    // --- السيناريو 2: شركة (Composite Pattern - حسابات متداخلة) ---
    Customer(
      id: "CORP-2020",
      name: "Tech Vision Ltd.",
      phone: "+963 11 444 5555",
      email: "finance@techvision.sy",
      accounts: [
        Account(id: "MAIN-800", name: "Corporate Main", balance: "\$150,000.00",isSub: false),
        // حساب مركب (مجموعة)
        Account(
          id: "GRP-900",
          name: "Departments Fund",
          balance: "\$80,000.00",isSub: false, // المجموع
          subAccounts: [
            Account(id: "SUB-01", name: "IT Dept Budget", balance: "\$50,000.00",isSub: true),
            Account(id: "SUB-02", name: "HR Dept Budget", balance: "\$30,000.00",isSub: true),
          ],
        ),
      ],
    ),

    // --- السيناريو 3: عميل متعثر (State Pattern - حساب مجمد) ---
    Customer(
      id: "CUST-3005",
      name: "Samer Jaber",
      phone: "+963 944 777 888",
      email: "samer.j@hotmail.com",
      accounts: [
        Account(
            id: "LOAN-555",
            name: "Car Loan Account",
            balance: "\$0.00",
            isFrozen: true,isSub: false // مجمد بسبب التعثر
        ),
        Account(id: "SAV-556", name: "Savings", balance: "\$500.00",isSub: false),
      ],
    ),
  ];
}