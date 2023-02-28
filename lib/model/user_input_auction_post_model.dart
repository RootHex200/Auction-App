class InputAuctionPostModel {
  final String productname;
  final String productdescription;
  final String minimumbidprice;
  final String auctionenddate;
  final List<String> images;
  InputAuctionPostModel({
    required this.productname,
    required this.productdescription,
    required this.minimumbidprice,
    required this.auctionenddate,
    required this.images,
  });
}
