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
    subtitle: "Principal Wallet",
    svgPath: "${Constant.assetSvgPath}cashier.svg",
  ),
  DashboardItemModel(
    title: "5 000 000 FCFA",
    subtitle: "Recharge Wallet (for topup)",
    svgPath: "${Constant.assetSvgPath}cashier.svg",
  ),
  DashboardItemModel(
    title: "1 000 000 FCFA",
    subtitle: "Total Topup Wallets",
    svgPath: "${Constant.assetSvgPath}shop.svg",
  ),
  DashboardItemModel(
    title: "1 000 000 FCFA",
    subtitle: "Total Marchands Wallets",
    svgPath: "${Constant.assetSvgPath}shop.svg",
  ),
  DashboardItemModel(
    title: "4 000 000 FCFA",
    subtitle: "Total Clients Wallets",
    svgPath: "${Constant.assetSvgPath}avatar.svg",
  ),
];
