import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sneakerhead/common/widgets/appbar/appbar.dart';
import 'package:sneakerhead/features/personalization/controllers/address_controller.dart';
import 'package:sneakerhead/features/personalization/screens/address/add_new_address.dart';
import 'package:sneakerhead/features/personalization/screens/address/widgets/single_address.dart';
import 'package:sneakerhead/utils/constants/colors.dart';
import 'package:sneakerhead/utils/constants/sizes.dart';
import 'package:sneakerhead/utils/helpers/cloud_helper_functions.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
              // Use key to trigger refresh
              key: Key(controller.refreshData.value.toString()),
              future: controller.getallUserAddresses(),
              builder: (context, snapshot) {
                // Helper Function: Handle Loader, No Record, OR ERROR Message
                final response = TCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                );
                if (response != null) return response;

                final addresses = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: addresses.length,
                  itemBuilder:
                      (_, index) => TSingleAddress(
                        address: addresses[index],
                        onTap: () => controller.selectAddress(addresses[index]),
                      ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Iconsax.add, color: TColors.white),
      ),
    );
  }
}
