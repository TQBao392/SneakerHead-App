import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakerhead/common/widgets/appbar/appbar.dart';
import 'package:sneakerhead/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:sneakerhead/common/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';
import 'package:sneakerhead/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:sneakerhead/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:sneakerhead/utils/constants/colors.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
                child: Column(
                  children: [
                    TAppBar(title: Column(
                      children: [
                        Text(TTexts.homeAppbarTitle, style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: 5),
                        Text('Your one-stop shop for sneakers', style: Theme.of(context).textTheme.bodyMedium)
                      ],
                    )),
                    ),)
                  ],
                )
              ),
            ],
        ),
    ),
    );
  }
}

