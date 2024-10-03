class AppUrl {
  //for production
  static String defaultFirebaseNode = "eventappsaasboomi2023";
  // static String baseUrl = 'https://mindmixer.saasboomi.org/api/3rdParty/v1';
  static String baseUrl = 'https://staging-eapp.godreamcast.com/lead_capture/api/app/v1';

  //for staging
  //static String defaultFirebaseNode = "eventappotm2024";
  //static String baseUrl = 'https://live.dreamcast.in/otm_2024/api/v1';

  static String chatConversation = "chat_rooms/conversations";
  static String chatUsers = "chat_rooms/users";

  static String get login => '$baseUrl/signin';

  static String get loginByOTP => '$baseUrl/signin/byVerificationCode';
  static String get shareVerificationCode => '$baseUrl/signin/verifyUsername';
  static String get signupCategory => '$baseUrl/signup/getCategories';
  static String get aboutUs => '$baseUrl/cms/getAboutUs';
  static String get getWhyIndia => '$baseUrl/cms/getWhyIndia';
  static String get getGlance => '$baseUrl/cms/getGlance';
  static String get engagement => '$baseUrl/cms/engagement';
  static String get venueManagement => '$baseUrl/cms/venueManagement';

  static String get signup => '$baseUrl/signup';
  static String get logoutApi => '$baseUrl/signout';

  static String get getStatesByCountry =>
      '$baseUrl/localities/getStatesByCountry';

  static String get getCityByState =>
      '$baseUrl/localities/getCitiesByCountryAndState';

  static String get pages => '$baseUrl/pages/get';

  static String get getConfig => '$baseUrl/event/config';

  static String get getTimezone => '$baseUrl/event/timezones';

  static String get setTimezone => '$baseUrl/users/timezone';

  static String get getConfigDetail => '$baseUrl/event/get';

  static String get getProfileFields => '$baseUrl/profiles/getFields';

  static String get getProfileData => '$baseUrl/users/get';

  static String get updateProfile => '$baseUrl/users/updateProfile';
  static String get updatePicture => '$baseUrl/users/updateProfileAvatar';

  static String get getProductList => '$baseUrl/exhibitorProducts';
  static String get getProductExhibitor =>
      '$baseUrl/exhibitorProducts/getRelatedExhibitor';

  static String get bookmarkToProduct =>
      '$baseUrl/userExhibitorProductFavourites/toggle';
  static String get bookmarkToExhibitor =>
      '$baseUrl/userExhibitorFavourites/toggle';
  static String get usersBookmarkApi => '$baseUrl/userFavourites/toggle';

  static String get speakerBookmarkApi => '$baseUrl/speakerFavourites/toggle';

  /*send request*/
  static String get sendChatRequest => '$baseUrl/userChatRooms/makeRequest';
  static String get getChatRequestStatus => '$baseUrl/userChatRooms/get';
  static String get takeChatRequestAction =>
      '$baseUrl/userChatRooms/takeRequestAction';

  static String get myBookmarkExhibitor => '$baseUrl/exhibitor/bookmark/get';
  static String get myBookmarkDocument =>
      '$baseUrl/userExhibitorDocumentFavourites/get';
  static String get myBookmarkRepresentative =>
      '$baseUrl/representative/bookmark/get';
  static String get myBookmarkProduct =>
      '$baseUrl/userExhibitorProductFavourites/get';

  static String get getProductFilter => '$baseUrl/exhibitorProducts/getFilters';

  static String get getProductDetail => '$baseUrl/exhibitorProducts/get';

  //send role to body representative
  //send role to body attendee
  static String get usersListApi => '$baseUrl/users';
  static String get speakerListApi => '$baseUrl/speakers';

  static String get contactListApi => '$baseUrl/eventBot/getUserDetails';

  static String get exhibitorsListApi => '$baseUrl/exhibitors';

  static String get exhibitorsRepresentativesApi =>
      '$baseUrl/exhibitors/representatives';

  static String get exhibitorsVideoApi => '$baseUrl/exhibitorDocuments/get';

  static String get exhibitorsDocumentToggleApi =>
      '$baseUrl/userExhibitorDocumentFavourites/toggle';

  static String get listByDocumentIds =>
      '$baseUrl/userExhibitorDocumentFavourites/listByDocumentIds';

  static String get exhibitorsDocumentApi => '$baseUrl/exhibitor/';

  static String get attendee => '$baseUrl/attendee/';
  static String get representative => '$baseUrl/representative/';

  /*Guid and photobooth api*/
  static String get gallery => '$baseUrl/gallery/get';
  static String get swagBag => '$baseUrl/guides/search';
  static String get faqList => '$baseUrl/faqs/get';
  static String get iframe => '$baseUrl/iframe';
  static String get shiftingDetail => '$baseUrl/sightseeing/get';
  static String get saveShiftingDetail => '$baseUrl/sightseeing/save';

  static String get myBookmarkSwagbag => '$baseUrl/swagBag/bookmark/get';
  static String get bookmarkSwagBag => '$baseUrl/userSwagBagFavourites/toggle';
  static String get feedbackQuestions => '$baseUrl/feedbackQuestions/get';
  static String get saveFeedback => '$baseUrl/userFeedbackQuestions/save';

  static String get photobooth => '$baseUrl/photobooth/get';

  static String get allSponsors => '$baseUrl/sponsors/all';
  static String get getPartnerDetail => '$baseUrl/sponsors/get';

  /*chat module post body{user_id:101, message:"HI"}*/
  static String get createRoom => '$baseUrl/userChatRooms/makeRequest';

  /*{user_id:101, message:"HI"}*/
  static String get sendFirstMessageOnGroup =>
      '$baseUrl/chatRooms/sendFirstMessage/group';

  /*availability get request*/
  static String get getMine => '$baseUrl/userAvailability/getMine';

  /*availability post request*/
  static String get updateMine => '$baseUrl/userAvailability/updateMine';

  /*availability delete request by id*/
  static String get deleteMine => '$baseUrl/userAvailability/delete';

  /*timeslot of user meetings*/
  static String get userMeetingSlotsGet => '$baseUrl/userMeetingSlots/get';

  /*user meetings filter*/
  static String get userMeetingFilter => '$baseUrl/userMeetings/getFilters';

  /*userMeetings/search*/
  static String get userMeetingsSearch => '$baseUrl/UserMeetings/search';

  /*User meeting detail by meeting id*/
  static String get userMeetingDetail => '$baseUrl/userMeetings/get';

  /*ActionAgainstRequest*/
  static String get actionAgainstRequest =>
      '$baseUrl/userMeetingSlots/actionAgainstRequest';

  /*ActionAgainstRequest*/
  static String get joinVideoCall => '$baseUrl/userMeetings/joinVideoCall';

  /*User meeting detail by meeting id*/
  static String get userMeetingsParticipants =>
      '$baseUrl/userMeetings/participants';

  /*UserMeetingColleagues*/
  static String get userMeetingColleagues =>
      '$baseUrl/UserMeetingColleagues/get';

  /*sendJoinRequest post request*/
  static String get sendJoinRequest =>
      '$baseUrl/UserMeetingColleagues/sendJoinRequest';

  /*timeslot of user meetings*/
  static String get bookAppointment =>
      '$baseUrl/userMeetingSlots/bookAnAppointment';

  /*used for contact section*/
  static String get getUserCode => '$baseUrl/UserContacts/getUserCode';
  static String get getUserDetail => '$baseUrl/UserContacts/getUserDetails';
  static String get saveContact => '$baseUrl/UserContacts/save';

  //getMyQRCodeOrBadge
  static String get getBadge => '$baseUrl/userContacts/getMyQRCodeOrBadge';

  static String get sessionView => '$baseUrl/sessions/webview';

  static String get exportContact => '$baseUrl/UserContacts/exportContact';

  static String get sendNotification =>
      '$baseUrl/chatRooms/chatFcmNotification';

  /*session module*/
  static String get getSession => '$baseUrl/webinars/search';
  //get live session
  static String get getTodaySession => '$baseUrl/webinars/getTodaySession';
  /*session detail by session id*/
  static String get getSessionDetail => '$baseUrl/sessions/get';

  static String get getAngelAlly => '$baseUrl/angelAlly/get';
  static String get saveAngelAlly => '$baseUrl/angelAlly/save';

  static String get getStartNetworkingFilters =>
      '$baseUrl/startupNetworking/getFilters';
  static String get searchStartNetworking =>
      '$baseUrl/startupNetworking/search';
  static String get getStartNetworking => '$baseUrl/startupNetworking/get';
  static String get getStartNetworkingSlot =>
      '$baseUrl/startupNetworking/getSlots';
  static String get bookAppointmentStartNetworking =>
      '$baseUrl/startupNetworking/bookAnAppointment';

  static String get bookSessionSeat =>
      '$baseUrl/UserSessionBookedSeats/bookSeat';

  static String get sessionSavePolls => '$baseUrl/sessionPolls/save';

  static String get sessionIsPollSubmitted =>
      '$baseUrl/sessionPolls/isSubmitted';

  static String get savePolls => '$baseUrl/Polls/save';

  static String get isPollSubmitted => '$baseUrl/Polls/isSubmitted';

  static String get auditoriumsAskQuestion => '$baseUrl/session/';

  static String get sessionsFilter => '$baseUrl/webinars/getFilters';

  static String get bookingSessionsFilter =>
      '$baseUrl/UserSessionBookedSeats/getFilters';

  static String get bookmarkSessions => '$baseUrl/UserSessionFavourites/toggle';

  static String get getBookmarkSessions => '$baseUrl/UserSessionFavourites/get';

  static String get getBookingSeat => '$baseUrl/UserSessionBookedSeats/get';

  static String get getBookmarkExhibitor =>
      '$baseUrl/userExhibitorFavourites/get';

  static String get getUserFavourites => '$baseUrl/userFavourites/get';
  static String get getUserFavouritesIds =>
      '$baseUrl/userFavourites/listByUserIds';

  static String get speakerFavourites => '$baseUrl/speakerFavourites/get';

  static String get getBookmarkUser => '$baseUrl/userExhibitorFavourites/get';

  static String get galleryFrame => '$baseUrl/iframe/gallery';

  static String get deleteAccount => '$baseUrl/profiles/delete';

  static String get menuStatus => '$baseUrl/iframe/checkMenuStatus';
  static String get pollStatus => '$baseUrl/iframe/checkPollStatus';
  static String get feedbackStatus => '$baseUrl/iframe/checkFeedbackStatus';

  static String get feedGetList => '$baseUrl/feeds/get';
  static String get feedCreate => '$baseUrl/feeds/create';
  static String get feedDelete => '$baseUrl/feeds/trash';
  static String get feedReport => '$baseUrl/feeds/report';

  static String get feedCommentGet => '$baseUrl/feedComments/get';
  static String get feedCommentGetCreate => '$baseUrl/feedComments/create';
  static String get feedCommentGetTrash => '$baseUrl/feedComments/trash';
  static String get feedCommentGetReply => '$baseUrl/feedComments/reply';
  static String get feedCommentGetReport => '$baseUrl/feedComments/report';

  static String get feedEmotionsGet => '$baseUrl/feedEmoticons/get';
  static String get feedEmotionsToggleMe => '$baseUrl/feedEmoticons/toggleMe';
  static String get feedEmotionsToggleOther =>
      '$baseUrl/feedEmoticons/toggleIntoAnother';

  static String get updateFcm => '$baseUrl/userDevices/subscribe';

  static String get eventVideoList => '$baseUrl/video/get';

  /*photo booth api*/
  static String get eventPhotoListApi => '$baseUrl/AiPhotoBooth/getPhotoList';
  static String get seachAiPhototApi => '$baseUrl/AiPhotoBooth/search';
  static String get uploadAiPhoto => '$baseUrl/AiPhotoBooth/upload';

  /*static String get aiGalleryList =>
       '$baseUrl/AiPhotoBooth/getPhotoList';
   static String get aiUploadImage =>
       "$baseUrl/upload_image";
   static String get aiSearchImage =>
       "$baseUrl/storeimg";
   static String get aiMyImage =>
       "$baseUrl/all_my_images";*/

  /*photo booth api*/
  /*static String get aiGalleryList =>
       'https://engagement.vehub.live/comonface_api/api/gallerylist';
   static String get aiUploadImage =>
       "https://engagement.vehub.live/comonface_api/api/upload_image";
   static String get aiSearchImage =>
       "https://engagement.vehub.live/comonface_api/api/storeimg";
   static String get aiMyImage =>
       "https://engagement.vehub.live/comonface_api/api/all_my_images";*/

  static String get eventList => '$baseUrl/event';
  static String get verifyUserName => '$baseUrl/signin/verifyUsername';
  static String get verifyOtp => '$baseUrl/signin/byVerificationCode';

}
