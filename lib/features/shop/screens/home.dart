import 'package:flutter/material.dart';
import 'package:sneakerhead/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:sneakerhead/utils/constants/colors.dart';

import '../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../common/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Container()
            ),
          ],
        ),
      ),
    );
  }
}



