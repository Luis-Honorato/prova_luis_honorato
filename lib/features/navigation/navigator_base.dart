import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prova_luis_honorato/features/coins/presentation/pages/coins_page.dart';
import 'package:prova_luis_honorato/features/navigation/cubit/navigator_cubit.dart';
import 'package:prova_luis_honorato/features/todo/presentation/pages/todo_page.dart';
import 'package:prova_luis_honorato/features/weather/presentation/pages/wather_page.dart';

class NavigatorBase extends StatefulWidget {
  const NavigatorBase({super.key});

  @override
  State<NavigatorBase> createState() => _NavigatorBaseState();
}

class _NavigatorBaseState extends State<NavigatorBase>
    with AutomaticKeepAliveClientMixin {
  late final PageController _pageController;
  late final NavigatorCubit navigatorCubit;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
    navigatorCubit = NavigatorCubit();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: navigatorCubit,
      child: BlocBuilder<NavigatorCubit, int>(
        bloc: navigatorCubit,
        builder: (context, pageIndex) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: pageIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.cloud), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.monetization_on), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
              ],
              onTap: (page) async {
                _pageController.jumpToPage(
                  page,
                );
                navigatorCubit.setCurrentPage(page);
              },
              type: BottomNavigationBarType.fixed,
            ),
            body: PageView(
              controller: _pageController,
              onPageChanged: (value) => navigatorCubit.setCurrentPage(value),
              children: const [
                WeatherPage(),
                CoinsPage(),
                TodoPage(),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
