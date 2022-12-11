// Dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../widget/line_widget.dart';
import '../widget/space_widget.dart';

const String kDatabaseName = 'app_database.db';
const String kNoInternet = 'Tidak ada koneksi internet..';
const String kHasInternet = 'Ok, Terhubung ke internet..';
const String kLocalError = 'Local Error';
const String kUnknownError = 'Unknown Error';
const String kTimeoutError = 'Request Timeout';

class GlobalUtil {
  //* debugPrintSynchronouslyWithText
  static void debugPrintSynchronouslyWithText(String? message, String? version,
      {int? wrapWidth}) {
    final dateToday = DateFormat.yMd().add_Hms().format(DateTime.now());
    message = "[$dateToday]: $message";
    debugPrintSynchronously(message, wrapWidth: wrapWidth);
  }

  static void showSlidingSheet(
    BuildContext context, {
    Widget? header,
    Widget? content,
    Widget? footer,
    bool useScrollbar = true,
    double snapHeight = 0.95,
  }) async {
    final result = await showSlidingBottomSheet(
      context,
      builder: (context) {
        return SlidingSheetDialog(
          cornerRadius: 16.r,
          isDismissable: true,
          dismissOnBackdropTap: true,
          isBackdropInteractable: true,
          minHeight: snapHeight.sh,
          snapSpec: SnapSpec(
            snap: true,
            initialSnap: snapHeight,
            snappings: [
              snapHeight,
            ],
          ),
          scrollSpec: ScrollSpec(
            showScrollbar: useScrollbar,
          ),
          onDismissPrevented: (backButton, backDrop) async {
            HapticFeedback.heavyImpact();

            debugPrint('Dismiss prevented');
          },
          headerBuilder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SpaceWidgetHeight(),
                const LineWidgetHor(),
                const SpaceWidgetHeight(),
                header ?? const SizedBox(),
              ],
            );
          },
          builder: (context, state) {
            return content ?? const SizedBox();
          },
          footerBuilder: (context, state) {
            return footer ?? const SizedBox();
          },
        );
      },
    );
    debugPrint(result.toString());
  }
}
