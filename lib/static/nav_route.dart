enum NavRoute {
  main("/"),
  home("/home"),
  favorite("/favorite"),
  setting("/setting"),
  detailRestaurant('/detail-restaurant');

  const NavRoute(this.route);
  final String route;
}
