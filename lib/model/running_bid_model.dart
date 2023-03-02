

class RunningBidModel {

  final DateTime time;
  final int bidnumber;
  RunningBidModel({
    required this.time,
    required this.bidnumber,
  });
  
}


class CompletedBidModel {

  final DateTime time;
  final int bidnumber;
  CompletedBidModel({
    required this.time,
    required this.bidnumber,
  });
  
}

class CompletedBidTotalValueModel {

  final DateTime time;
  final int bidpirce;
  CompletedBidTotalValueModel({
    required this.time,
    required this.bidpirce,
  });
  
}