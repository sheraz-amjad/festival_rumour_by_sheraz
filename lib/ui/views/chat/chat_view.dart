import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/router/app_router.dart';
import 'chat_view_model.dart';

class ChatView extends BaseView<ChatViewModel> {
  const ChatView({super.key});

  @override
  ChatViewModel createViewModel() => ChatViewModel();

  @override
  Widget buildView(BuildContext context, ChatViewModel viewModel) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          // Background image
          // Dynamic background image
          Positioned.fill(
            child: Image.asset(
              viewModel.selectedTab == 0
                  ? AppAssets.publicbackground  // Public
                  : AppAssets.privatebackground, // Private
              fit: BoxFit.cover,
            ),
          ),
          
          // Dark overlay
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          
          // App bar (extends into status bar)
          _buildAppBar(context),
          
          // Main content (below app bar)
          Positioned(
            top: MediaQuery.of(context).padding.top + 70, // Status bar + app bar height
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                _buildSegmentedControl(context, viewModel),
                const SizedBox(height: 20),
                Expanded(
                  child: _buildChatRooms(context, viewModel),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: viewModel.selectedTab == 1 
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.createChatRoom);
              },
              backgroundColor: AppColors.accent,
              child: const Icon(
                Icons.chat,
                color: AppColors.black,
              ),
            )
          : null,
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 16,
          right: 16,
          bottom: 12,
        ),
        decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.5),
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.white),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Text(
                AppStrings.chatRooms,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentedControl(BuildContext context, ChatViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => viewModel.setSelectedTab(0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: viewModel.selectedTab == 0 ? AppColors.accent : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.public,
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppStrings.public,
                      style: TextStyle(
                        color: viewModel.selectedTab == 0 ? AppColors.black : AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => viewModel.setSelectedTab(1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: viewModel.selectedTab == 1 ? AppColors.accent : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.private,
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppStrings.private,
                      style: TextStyle(
                        color: viewModel.selectedTab == 1 ? AppColors.black : AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatRooms(BuildContext context, ChatViewModel viewModel) {
    if (viewModel.selectedTab == 1) {
      // Private chat rooms - show list format
      return _buildPrivateChatList(context, viewModel);
    } else {
      // Public chat rooms - show card format
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: viewModel.chatRooms.length,
        itemBuilder: (context, index) {
          final room = viewModel.chatRooms[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
          );
        },
      );
    }
  }

  Widget _buildPrivateChatList(BuildContext context, ChatViewModel viewModel) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.onPrimary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          //const SizedBox(height: 10),
          // Chat list
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.privateChats.length,
              itemBuilder: (context, index) {
                final chat = viewModel.privateChats[index];
                return _buildPrivateChatItem(context, chat);
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildPrivateChatItem(BuildContext context, Map<String, dynamic> chat) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Avatar with unread badge
          Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage(chat['avatar'] ?? ''),
                backgroundColor: AppColors.onPrimary,
              ),
              if (chat['unreadCount'] > 0)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${chat['unreadCount']}',
                        style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          
          // Chat info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat['name'] ?? AppStrings.chatName,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  chat['lastMessage'] ?? AppStrings.noMessages,
                  style: const TextStyle(
                    color: AppColors.grey600,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Timestamp and status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                chat['timestamp'] ?? AppStrings.timestamp0000,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              if (chat['isActive'] == true)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      child: Column(
        children: [
          // Top row - two cards side by side
          Row(
            children: [
              Expanded(
                child: _buildCard(
                  context,
                  AppStrings.lunaNews,
                  AppAssets.news,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.news),
                ),
              ),
              const SizedBox(width: AppDimensions.spaceM),

        ],
      ),
    ],
      )
    );
  }

  Widget _buildCard(
      BuildContext context,
      String title,
      String imagePath, {
        bool isFullWidth = false,
        VoidCallback? onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),

              // Background layer at the bottom (30% height)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 220 * 0.3, // 30% of container height
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),

              // Centered text within background layer
              Positioned(
                bottom: AppDimensions.paddingM,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: AppDimensions.textXL,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


