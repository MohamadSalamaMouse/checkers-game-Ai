import 'package:flutter_bloc/flutter_bloc.dart';
import 'state.dart';

class MainPageController extends Cubit<MainPageState>
{
  MainPageController() :super(MainPageInit());
  static MainPageController of(context)=> BlocProvider.of(context);

  // @override
  // Future<void> close() {
  //   phoneController.dispose();
  //   return super.close();
  // }
}