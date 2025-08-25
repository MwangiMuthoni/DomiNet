import 'package:flutter/material.dart';
import 'package:ke_domain_connect/Screens/NewDashboard.dart';
import 'package:ke_domain_connect/Screens/Pending.dart';
// import 'FadedAnimation.dart'; // Make sure to import your FadeAnimationSimple

class RegistrarApplication extends StatefulWidget {
  @override
  _RegistrarApplicationState createState() => _RegistrarApplicationState();
}

class _RegistrarApplicationState extends State<RegistrarApplication> {
  int _currentStep = 0;
  final PageController _pageController = PageController();

  // Form controllers
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _contactPersonController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _businessTypeController = TextEditingController();
  final TextEditingController _domainPortfolioController = TextEditingController();
  final TextEditingController _businessDescController = TextEditingController();
  final TextEditingController _yearsInBusinessController = TextEditingController();
  final TextEditingController _kraPinController = TextEditingController();
  final TextEditingController _certificateController = TextEditingController();
  final TextEditingController _bankDetailsController = TextEditingController();
  final TextEditingController _whcmsController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _companyNameController.dispose();
    _contactPersonController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    _businessTypeController.dispose();
    _domainPortfolioController.dispose();
    _businessDescController.dispose();
    _yearsInBusinessController.dispose();
    _kraPinController.dispose();
    _certificateController.dispose();
    _bankDetailsController.dispose();
    _whcmsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xAA1A1B1E),
      appBar: AppBar(
        title: Text(
          'Registrar Application',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Color(0xAA1A1B1E),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Stepper header
          FadeAnimationSimple(0.5, _buildStepperHeader()),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              children: [
                // Step 1: Company Information
                _buildCompanyInfoStep(),
                // Step 2: Business Details
                _buildBusinessDetailsStep(),
                // Step 3: Verification
                _buildVerificationStep(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepperHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStepIndicator(0, 'Company Info', _currentStep >= 0),
          _buildStepLine(_currentStep >= 1),
          _buildStepIndicator(1, 'Business Details', _currentStep >= 1),
          _buildStepLine(_currentStep >= 2),
          _buildStepIndicator(2, 'Verification', _currentStep >= 2),
        ],
      ),
    );
  }

  Widget _buildStepLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        margin: EdgeInsets.symmetric(horizontal: 8),
        color: isActive ? Color(0xFFF15E33) : Color(0xFF373A3F),
      ),
    );
  }

  Widget _buildStepIndicator(int stepNumber, String title, bool isActive) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isActive ? Color(0xFFF15E33) : Color(0xFF373A3F),
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? Color(0xFFF15E33) : Color(0xFF373A3F),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              '${stepNumber + 1}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Color(0xFF5C5F65),
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCompanyInfoStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeAnimationSimple(1.0, Text(
            'Company Information',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )),
          SizedBox(height: 10),
          FadeAnimationSimple(1.2, Text(
            'Tell us about your company and how we can reach you',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF5C5F65),
            ),
          )),
          SizedBox(height: 30),

          FadeAnimationSimple(1.4, _buildDarkFormContainer([
            _buildDarkFormField(
              controller: _companyNameController,
              hint: 'Company Name *',
              isFirst: true,
            ),
            _buildDarkFormField(
              controller: _contactPersonController,
              hint: 'Contact Person *',
            ),
            _buildDarkFormField(
              controller: _emailController,
              hint: 'Email Address *',
              keyboardType: TextInputType.emailAddress,
            ),
            _buildDarkFormField(
              controller: _phoneController,
              hint: 'Phone Number *',
              keyboardType: TextInputType.phone,
            ),
            _buildDarkFormField(
              controller: _websiteController,
              hint: 'Company Website',
              keyboardType: TextInputType.url,
              isLast: true,
            ),
          ])),

          SizedBox(height: 40),

          // Next Button
          FadeAnimationSimple(1.8, Align(
            alignment: Alignment.centerRight,
            child: MaterialButton(
              onPressed: () {
                if (_validateCompanyInfo()) {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              color: Color(0xFFF15E33),
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Next Step',
                style: TextStyle(
                  color: Colors.white.withOpacity(.9),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildBusinessDetailsStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeAnimationSimple(1.0, Text(
            'Business Details',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )),
          SizedBox(height: 10),
          FadeAnimationSimple(1.2, Text(
            'Help us understand your business and experience',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF5C5F65),
            ),
          )),
          SizedBox(height: 30),

          FadeAnimationSimple(1.4, _buildDarkFormContainer([
            _buildDarkDropdownField(
              controller: _businessTypeController,
              hint: 'Business Type *',
              items: [
                'Domain Registrar',
                'Web Hosting Provider',
                'IT Services',
                'Other'
              ],
              isFirst: true,
            ),
            _buildDarkFormField(
              controller: _domainPortfolioController,
              hint: 'Current Domain Portfolio',
              keyboardType: TextInputType.number,
            ),
            _buildDarkFormField(
              controller: _yearsInBusinessController,
              hint: 'Years in Business *',
            ),
          ])),

          SizedBox(height: 20),

          // Business Description
          FadeAnimationSimple(1.6, Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xAA1A1B1E),
              border: Border.all(color: Color(0xFF373A3F)),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _businessDescController,
                maxLines: 5,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Color(0xFF5C5F65)),
                  hintText: 'Business Description *\nTell us about your business, services, and why you want to become a registrar...',
                ),
              ),
            ),
          )),

          SizedBox(height: 40),

          // Navigation Buttons
          FadeAnimationSimple(1.8, Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                color: Color(0xFF373A3F),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Previous',
                  style: TextStyle(
                    color: Colors.white.withOpacity(.9),
                    fontSize: 16,
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  if (_validateBusinessDetails()) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                color: Color(0xFFF15E33),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Next Step',
                  style: TextStyle(
                    color: Colors.white.withOpacity(.9),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildVerificationStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeAnimationSimple(1.0, Text(
            'Verification Documents',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )),
          SizedBox(height: 10),
          FadeAnimationSimple(1.2, Text(
            'Provide the required documents for verification',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF5C5F65),
            ),
          )),
          SizedBox(height: 30),

          FadeAnimationSimple(1.4, _buildDarkFormContainer([
            _buildDarkFormField(
              controller: _kraPinController,
              hint: 'KRA PIN Number ',
              isFirst: true,
            ),
            _buildDarkFormField(
              controller: _certificateController,
              hint: 'Business Registration Certificate ',
            ),
            _buildDarkFormField(
              controller: _bankDetailsController,
              hint: 'Bank Account Details/Mpesa Number',
            ),
            _buildDarkFormField(
              controller: _whcmsController,
              hint: 'WHCMS credentials/keys',
            ),
          ])),

          SizedBox(height: 30),

          // What happens next
          FadeAnimationSimple(1.6, Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF373A3F).withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFF373A3F)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What happens next?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                _buildBulletPoint('We will review your application within 2-3 business days'),
                _buildBulletPoint('Our team may contact you for additional information'),
                _buildBulletPoint('Once approved, you will receive access to the registrar dashboard'),
                _buildBulletPoint('You can start listing your domain services immediately'),
              ],
            ),
          )),

          SizedBox(height: 40),

          // Navigation Buttons
          FadeAnimationSimple(1.8, Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                color: Color(0xFF373A3F),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Previous',
                  style: TextStyle(
                    color: Colors.white.withOpacity(.9),
                    fontSize: 16,
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  if (_validateVerification()) {
                    _submitApplication();
                  }
                },
                color: Color(0xFFF15E33),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Submit Application',
                  style: TextStyle(
                    color: Colors.white.withOpacity(.9),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildDarkFormContainer(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xAA1A1B1E),
        border: Border.all(color: Color(0xFF373A3F)),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDarkFormField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    bool isFirst = false,
    bool isLast = false,
    int maxLines = 1,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: isLast ? null : Border(bottom: BorderSide(color: Color(0xFF373A3F))),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(color: Color(0xFF5C5F65)),
          hintText: hint,
        ),
      ),
    );
  }

  Widget _buildDarkDropdownField({
    required TextEditingController controller,
    required String hint,
    required List<String> items,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: isLast ? null : Border(bottom: BorderSide(color: Color(0xFF373A3F))),
      ),
      child: DropdownButtonFormField<String>(
        dropdownColor: Color(0xFF1A1B1E),
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(color: Color(0xFF5C5F65)),
          hintText: hint,
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Colors.white),
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            controller.text = newValue!;
          });
        },
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: EdgeInsets.only(top: 6, right: 12),
            decoration: BoxDecoration(
              color: Color(0xFFF15E33),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xFF5C5F65),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _validateCompanyInfo() {
    if (_companyNameController.text.isEmpty ||
        _contactPersonController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Color(0xFFF15E33),
        ),
      );
      return false;
    }
    return true;
  }

  bool _validateBusinessDetails() {
    if (_businessTypeController.text.isEmpty ||
        _businessDescController.text.isEmpty ||
        _yearsInBusinessController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Color(0xFFF15E33),
        ),
      );
      return false;
    }
    return true;
  }

  bool _validateVerification() {
    if (_kraPinController.text.isEmpty ||
        _certificateController.text.isEmpty ||
        _bankDetailsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Color(0xFFF15E33),
        ),
      );
      return false;
    }
    return true;
  }

  void _submitApplication() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1A1B1E),
        title: Text(
          'Application Submitted',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Your registrar application has been submitted successfully. We will review it and contact you soon.',
          style: TextStyle(color: Color(0xFF5C5F65)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PendingStatusWidget (),
                ),
              ); // Close the application fkraorm
            },
            child: Text(
              'OK',
              style: TextStyle(color: Color(0xFFF15E33)),
            ),
          ),
        ],
      ),
    );
  }
}

// FadeAnimationSimple widget (same as in your UserSignUp)
class FadeAnimationSimple extends StatefulWidget {
  final double delay;
  final Widget child;

  const FadeAnimationSimple(this.delay, this.child, {Key? key}) : super(key: key);

  @override
  State<FadeAnimationSimple> createState() => _FadeAnimationSimpleState();
}

class _FadeAnimationSimpleState extends State<FadeAnimationSimple> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(milliseconds: (500 * widget.delay).round()),
          () {
        if (mounted) {
          setState(() {
            _isVisible = true;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _isVisible ? 0 : -130, 0),
        child: widget.child,
      ),
    );
  }
}