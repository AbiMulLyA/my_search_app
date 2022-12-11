// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:my_search_app/core/widget/container_widget.dart';
import 'package:my_search_app/module/presentation/cubit/city/city_cubit.dart';

import '../../../core/widget/space_widget.dart';
import '../../domain/entity/city_entity.dart';

class SearchFilterView extends StatefulWidget {
  final ValueNotifier<Map<String, String>> cityFilter;

  const SearchFilterView({
    Key? key,
    required this.cityFilter,
  }) : super(key: key);

  @override
  State<SearchFilterView> createState() => _SearchFilterViewState();
}

class _SearchFilterViewState extends State<SearchFilterView> {
  // final cityFilter = ValueNotifier<Map<String, String>>({
  //   'id': '',
  //   'name': '',
  // });

  @override
  Widget build(BuildContext context) {
    return ContainerWidgetDefaultMargin(
      child: Column(
        children: [
          BlocConsumer<CityCubit, CityState>(
            listener: (context, state) {
              debugPrint('Listener CityBlocss: ${state.status}');
            },
            builder: (context, state) {
              debugPrint('CityStatess: ${state.status}');
              if (state.status == CityStateStatus.loading) {
                return Container(
                  padding: EdgeInsets.only(bottom: 50.r),
                  // child: const LoaderWidgetSpinkit(
                  //   type: SpinkitType.threeBounce,
                  // ),
                );
              }

              final List<CityEntity> categories = [];
              if (state.data.isNotEmpty) {
                categories.addAll([
                  const CityEntity(
                    id: '',
                    name: 'Semua',
                  )
                ]);
                categories.addAll(state.data);
              }

              return categories.isEmpty
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'City',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SpaceWidgetHeight(height: 15.h),
                        Wrap(
                          spacing: 5.r,
                          children: List.generate(
                            categories.length,
                            (index) {
                              return ValueListenableBuilder(
                                valueListenable: widget.cityFilter,
                                builder:
                                    (_, Map<String, String> valueNotif, __) {
                                  if (categories[index].id ==
                                      widget.cityFilter.value['id']) {
                                    // check include

                                  }

                                  return Material(
                                    type: MaterialType.transparency,
                                    child: ChoiceChip(
                                      backgroundColor: Colors.white,
                                      selectedColor: Colors.blue.shade200,
                                      side:
                                          const BorderSide(color: Colors.grey),
                                      label: Text(categories[index].name),
                                      pressElevation: 0,
                                      selected: categories[index].id ==
                                              valueNotif['id']
                                          ? true
                                          : false,
                                      onSelected: (bool value) {
                                        if (value) {
                                          widget.cityFilter.value = {
                                            'id': categories[index].id,
                                            'name': categories[index].name
                                          };
                                        }
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        SpaceWidgetHeight(height: 15.h),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }
}
