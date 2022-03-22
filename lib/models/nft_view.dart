class NFTView {
  final String imageSrc;
  final String authorIcon;
  final String authorName;
  final String pieceName;
  final String username;
  final double currentPrice;
  final double highestBid;
  final String id;
  final String description;
  final String token;

  const NFTView(
      {required this.imageSrc,
      required this.authorIcon,
      required this.authorName,
      required this.currentPrice,
      required this.id,
      required this.pieceName,
      required this.description,
      required this.token,
      required this.username,
      required this.highestBid});

  NFTView.copy(NFTView view)
      : imageSrc = view.imageSrc,
        authorName = view.authorName,
        pieceName = view.pieceName,
        currentPrice = view.currentPrice,
        id = view.id,
        description = view.description,
        token = view.token,
        username = view.username,
        authorIcon = view.authorIcon,
        highestBid = view.highestBid;
}
