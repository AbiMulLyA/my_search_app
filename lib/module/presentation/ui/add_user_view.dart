// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_search_app/core/widget/container_widget.dart';

import '../../../core/widget/custom_widget.dart';
import '../../../core/widget/space_widget.dart';

class AddUserView extends StatelessWidget {
  const AddUserView({super.key});

  @override
  Widget build(BuildContext context) {
    final _nameCtr = TextEditingController();
    final _emailCtr = TextEditingController();
    final _addressCtr = TextEditingController();
    final _phoneNumberCtr = TextEditingController();
    final _cityCtr = TextEditingController();
    return Material(
      child: ContainerWidgetDefaultMargin(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add User',
              style: Theme.of(context).textTheme.headline5,
            ),
            SpaceWidgetHeight(
              height: 10.h,
            ),
            TextFormField(
              key: const Key('name'),
              controller: _nameCtr,
              textInputAction: TextInputAction.next,
              autofocus: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: CustomWidget().formDecoration(
                'Name',
              ),
              validator: (value) {
                if (StringUtils.isNullOrEmpty(value)) {
                  return 'Data tidak boleh kosong!';
                }
                return null;
              },
            ),
            SpaceWidgetHeight(
              height: 10.h,
            ),
            TextFormField(
              key: const Key('email'),
              controller: _emailCtr,
              textInputAction: TextInputAction.next,
              autofocus: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: CustomWidget().formDecoration(
                'Émail',
              ),
              validator: (value) {
                if (StringUtils.isNullOrEmpty(value)) {
                  return 'Data tidak boleh kosong!';
                }
                return null;
              },
            ),
            SpaceWidgetHeight(
              height: 10.h,
            ),
            TextFormField(
              key: const Key('phoneNumber'),
              controller: _phoneNumberCtr,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              autofocus: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: CustomWidget().formDecoration(
                'Phone Number',
              ),
              validator: (value) {
                if (StringUtils.isNullOrEmpty(value)) {
                  return 'Data tidak boleh kosong!';
                }
                return null;
              },
            ),
            SpaceWidgetHeight(
              height: 10.h,
            ),
            TextFormField(
              key: const Key('address'),
              controller: _addressCtr,
              textInputAction: TextInputAction.next,
              autofocus: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: CustomWidget().formDecoration(
                'Address',
              ),
              validator: (value) {
                if (StringUtils.isNullOrEmpty(value)) {
                  return 'Data tidak boleh kosong!';
                }
                return null;
              },
            ),
            SpaceWidgetHeight(
              height: 10.h,
            ),
            TextFormField(
              key: const Key('city'),
              controller: _cityCtr,
              textInputAction: TextInputAction.next,
              autofocus: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: CustomWidget().formDecoration(
                'City',
              ),
              validator: (value) {
                if (StringUtils.isNullOrEmpty(value)) {
                  return 'Data tidak boleh kosong!';
                }
                return null;
              },
            ),
            SpaceWidgetHeight(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
