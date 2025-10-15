import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/router/app_router.dart';
import 'chat_view_model.dart';

class ChatView extends BaseView<ChatViewModel> {
  final VoidCallback? onBack;
  const ChatView({super.key, this.onBack});

  @override
  ChatViewModel createViewModel() => ChatViewModel();

  @override
  Widget buildView(BuildContext context, ChatViewModel viewModel) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              viewModel.isInChatRoom 
                  ? AppAssets.privatebackground
                  : (viewModel.selectedTab == 0
                      ? AppAssets.publicbackground  // Public
                      : AppAssets.privatebackground), // Private
              fit: BoxFit.cover,
            ),
          ),
          
          // Dark overlay
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          
          // Main content
          if (viewModel.isInChatRoom)
            _buildChatRoomView(context, viewModel)
          else
            _buildChatListView(context, viewModel),
        ],
      ),
      floatingActionButton: !viewModel.isInChatRoom && viewModel.selectedTab == 1 
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

  Widget _buildChatListView(BuildContext context, ChatViewModel viewModel) {
    return Stack(
      children: [
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
    );
  }

  Widget _buildChatRoomView(BuildContext context, ChatViewModel viewModel) {
    return SafeArea(
      child: Column(
        children: [
          _buildChatRoomAppBar(context, viewModel),
          Expanded(
            child: _buildChatContent(context, viewModel),
          ),
          _buildInputSection(context, viewModel),
        ],
      ),
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
              onPressed: onBack ?? () => Navigator.pop(context),
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
      // Private chat rooms
      return _buildPrivateChatList(context, viewModel);
    } else {
      // Public chat rooms - show grid view
      return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 cards per row
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85, // Adjust height vs width ratio
        ),
        itemCount: viewModel.chatRooms1.length,
        itemBuilder: (context, index) {
          final room = viewModel.chatRooms1[index];
          return GestureDetector(
            onTap: () {
              viewModel.enterChatRoom(room);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.onPrimary.withOpacity(0.3),
                border: Border.all(
                  color: AppColors.white.withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image section
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.asset(
                        room['image'] ?? AppAssets.post1,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),

                  // Text section
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      room['name'] ?? 'Luna Festival Community',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Widget _buildPrivateChatList(BuildContext context, ChatViewModel viewModel) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 cards per row
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85, // Adjust height vs width ratio
      ),
      itemCount: viewModel.privateChats.length,
      itemBuilder: (context, index) {
        final chat = viewModel.privateChats[index];
        return _buildPrivateChatItem(context, viewModel, chat);
      },
    );
  }


  Widget _buildPrivateChatItem(BuildContext context, ChatViewModel viewModel, Map<String, dynamic> chat) {
    return GestureDetector(
      onTap: () {
        // Navigate to private chat room
        viewModel.enterChatRoom(chat);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.onPrimary.withOpacity(0.3),
          border: Border.all(
            color: AppColors.white.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar section
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(chat['avatar'] ?? AppAssets.profile),
                        backgroundColor: AppColors.onPrimary,
                      ),
                    ),
                    if (chat['unreadCount'] > 0)
                      Positioned(
                        top: 8,
                        right: 8,
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
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (chat['isActive'] == true)
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Text section
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      chat['name'] ?? AppStrings.chatName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      chat['lastMessage'] ?? AppStrings.noMessages,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.grey600,
                        fontSize: 11,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      chat['timestamp'] ?? '12:00',
                      style: const TextStyle(
                        color: AppColors.grey600,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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

  Widget _buildChatRoomAppBar(BuildContext context, ChatViewModel viewModel) {
    return Container(
      height: 60,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: () => viewModel.exitChatRoom(),
          ),
          Expanded(
            child: Text(
              viewModel.currentChatRoom?['name'] ?? AppStrings.lunaCommunityRoom,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.share, color: AppColors.white),
            onPressed: () {
              // Handle share action
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: AppColors.white),
            onPressed: () {
              // Handle favorite action
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.white),
            onPressed: () {
              // Handle more options
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChatContent(BuildContext context, ChatViewModel viewModel) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          // FestivalRumour logo and timestamp
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'FA',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'FestivalRumour 10:05 PM',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Welcome message bubble
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Join the conversation!',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Follow this topic to receive notifications when people respond.',
                    style: TextStyle(
                      color: AppColors.grey600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => viewModel.inviteFriends(),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          AppStrings.inviteYourFriends,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildInputSection(BuildContext context, ChatViewModel viewModel) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Input field row
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.black,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: viewModel.messageController,
                    decoration: const InputDecoration(
                      hintText: AppStrings.typeSomething,
                      hintStyle: TextStyle(color: AppColors.grey600),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(color: AppColors.black),
                    onSubmitted: (_) => viewModel.sendMessage(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => viewModel.sendMessage(),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.send,
                    color: AppColors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


