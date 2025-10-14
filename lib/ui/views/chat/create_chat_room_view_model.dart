import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/router/app_router.dart';
import '../../../core/constants/app_strings.dart';

class CreateChatRoomViewModel extends BaseViewModel {
  final TextEditingController titleController = TextEditingController();
  
  List<Contact> _allContacts = [];
  List<Contact> _festivalContacts = [];
  List<Contact> _nonFestivalContacts = [];
  Set<String> _selectedContacts = {};

  // Contact data for UI
  List<Map<String, dynamic>> _festivalContactData = [];
  List<Map<String, dynamic>> _nonFestivalContactData = [];
  
  // Mock data for festival participants (in real app, this would come from backend)
  final Set<String> _festivalParticipants = {
    AppStrings.robertFox,
    AppStrings.darrellSteward, 
    AppStrings.ronaldRichards,
    AppStrings.marvinMcKinney
  };

  // Mock contacts data for testing
  final List<Map<String, dynamic>> _mockContacts = [
    {
      'name': AppStrings.robertFox,
      'phone': AppStrings.phone0123456789,
      'isFestival': true,
    },
    {
      'name': AppStrings.darrellSteward,
      'phone': AppStrings.phone0123456790,
      'isFestival': true,
    },
    {
      'name': AppStrings.ronaldRichards,
      'phone': AppStrings.phone0123456791,
      'isFestival': true,
    },
    {
      'name': AppStrings.marvinMcKinney,
      'phone': AppStrings.phone0123456792,
      'isFestival': true,
    },
    {
      'name': AppStrings.jeromeBell,
      'phone': AppStrings.phone0123456887,
      'isFestival': false,
    },
    {
      'name': AppStrings.kathrynMurphy,
      'phone': AppStrings.phone0123456987,
      'isFestival': false,
    },
  ];

  List<Contact> get allContacts => _allContacts;
  List<Contact> get festivalContacts => _festivalContacts;
  List<Contact> get nonFestivalContacts => _nonFestivalContacts;
  Set<String> get selectedContacts => _selectedContacts;
  
  // UI data getters
  List<Map<String, dynamic>> get festivalContactData => _festivalContactData;
  List<Map<String, dynamic>> get nonFestivalContactData => _nonFestivalContactData;

  @override
  void init() {
    super.init();
    _loadContacts();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  Future<void> _loadContacts() async {
    await handleAsync(() async {
      // Request contacts permission
      final permission = await Permission.contacts.request();
      
      if (permission.isGranted) {
        // For demo purposes, create mock contacts
        _createMockContacts();
        
        // Filter contacts based on festival participation
        _filterContacts();
        
        notifyListeners();
      } else {
        setError(AppStrings.contactsPermissionDenied);
      }
    }, errorMessage: AppStrings.failedToLoadContacts);
  }

  void _createMockContacts() {
    _allContacts.clear();
    
    for (final mockContact in _mockContacts) {
      final contact = Contact(
        id: mockContact['name'].hashCode.toString(),
        displayName: mockContact['name'],
        phones: [Phone(mockContact['phone'])],
      );
      _allContacts.add(contact);
    }
  }

  void _filterContacts() {
    _festivalContacts.clear();
    _nonFestivalContacts.clear();
    _festivalContactData.clear();
    _nonFestivalContactData.clear();
    
    for (final contact in _allContacts) {
      final displayName = contact.displayName ?? '';
      
      // Find the corresponding mock contact
      final mockContact = _mockContacts.firstWhere(
        (mock) => mock['name'] == displayName,
        orElse: () => {'isFestival': false},
      );
      
      final contactData = {
        'id': contact.id,
        'name': displayName,
        'phone': contact.phones.isNotEmpty 
            ? contact.phones.first.number
            : '',
        'isFestival': mockContact['isFestival'],
      };
      
      if (mockContact['isFestival'] == true) {
        _festivalContacts.add(contact);
        _festivalContactData.add(contactData);
      } else {
        _nonFestivalContacts.add(contact);
        _nonFestivalContactData.add(contactData);
      }
    }
  }

  void toggleContactSelection(String contactId) {
    if (_selectedContacts.contains(contactId)) {
      _selectedContacts.remove(contactId);
    } else {
      _selectedContacts.add(contactId);
    }
    notifyListeners();
  }

  bool isContactSelected(String contactId) {
    return _selectedContacts.contains(contactId);
  }

  void inviteContact(String contactName, String phoneNumber) {
    // Handle invite functionality
    // In a real app, this would send an invitation via SMS or other method
    print('${AppStrings.invitingToJoinLunaFest.replaceAll('{contactName}', contactName).replaceAll('{phoneNumber}', phoneNumber)}');
    
    // Show success message
    setError(null);
    // You could show a success snackbar here
  }

  void createChatRoom(BuildContext context) {
    if (titleController.text.trim().isEmpty) {
      setError(AppStrings.pleaseEnterChatRoomTitle);
      return;
    }
    
    if (_selectedContacts.isEmpty) {
      setError(AppStrings.pleaseSelectAtLeastOneContact);
      return;
    }
    
    // Handle chat room creation
    print('${AppStrings.creatingChatRoom}${titleController.text}');
    print('${AppStrings.selectedContacts}$_selectedContacts');
    
    // Here you would typically save to backend/database
    // For now, we'll just navigate to the chat room
    
    setError(null);
    Navigator.pushNamed(context, AppRoutes.chatRoom);
  }

  void refreshContacts() {
    _loadContacts();
  }
}
