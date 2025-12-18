import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/page_header.dart';
import '../../logic/customer_account/customer_account_cubit.dart';
import '../widgets/add_and_create/account_setup_step.dart';
import '../widgets/add_and_create/review_step.dart';
import '../widgets/add_and_create/step_indicator.dart';
import '../widgets/create_customer_account/create_customer_bottom_bar.dart';
import '../widgets/create_customer_account/personal_info_step.dart';


class CreateCustomerScreen extends StatefulWidget {
  const CreateCustomerScreen({super.key});

  @override
  State<CreateCustomerScreen> createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends State<CreateCustomerScreen> {
  int _currentStep = 0;

  // Controllers
  final _nameCtrl = TextEditingController();
  final _idCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();

  int _accountTypeIndex = 0;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _idCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _addressCtrl.dispose();
    _dobCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: BlocListener<CustomerAccountCubit, CustomerAccountState>(
        listener: (context, state) {
          if (state.status == CustomerAccountStatus.loading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (c) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state.status == CustomerAccountStatus.error) {
            Navigator.of(context, rootNavigator: true).pop();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.error.messages.isNotEmpty ? state.error.messages.first : "Error occurred"),
                  backgroundColor: Colors.red
              ),
            );
          } else if (state.status == CustomerAccountStatus.loaded) {
            Navigator.of(context, rootNavigator: true).pop();


            _showSuccessDialog(state.createResponse);
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: PageHeader(title: "New Customer"),
              ),

              StepIndicator(currentStep: _currentStep),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: _buildCurrentStepContent(),
                ),
              ),

              CreateCustomerBottomBar(
                currentStep: _currentStep,
                isLastStep: _currentStep == 2,
                onBack: () => setState(() => _currentStep--),
                onNext: _handleNext,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobCtrl.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 0:
        return PersonalInfoStep(
          nameCtrl: _nameCtrl,
          idCtrl: _idCtrl,
          phoneCtrl: _phoneCtrl,
          emailCtrl: _emailCtrl,
          addressCtrl: _addressCtrl,
          dobCtrl: _dobCtrl,
          onTapDob: () => _selectDate(context),
        );
      case 1:
        return AccountSetupStep(
          selectedTypeIndex: _accountTypeIndex,
          onTypeSelected: (i) => setState(() => _accountTypeIndex = i),
        );
      case 2:
        return ReviewStep(
          name: _nameCtrl.text,
          id: _idCtrl.text,
          // هنا نستخدم الاسم الكامل للعرض فقط
          accountType: _getAccountTypeName(),
          address: _addressCtrl.text,
          dob: _dobCtrl.text,
        );
      default:
        return Container();
    }
  }

  void _handleNext() {
    if (_currentStep == 0) {
      if (_nameCtrl.text.isEmpty ||
          _idCtrl.text.isEmpty ||
          _phoneCtrl.text.isEmpty ||
          _addressCtrl.text.isEmpty ||
          _dobCtrl.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all fields"), backgroundColor: Colors.red),
        );
        return;
      }
    }

    if (_currentStep == 2) {
      _submitData();
    } else {
      setState(() => _currentStep++);
    }
  }

  void _submitData() {
    // إرسال البيانات للـ Cubit
    // نستخدم _getAccountTypeValue() لإرسال القيمة البرمجية المطلوبة للباك اند
    context.read<CustomerAccountCubit>().createCustomer(
      fullName: _nameCtrl.text,
      nationalId: _idCtrl.text,
      phone: _phoneCtrl.text,
      address: _addressCtrl.text,
      birthDate: _dobCtrl.text,
      accountType: _getAccountTypeValue(),
    );
  }

  // دالة تُعيد الاسم للعرض في الواجهة (Review Step)
  String _getAccountTypeName() {
    switch (_accountTypeIndex) {
      case 0: return "Savings Account";
      case 1: return "Checking Account";
      case 2: return "Business Account";
      default: return "Savings Account";
    }
  }

  // دالة تُعيد القيمة المطلوبة للـ API
  String _getAccountTypeValue() {
    switch (_accountTypeIndex) {
      case 0: return "savings";
      case 1: return "checking";
      case 2: return "business";
      default: return "savings";
    }
  }

  // عرض الديالوج النهائي بكامل التفاصيل
  void _showSuccessDialog(dynamic createResponse) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Column(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 12),
              Text("Created Successfully", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Customer account has been created. Please share these details with the customer.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 20),

              // عرض التفاصيل في بطاقة
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    _buildDialogRow("Customer ID", "${createResponse.customerID}"),
                    const Divider(),
                    _buildDialogRow("Full Name", createResponse.fullName),
                    const Divider(),
                    _buildDialogRow("Account No.", createResponse.accountNumber, isBold: true),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // كلمة المرور المؤقتة
              const Text("Temporary Password", style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.withOpacity(0.3), width: 1),
                ),
                child: Text(
                  createResponse.tempPassword,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.navy,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // إغلاق الديالوج
                  Navigator.of(context).pop(); // الرجوع للصفحة السابقة
                },
                child: const Text("Done"),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              fontSize: 14,
              color: isBold ? AppTheme.navy : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}