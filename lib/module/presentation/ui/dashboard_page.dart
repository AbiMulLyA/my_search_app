import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_search_app/module/presentation/cubit/city/city_cubit.dart';
import 'package:my_search_app/module/presentation/ui/search_filter_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/util/error_util.dart';
import '../../../core/util/global_util.dart';
import '../../../core/util/lang_util.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/container_widget.dart';
import '../../../core/widget/custom_widget.dart';
import '../../../core/widget/list_tile_widget.dart';
import '../../../core/widget/loader_widget.dart';
import '../../../core/widget/platform_widget.dart';
import '../../../core/widget/pull_refresh_widget.dart';
import '../../../core/widget/space_widget.dart';
import '../bloc/user/user_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _textController = TextEditingController();
  final _refreshController = RefreshController(initialRefresh: false);
  final _nameCtr = TextEditingController();
  final _emailCtr = TextEditingController();
  final _addressCtr = TextEditingController();
  final _phoneNumberCtr = TextEditingController();
  final _cityCtr = TextEditingController();
  final cityFilter = ValueNotifier<Map<String, String>>({
    'id': '',
    'name': '',
  });
  String name = '';
  final String city = '';

  @override
  void initState() {
    super.initState();
    context.read<CityCubit>().fetchCity();

    _refreshController.dispose;
  }

  @override
  Widget build(BuildContext context) {
    final _lang = LangUtil.of(context);

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Search',
            ),
          ),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  floating: true,
                  pinned: true,
                  backgroundColor: Colors.white,
                  elevation: 1,
                  toolbarHeight: 70.h,
                  collapsedHeight: 70.h,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15.r, right: 15.r),
                          height: 30.h,
                          color: Colors.white,
                          child: TextField(
                            controller: _textController,
                            textInputAction: TextInputAction.search,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                            onChanged: (textValue) {
                              name = textValue;
                              if (textValue.length >= 3) {
                                context.read<UserBloc>().add(
                                      UserListFetchEv(
                                        name: textValue,
                                      ),
                                    );
                              } else {
                                context.read<UserBloc>().add(
                                      const UserListFetchEv(),
                                    );
                              }
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey[500],
                                size: 16.sp,
                              ),
                              suffixIcon: (_textController.text == '')
                                  ? null
                                  : Icon(
                                      MdiIcons.closeCircle,
                                      color: Colors.grey[500],
                                      size: 16.sp,
                                    ),
                              contentPadding: EdgeInsets.all(0.r),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.r),
                                ),
                              ),
                              filled: true,
                              hintText: _lang.trans('global_search_content'),
                            ),
                            onSubmitted: (String words) async {},
                          ),
                        ),
                        SpaceWidgetHeight(
                          height: 3.h,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15.r),
                          child: ChoiceChip(
                            backgroundColor: Colors.white,
                            selectedColor: Colors.blue.shade200,
                            side: const BorderSide(color: Colors.grey),
                            label: const Text(
                              'Filter',
                            ),
                            selected: false,
                            onSelected: (bool value) {
                              GlobalUtil.showSlidingSheet(
                                context,
                                content: SearchFilterView(
                                  cityFilter: cityFilter,
                                ),
                                footer: Container(
                                  margin: EdgeInsets.only(bottom: 15.r),
                                  child: ButtonWidget(
                                    solidColor: Colors.blue,
                                    height: 35.h,
                                    width: 0.8.sw,
                                    borderRadius: 20.r,
                                    borderWidth: 1.r,
                                    boxShadow: false,
                                    child: InkWell(
                                      onTap: () {
                                        context.read<UserBloc>().add(
                                              UserListFetchEv(
                                                  city:
                                                      cityFilter.value['name']),
                                            );
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: Padding(
                                        padding: EdgeInsets.all(5.r),
                                        child: Center(
                                          child: Text(
                                            'Terapkan',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            avatar: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.tune_outlined,
                                size: 18.sp,
                              ),
                            ),
                          ),
                        ),
                        SpaceWidgetHeight(
                          height: 3.h,
                        ),
                        if (state.status == UserStateStatus.loading) ...[
                          SingleChildScrollView(
                            child: LinearProgressIndicator(
                              minHeight: 2.h,
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state.status == UserStateStatus.failed) {
                    if (state.error['type'] == ErrorType.noInternet) {
                    } else {
                      if (state.error['code'] != 404) {
                        ErrorUtil.networkError(
                          context: context,
                          errorState: state.error,
                        );
                      }
                    }
                  }
                  _refreshController.refreshCompleted();
                },
                builder: (context, state) {
                  if (state.status == UserStateStatus.loading) {
                  } else {}
                  if (state.status == UserStateStatus.initial ||
                      (state.data.isEmpty &&
                          state.status != UserStateStatus.failed)) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: 10.r,
                        left: 15.r,
                        right: 15.r,
                      ),
                      child: const LoaderWidgetShimmerListAvatar(numRows: 15),
                    );
                  } else {
                    if (state.data.isEmpty) {
                      return ListTileWidget(
                        title: _lang.trans('global_search_not_found'),
                        subTitle: name,
                        subTitle2: _lang.trans('global_search_not_found_desc'),
                        leading: ContainerWidgetBox(
                          height: 40.h,
                          width: 40.h,
                          child: Icon(
                            Icons.help,
                            color: Colors.white,
                            size: 30.sp,
                          ),
                        ),
                        tap: () => {},
                        deviderSize: 0,
                        paddingTop: 10.r,
                        paddingBottom: 0.r,
                        paddingRight: 15.r,
                        paddingLeft: 15.r,
                        trailing: const SizedBox(),
                        margin: 0.r,
                        isDivider: false,
                        color: Colors.blue,
                      );
                    } else {
                      return SafeArea(
                        top: false,
                        bottom: false,
                        child: Scrollbar(
                          child: PullRefreshWidget(
                            controller: _refreshController,
                            onRefresh: () {
                              context.read<UserBloc>().add(
                                    const UserListFetchEv(),
                                  );
                            },
                            child: ListView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTileWidget(
                                    title: state.data[index].name,
                                    subTitle: state.data[index].city,
                                    deviderSize: 0,
                                    isDivider: true,
                                  );
                                },
                                itemCount: state.data.length),
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              GlobalUtil.showSlidingSheet(
                context,
                content: Material(
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
                ),
                footer: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 15.r),
                      child: ButtonWidget(
                        solidColor: Colors.blue,
                        height: 35.h,
                        width: 0.8.sw,
                        borderRadius: 20.r,
                        borderWidth: 1.r,
                        boxShadow: false,
                        child: InkWell(
                          onTap: () {
                            context.read<UserBloc>().add(
                                  AddUserEv(
                                      name: _nameCtr.text,
                                      email: _emailCtr.text,
                                      phoneNumber: _phoneNumberCtr.text,
                                      address: _addressCtr.text,
                                      city: _cityCtr.text),
                                );
                            if (state.status == UserStateStatus.succeed) {
                              // _nameCtr.dispose();
                              // _emailCtr.dispose();
                              // _phoneNumberCtr.dispose();
                              // _addressCtr.dispose();
                              // _cityCtr.dispose();
                              // Navigator.pop(context);
                            }
                          },
                          borderRadius: BorderRadius.circular(20.r),
                          child: Padding(
                            padding: EdgeInsets.all(5.r),
                            child: Center(
                              child: state.status == UserStateStatus.loading
                                  ? PlatformWidgetLoader(
                                      size: 25.sp, bgColor: Colors.white)
                                  : Text(
                                      'Terapkan',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            label: const Text(
              'Add User',
            ),
            icon: Icon(
              Icons.add,
              size: 18.sp,
            ),
          ),
        );
      },
    );
  }
}
