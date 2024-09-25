class MyConstant {
  static const default_padding = 20.0;

  /*types of users*/
  static const attendee = "user";
  static const representative = "representative";
  static const buyer = "buyer";
  static const visitor = "visitor";
  static const entertainment = "entertainment";
  static const one_to_one = "one_to_one";
  static const speakers = "speaker";
  static const contact = "contact";
  static const exhibitor = "exhibitor";

  /*theme set*/
  static const currentFont = "Figtree";
  static const vendor = "dreamcast_2024";
  static const tabExibitor = ["", "", "partner", "startup"];

  /*type of pages*/
  static const slug_photobooth = "photobooth";
  static const slug_wayfinderun = "wayfinderun";
  static const slug_twitterFeedWall = "twitter-feed-wall";
  static const slug_floormap = "floorplan";

  /*firebase node name*/
  static const String photoBoothBucketName = "dreamcast";
  static const String appName = "dreamcast";
  static const slugPoll = "poll";
  //for staging
  //static const topicName="DREAMCAST_EVENT_APP";
  //for production
  static const topicName = "EVENTAPP_SAASBOOMI_2023";
}
