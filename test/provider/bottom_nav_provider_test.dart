import 'package:flutter_test/flutter_test.dart';
import 'package:madang_app/provider/bottom_nav_provider.dart';

void main() {
  late BottomNavProvider provider;

  setUp(() {
    provider = BottomNavProvider();
  });

  test("Test Provider", () {
    //arrange
    final bottomNav = provider.indexBottomNav;

    //act
    provider.setIndexBottomNav = 1;
    final state = provider.indexBottomNav;

    //assert
    expect(bottomNav, 0);
    expect(state, 1);
  });
 
}