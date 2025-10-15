import 'package:festival_rumour/core/constants/app_assets.dart';
import 'package:festival_rumour/core/constants/app_colors.dart';
import 'package:festival_rumour/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import 'festivals_job_post_view_model.dart';

class FestivalsJobPostView extends BaseView<FestivalsJobPostViewModel> {
  const FestivalsJobPostView({super.key});

  @override
  FestivalsJobPostViewModel createViewModel() => FestivalsJobPostViewModel();

  @override
  Widget buildView(BuildContext context, FestivalsJobPostViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when tapping outside
        viewModel.unfocusAllFields();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Post Festival Job",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                AppAssets.bottomsheet,
                fit: BoxFit.cover,
              ),
            ),
            
            // Main Content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      
                      // Job Post Form
                      _buildJobPostForm(context, viewModel),
                      
                      const SizedBox(height: 20),
                      
                      // Post Job Button
                      _buildPostButton(context, viewModel),
                      
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobPostForm(BuildContext context, FestivalsJobPostViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.yellow, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            "Job Details",
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Job Title Field
          _buildTextField(
            controller: viewModel.jobTitleController,
            focusNode: viewModel.jobTitleFocusNode,
            label: "Job Title",
            hint: "e.g., Audio Visual Technician",
            icon: Icons.work,
          ),
          
          const SizedBox(height: 16),
          
          // Company/Organization Field
          _buildTextField(
            controller: viewModel.companyController,
            focusNode: viewModel.companyFocusNode,
            label: "Company/Organization",
            hint: "e.g., Festival Productions Inc.",
            icon: Icons.business,
          ),
          
          const SizedBox(height: 16),
          
          // Location Field
          _buildTextField(
            controller: viewModel.locationController,
            focusNode: viewModel.locationFocusNode,
            label: "Location",
            hint: "e.g., Miami, Florida",
            icon: Icons.location_on,
          ),
          
          const SizedBox(height: 16),
          
          // Job Type Dropdown
          _buildDropdownField(
            value: viewModel.selectedJobType,
            label: "Job Type",
            icon: Icons.category,
            items: viewModel.jobTypes,
            onChanged: (value) => viewModel.setJobType(value!),
          ),
          
          const SizedBox(height: 16),
          
          // Salary Field
          _buildTextField(
            controller: viewModel.salaryController,
            focusNode: viewModel.salaryFocusNode,
            label: "Salary (Optional)",
            hint: "e.g., \$25-35/hour or \$50,000/year",
            icon: Icons.attach_money,
            keyboardType: TextInputType.text,
          ),
          
          const SizedBox(height: 16),
          
          // Job Description
          _buildTextAreaField(
            controller: viewModel.descriptionController,
            focusNode: viewModel.descriptionFocusNode,
            label: "Job Description",
            hint: "Describe the job responsibilities, requirements, and what you're looking for...",
            icon: Icons.description,
            maxLines: 5,
          ),
          
          const SizedBox(height: 16),
          
          // Requirements
          _buildTextAreaField(
            controller: viewModel.requirementsController,
            focusNode: viewModel.requirementsFocusNode,
            label: "Requirements (Optional)",
            hint: "List any specific skills, experience, or qualifications needed...",
            icon: Icons.checklist,
            maxLines: 3,
          ),
          
          const SizedBox(height: 16),
          
          // Contact Information
          _buildTextField(
            controller: viewModel.contactController,
            focusNode: viewModel.contactFocusNode,
            label: "Contact Information",
            hint: "Email or phone number for applications",
            icon: Icons.contact_mail,
            keyboardType: TextInputType.emailAddress,
          ),
          
          const SizedBox(height: 16),
          
          // Festival Date
          _buildTextField(
            controller: viewModel.festivalDateController,
            focusNode: viewModel.festivalDateFocusNode,
            label: "Festival Date",
            hint: "e.g., March 15-17, 2024",
            icon: Icons.calendar_today,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.yellow, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.yellow,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            filled: true,
            fillColor: Colors.black.withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.yellow.withOpacity(0.5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.yellow.withOpacity(0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.yellow, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildTextAreaField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 3,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.yellow, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.yellow,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          focusNode: focusNode,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            filled: true,
            fillColor: Colors.black.withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.yellow.withOpacity(0.5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.yellow.withOpacity(0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.yellow, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String value,
    required String label,
    required IconData icon,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.yellow, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.yellow,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.yellow.withOpacity(0.5)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              dropdownColor: Colors.black.withOpacity(0.9),
              style: const TextStyle(color: Colors.white),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.yellow),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  onChanged(newValue);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPostButton(BuildContext context, FestivalsJobPostViewModel viewModel) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.yellow, Colors.orange],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: viewModel.isLoading ? null : () => viewModel.postJob(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: viewModel.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.post_add, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Post Job",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
