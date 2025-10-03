import 'package:flutter/material.dart';
import '../../../core/utils/base_view.dart';
import '../../../core/constants/app_strings.dart';
import 'wallet_view_model.dart';

class WalletView extends BaseView<WalletViewModel> {
  const WalletView({super.key});

  @override
  WalletViewModel createViewModel() => WalletViewModel();

  @override
  Widget buildView(BuildContext context, WalletViewModel viewModel) {
    return const Scaffold(
      body: Center(child: Text(AppStrings.wallet)),
    );
  }
}


