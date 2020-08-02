
class YtVideo {
  final String id;
  final String title;
  final String image;
  final String channel;

  YtVideo(this.id, this.title, this.image, this.channel);

  static List<YtVideo> fetchAllVideos() {
    var videoIds = [
      "i8-iSWGWo0M",
      "5kCZHPJTABw",
      "hqSyIY_orAc",
      "dSxsbDrNsMc",
      "7Q8hG0pYGn8",
      "rwZjRqjJfzk",
    ];
    var videoTitles = [
      "Top 5 Career Options After BE/BTech | MySirG.com",
      "Career Options After Class 12 Science | Medical | Non-medical | Government Sector",
      "12th के बाद क्या करे || Best Career After 12th Commerce, Top 10 Jobs Best Earning in Commerce Filed",
      "5 Career Options for CA CS Dropout Students|Nitin Bhalla",
      "What To Do After 10th - Science, Commerce or Arts? | Best Career Options After 10th | ChetChat",
      "Benefits of GATE EXAM | How to Prepare WITH or WITHOUT coaching?",
    ];
    var videoImages = [
      "https://img.youtube.com/vi/i8-iSWGWo0M/hqdefault.jpg",
      "https://img.youtube.com/vi/5kCZHPJTABw/hqdefault.jpg",
      "https://img.youtube.com/vi/hqSyIY_orAc/hqdefault.jpg",
      "https://img.youtube.com/vi/dSxsbDrNsMc/hqdefault.jpg",
      "https://img.youtube.com/vi/7Q8hG0pYGn8/hqdefault.jpg",
      "https://img.youtube.com/vi/rwZjRqjJfzk/hqdefault.jpg",
    ];
    var videoChannels = [
      "MySirG.com",
      "Aman Dhattarwal",
      "Mahatmaji Technical",
      "Nitin Bhalla",
      "ChetChat",
      "Aman Dhattarwal",
    ];

    return List<YtVideo>.generate(videoIds.length,
            (i) =>
            YtVideo(videoIds[i], videoTitles[i], videoImages[i],
                videoChannels[i]));
  }

  static YtVideo fetchVideo(id) {
    List<YtVideo> video = YtVideo.fetchAllVideos();
    for (var i = 0; i < video.length; i++) {
      if (video[i].id == id) {
        return video[i];
      }
    }
    return null;
  }
}