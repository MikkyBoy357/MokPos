import '../../base/constant.dart';

class DashboardItemModel {
  String title;
  String subtitle;
  String svgPath;

  DashboardItemModel({
    required this.title,
    required this.subtitle,
    required this.svgPath,
  });
}

List<DashboardItemModel> dasboardItems = [
  DashboardItemModel(
    title: "5 000 000 FCFA",
    subtitle: "Solde Recharge",
    svgPath: "${Constant.assetSvgPath}cashier.svg",
  ),
  DashboardItemModel(
    title: "1 000 000 FCFA",
    subtitle: "Solde Achat (POS)",
    svgPath: "${Constant.assetSvgPath}shop.svg",
  ),
  DashboardItemModel(
    title: "4 000 000 FCFA",
    subtitle: "Solde Carte Client",
    svgPath: "${Constant.assetSvgPath}avatar.svg",
  ),
];
