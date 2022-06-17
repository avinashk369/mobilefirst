import 'package:bloc/bloc.dart';
import 'package:mobilefirst/models/navigation/nav_item.dart';

class NavBloc extends Cubit<NavItem> {
  NavBloc()
      : super(NavItem()
          ..name = "Page1"
          ..index = 0);

  Future<void> changeNavigation(String page, int index) async {
    try {
      NavItem model = NavItem()
        ..name = page
        ..index = index;
      emit(model);
    } catch (_) {}
  }
}
