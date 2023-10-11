// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:app/ui/widgets/image_carousel.dart';
import 'package:app/ui/widgets/image_provider.dart';
import 'package:app/ui/widgets/local_name_autocomplete.dart';
import 'package:app/ui/widgets/location_tracker.dart';
import 'package:app/ui/widgets/simple_card.dart';

const String PLACEHOLDER_IMG = 'assets/images/placeholder-bee.png';

class CreateSightingForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final List<File> images;
  final Function onDeleteImage;

  const CreateSightingForm(
      {super.key,
      required this.formKey,
      this.images = const [],
      required this.onDeleteImage});

  @override
  State<CreateSightingForm> createState() => _CreateSightingFormState();
}

class _CreateSightingFormState extends State<CreateSightingForm> {
  final nameInput = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MeliCameraProviderInherited.of(context)
        .retrieveLostData()
        .then((file) => {if (file != null) this.widget.images.add(file)});
  }

  @override
  void dispose() {
    nameInput.dispose();
    super.dispose();
  }

  void _onDeleteImageAlert(int imageIndex) {
    final t = AppLocalizations.of(context)!;

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(t.imageDeleteAlertTitle),
        content: Text(t.imageDeleteAlertBody),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'No'),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              this.widget.onDeleteImage(imageIndex);
              Navigator.pop(context, 'Yes');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(t.imageDeleteConfirmation),
              ));
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: this.widget.formKey,
        child: Wrap(
          runSpacing: 20.0,
          children: [
            this.widget.images.isEmpty
                ? ImageCarousel(images: [Image.asset(PLACEHOLDER_IMG)])
                : ImageCarousel(
                    images: this
                        .widget
                        .images
                        .map((file) => Image.file(file))
                        .toList(),
                    onDelete: _onDeleteImageAlert),
            SimpleCard(
                title: 'Local Name', child: LocalNameAutocomplete()),
            LocationTrackerInput(onPositionChanged: (position) {
              if (position == null) {
                print('Position: n/a');
              } else {
                print('Position: $position');
              }
            }),
          ],
        ));
  }
}
