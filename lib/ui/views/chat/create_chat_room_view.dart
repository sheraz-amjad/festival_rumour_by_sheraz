import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/router/app_router.dart';
import 'create_chat_room_view_model.dart';

class CreateChatRoomView extends BaseView<CreateChatRoomViewModel> {
  const CreateChatRoomView({super.key});

  @override
  CreateChatRoomViewModel createViewModel() => CreateChatRoomViewModel();

  @override
  Widget buildView(BuildContext context, CreateChatRoomViewModel viewModel) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              AppAssets.bottomsheet,
              fit: BoxFit.cover,
            ),
          ),
          
          // Dark overlay
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          
          // Main content
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(context),
                Expanded(
                  child: _buildContent(context, viewModel),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ),
          const Expanded(
            child: Text(
              AppStrings.createChatRoom,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          const SizedBox(width: 40), // Balance the back button
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, CreateChatRoomViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleSection(context, viewModel),
          const SizedBox(height: 20),
          _buildContactsHeader(),
          const SizedBox(height: 16),
          Expanded(
            child: _buildContactsList(context, viewModel),
          ),
          _buildSaveButton(context, viewModel),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context, CreateChatRoomViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey600),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.black,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.group,
              color: AppColors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: viewModel.titleController,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontFamily: 'Montserrat',
              ),
              decoration: const InputDecoration(
                hintText: AppStrings.addTitle,
                hintStyle: TextStyle(
                  color: AppColors.grey400,
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsHeader() {
    return const Text(
      AppStrings.peopleFromContacts,
      style: TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
    );
  }

  Widget _buildContactsList(BuildContext context, CreateChatRoomViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.accent,
        ),
      );
    }

    return ListView(
      children: [
        // Festival contacts
        ...viewModel.festivalContactData.map((contactData) => 
          _buildContactItem(context, viewModel, contactData, true)
        ),
        
        // Non-festival contacts
        ...viewModel.nonFestivalContactData.map((contactData) => 
          _buildContactItem(context, viewModel, contactData, false)
        ),
      ],
    );
  }

  Widget _buildContactItem(BuildContext context, CreateChatRoomViewModel viewModel, Map<String, dynamic> contactData, bool isFestivalContact) {
    final contactId = contactData['id'] ?? '';
    final displayName = contactData['name'] ?? AppStrings.unknown;
    final phoneNumber = contactData['phone'] ?? '';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey600),
      ),
      child: Row(
        children: [
          _buildAvatar(displayName),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isFestivalContact ? AppStrings.iAmUsingLuna : phoneNumber,
                  style: TextStyle(
                    color: isFestivalContact ? AppColors.grey400 : AppColors.grey300,
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
          if (isFestivalContact)
            _buildSelectionButton(context, viewModel, contactId)
          else
            _buildInviteButton(context, viewModel, displayName, phoneNumber),
        ],
      ),
    );
  }

  Widget _buildAvatar(String name) {
    final colors = [
      Colors.purple,
      Colors.orange,
      Colors.grey,
      Colors.yellow,
      Colors.blue,
      Colors.pink,
    ];
    
    final colorIndex = name.hashCode % colors.length;
    final color = colors[colorIndex];
    
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.accent, width: 2),
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionButton(BuildContext context, CreateChatRoomViewModel viewModel, String contactId) {
    final isSelected = viewModel.isContactSelected(contactId);
    
    return GestureDetector(
      onTap: () => viewModel.toggleContactSelection(contactId),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.grey400,
            width: 2,
          ),
        ),
        child: isSelected
            ? const Icon(
                Icons.check,
                color: AppColors.black,
                size: 16,
              )
            : null,
      ),
    );
  }

  Widget _buildInviteButton(BuildContext context, CreateChatRoomViewModel viewModel, String name, String phoneNumber) {
    return GestureDetector(
      onTap: () => viewModel.inviteContact(name, phoneNumber),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.error),
        ),
        child: const Text(
          AppStrings.invite,
          style: TextStyle(
            color: AppColors.error,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context, CreateChatRoomViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () => viewModel.createChatRoom(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          AppStrings.save,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
