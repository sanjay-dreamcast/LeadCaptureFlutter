import 'package:flutter/src/widgets/framework.dart';

abstract class MyLocaleKeys {
  static const home = 'home';
  static const post_request = 'post_request';
  static const post_request_sub_title = 'post_request_sub_title';
  static const received_bids = 'received_bids';
  static const reset_locale = 'reset_locale';
  static const location_service = 'location_service';
  static const turn_on_location_msg = 'turn_on_location_msg';
  static const allow_tracking = 'allow_tracking';
  static const dont_allow = 'dont_allow';

  /*booking details page*/

  static const pet_image = 'Pet Image';
  static const before_appointment = 'Before Appointment:';
  static const after_appointment = 'After Appointment:';

  static const view = 'VIEW';
  static const pet_details = 'Pet Details';
  static const additional_notes = 'Additional Notes';
  static const chat_now = 'Chat Now';
  static const call_now = 'Call Now';
  static const track_service_provider = 'Track Service Provider';
  static const service_provider_location = 'Service Provider Location';







  /*start Add pet screen*/
  static const select_pet_type = 'Select Pet Type';
  static const add = 'Add';
  static const manage_pet = 'Manage Pet';
  static const please_enter_petname = 'Please enter Pet name';
  static const Please_select_pet_type = 'Please select pet type';
  static const please_enter_breedname = 'Please enter breed name';
  static const please_select_pet_size = 'Please select size of pet';
  static const please_select_pet_gender = 'Please select Gender';
  static const please_enter_weight = 'Please Pet weight';
  static const add_pet_image = 'Please add image of pet';






  static const select_gender = 'Select Gender';
  static const select_pet_size = 'Select Size';
  static const enter_pet_name='Enter Pet Name';
  static const enter_breed_name='Enter Breed Name';
  static const enter_weight_in_kg='Enter Weight in KG';

  /*add post request validation*/
  static const please_select_at_least_one_service='Please select at least one service';
  static const please_select_your_pet='Please select your pet';
  static const post_your_requirment="Post Your Requirement";
  static const waiting_appoinment="Wating Appointment";

  static const please_select_date='Please select appointment date';
  static const please_select_address='Please select address';
  static const select_date='Select Date';
  static const please_select_pet='Please select at least one pet';
  static const please_enter_notes='Please enter notes';
  static const enter_person_name_location='Person name at location';
  static const enter_person_mobile_location='Person contact at location';


  static const person_persent_location = 'Person present at location';
  static const continue_title="Continue";
  static const select_sub_service="Select Sub Service";
  static const select_pet_service="Select Pet Service";
  static const service_not_found="Service not found yet";
  static const add_pet_details="Add Pet Details";
  static const select_service_type="Select Service Type";
  static const select_more_ervice_type="Select More Service Type";
  static const service_is_not_found="Service is not found";
  static const booking_confirmation="Booking Confirmation";
  static const book_appoinment="Book Appointment";
  static const service_time="Service Name";
  static const date="Date";
  static const address="Address";
  static const promo_code="Promo Code";
  static const notes="Notes";
  static const estimated_service_time="Estimated Service Time";
  static const applied_code="Applied Code";
  static const total_price="Total Price:";
  static const next = 'Next';


  /*initial Profile*/
  static const initial_profile_title = 'Please help us to build your profile';
  static const enter_address = 'Enter Address';
  static const add_your_pet = 'Add your Pet';
  static const please_upload_profile = 'Please upload profile image';
  static const please_add_pet_details = 'Please add Pet details';
  static const please_add_address_detail = 'Please add address details';
  static const skip = 'Skip';












  /*wallet*/

  static const no_transection_found = 'No Transaction Found';




  /*end add pet screen */

  static const my_account = 'My Account';
  static const my_profile = 'Profile';
  static const my_address = 'Address';
  static const my_pet = 'Pets';

  static const other = 'other';

  static const language = 'language';

  static const select_default_lang = 'select_default_lang';


  static const update_profile = 'update_profile';
  static const change_password = 'change_password';

  static const save_address = 'save_address';
  static const my_spendings = 'my_spendings';
  static const transactions = 'transactions';
  static const payments = 'payments';
  static const payment_method = 'payment_method';

  static const notification = 'notification';
  static const addPayment = 'addPayment';

  /*alert dialog action title*/
  static const delete_address = 'delete_address';
  static const cancel = 'Cancel';
  static const delete = 'Delete';

  /*blank address text*/
  static const you_not_added_address_yet = 'you_not_added_address_yet';
  static const add_new_address = 'Add Address';

  /*complain_title*/
  static const complaints = 'complaints';

  static const sucess = 'sucess';
  static const thank_you = 'thank_you';
  static const your_payment_sucessfully_made = 'your_payment_sucessfully_made';
  static const bookingId = 'bookingId';
  static const request_number = 'request_number';
  static const your_post_request_submitted_sucessfully =
      'your_post_request_submitted_sucessfully';
  static const thank_you_forthe_feedback = 'thank_you_forthe_feedback';

  static const track_driver = 'track_driver';
  static const welcome_title = 'welcome_title';
  static const welcome_subtitle = 'welcome_subtitle';
  static const create_an_account = 'create_an_account';
  static const sign = 'sign';
  static const enter_guest = 'enter_guest';

  /*sign in*/
  static const enter_detail_to_login = 'enter_detail_to_login';
  static const email_address = 'email_address';
  static const password = 'password';
  static const remember_me = 'remember_me';
  static const forgot_password = 'forgot_password';
  static const dont_have_account = 'dont_have_account';
  static const already_have_account = 'already_have_account';

  /*sign in validation*/
  static const enter_email_address = 'enter_email_address';
  static const enter_valid_email_address = 'enter_valid_email_address';
  static const enter_empty_password = 'enter_empty_password';

  static const enter_valid_new_password = 'enter_valid_new_password';
  static const enter_empty_new_password = 'enter_empty_new_password';

  static const enter_empty_confirm_password = 'enter_empty_confirm_password';

  static const enter_valid_password = 'enter_valid_password';
  static const enter_confirm_empty_password = 'enter_confirm_empty_password';
  static const enter_confirm_valid_password = 'enter_confirm_valid_password';

  /*signup*/
  static const enter_detail_create_account = 'enter_detail_create_account';
  static const fullName = 'fullName';
  static const phoneNumber = 'phoneNumber';
  static const confirm_password = 'confirm_password';
  static const signup = 'signup';

  /*otp*/

  static const enter_constification_code = 'enter_constification_code';
  static const verificaion_code_send_by_sms = 'verificaion_code_send_by_sms';
  static const verify = 'verify';
  static const resend_in = 'resend_in';
  static const otp = 'otp';
  static const did_not_received_otp = "did_not_received_otp";
  static const resend_otp = "resend_otp";
  static const seconds = "seconds";
  static const please_enter_otp = "please_enter_otp";

  /*signup_validation*/

  static const full_name_should_be_minemum_2_charecters =
      'full_name_should_be_minemum_2_charecters';
  static const enter_phone_number = 'enter_phone_number';
  static const enter_valid_phone_number = 'enter_valid_phone_number';

  /*terms and user*/
  static const by_signing_agreeing = 'by_signing_agreeing';
  static const terms_of_user = 'terms_of_user';
  static const and = 'and';
  static const privacy_policy = 'privacy_policy';

  /*share page*/
  static const share_app = 'share_app';
  static const copy_link_msg = 'copy_link_msg';
  static const copy_link = 'copy_link';
  static const share_via_social_media = 'share_via_social_media';
  static const facebook = 'facebook';
  static const email = 'email';
  static const twitter = 'twitter';
  static const whatsup = 'whatsup';

  /*menu*/

  static const my_booking = 'my_booking';
  static const posted_offer = 'posted_offer';
  static const posted_request = 'posted_request';
  static const save_request = 'save_request';
  static const transportation_history = 'transportation_history';

  static const chat_support = 'chat_support';
  static const rate_ths_app = 'rate_ths_app';
  static const faq = 'faq';
  static const contact_us = 'contact_us';
  static const favourite = 'favourite';
  static const about_us = 'about_us';

  /*change_password*/
  static const forgotPassword = 'forgotPassword';
  static const create_password = 'create_password';
  static const choose_strong_password = 'choose_strong_password';

  /*bids detail*/
  static const bid_detail = 'bid_detail';
  static const bid_for = 'bid_for';
  static const vehicle_type = 'vehicle_type';
  static const completed_trips = 'completed_trips';
  static const bidding_amount = 'bidding_amount';
  static const milestone_wise = 'milestone_wise';
  static const one_time = 'one_time';

  static const company_info = 'company_info';
  static const reject = 'reject';
  static const accept = 'accept';
  static const view_all = 'view_all';
  static const load_capacity = 'load_capacity';
  static const journary_start_date = 'journary_start_date';
  static const journary_end_date = 'journary_end_date';
  static const view_detail = 'view_detail';

  /*booking Detail*/
  static const booking_detail = 'Booking Details';
  static const cancel_booking = 'cancel_booking';
  static const rate_now = 'rate_now';

  static const track = 'track';
  static const call = 'call';
  static const booking_id = 'booking_id';
  static const driver_info = "driver_info";

  /*step 1 validation*/

  static const pickup_address_empty = 'pickup_address_empty';
  static const dropup_address_empty = 'dropup_address_empty';

  static const pickup_date_empty = 'pickup_date_empty';
  static const dropup_date_empty = 'dropup_date_empty';
  static const bid_expire_date_empty = 'bid_expire_date_empty';

  static const dimention_empty = 'dimention_empty';
  static const weight_empty = 'weight_empty';

  static const pick_up_address = 'pick_up_address';
  static const drop_off_address = 'drop_off_address';


  static const pick_up_date = 'pick_up_date';
  static const drop_off_date = 'drop_off_date';
  static const bid_expire_date = 'bid_expire_date';
  static const select_pick_up_date = 'select_pick_up_date';
  static const select_drop_off_date = 'select_drop_off_date';
  static const select_bid_expire_date = 'select_bid_expire_date';

  static const dimention_title = "dimention_title";
  static const item_lenght = "item_lenght";
  static const item_width = "item_width";
  static const item_height = "item_height";
  static const weight = "weight";
  static const item_weight = "item_weight";
  static const select_currency_for_payment = "select_currency_for_payment";
  static const select_currency = "select_currency";
  static const add_more_product = "add_more_product";
  static const upload_image = "upload_image";
  static const helper_requirment = "helper_requirment";
  static const note_inst = "note_inst";
  static const note = "note";
  static const write_here = "write_here";
  static const material_type = "material_type";
  static const dimensions = "dimensions";

  static const loading = "loading";
  static const no_posted_offer = "no_posted_offer";
  static const no_posted_request = "no_posted_request";
  static const no_favourite_item = "no_favourite_item";
  static const no_booking_found = "No appointment found yet.";
  static const no_notification_found = "Notification not found please refresh the page.";
  static const no_address_found = "No address Found";
  static const no_pet_found = "No Pet found";

  static const no_spending_found = "no_spending_found";
  static const no_transaction_found = "no_transaction_found";
  static const no_payments_found = "no_payments_found";
  static const no_complaint_found = "no_complaint_found";

  static const current = "current";
  static const completed = "completed";

  static const bid_accepting_time = "bid_accepting_time";
  static const text_note = "text_note";
  static const product_image = "product_image";
  static const expected_time = "expected_time";
  static const expected_distance = "expected_distance";

  static const update_detail = 'update_detail';

  static const history = "history";
  static const spending_on = "spending_on";
  static const money_spend_on = "money_spend_on";
  static const transection_histry = "transection_histry";
  static const available_ballance = "Available Balance";

  static const close = "close";
  static const done = "done";
  static const user_current_location = "user_current_location";
  static const using_gps = "using_gps";
  static const yes = "yes";
  static const helper = "helper";
  static const no_helper = "no_helper";
  static const card_payment = "card_payment";
  static const upload_images = "upload_images";
  static const wallet_payment = "wallet_payment";
  static const completed_jobs = "completed_jobs";
  static const submit = "Submit";

  static const select_country = 'select_country';
  static const select_state = 'select_state';
  static const select_city = 'select_city';

  static const comment_optional = "comment_optional";

  static const write_rating_review = "write_rating_review";
  static const reset_password = 'reset_password';
  static const ok = 'ok';
  static const enter_detail_to_reset_password =
      "enter_detail_to_reset_password";

  static const enter_detail_to_reset_mobile =
      "enter_detail_to_reset_mobile";

  static const submit_complain = "submit_complain";
  static const write_complain = "write_complain";

  static const ask_question = "ask_question";
  static const submit_question = "submit_question";
  static const write_question = "write_question";

  static const reply = "reply";

  static const pay_now = "pay_now";

  static const enter_varification_code = "enter_varification_code";

  static const payment_methode = "payment_methode";

  static const raise_issue = "raise_issue";

  static const payment_status = "payment_status";

  static const pending = "pending";
  static const paid = "paid";
  static const due="due";
  static const logout = "logout";
  static const login = "login";

  static const please_login_to_continue_wishlist =
      "please_login_to_continue_wishlist";
  static const filters = "filters";
  static const start_date = "start_date";
  static const end_date = "end_date";
  static const enter_city = "Enter City Name";

  static const filter_by_pic_city = "filter_by_pic_city";
  static const filter_by_drop_city = "filter_by_drop_city";

  static const filter_by_status = "filter_by_status";

  static const save = "save";

  static var product_info = "product_info";
  static const alert = "Alert";
  static const are_sure_delete_this_request = "are_sure_delete_this_request";
  static const are_sure_delete_this_saved_request =
      "are_sure_delete_this_saved_request";

  static var search_by_bookingId = "search_by_bookingId";

  static var current_booking = "current_booking";
  static var completed_booking = "completed_booking";

  static const add_new_address_title = 'add_new_address_title';

  static const clear = 'clear';
  static const back = 'back';
  static const enter_your_address = 'Enter Address';

  static const please_enter_trip_instruction = "please_enter_trip_instruction";
  static const please_upload_product_images = "please_upload_product_images";
  static const photo_library = "Photo";
  static const camera = "Camera";
  static const onetime = "onetime";
  static const milestone = "milestone";
  static const disclamer = "disclamer";

  static const enter_amount = "enter_amount";

  static const you_dont_have_received_bid = "you_dont_have_received_bid";
  static const you_need_to_login_received_bids =
      "you_need_to_login_received_bids";
  static const password_contain = "password_contain";
  static const atlease_one_spcial_character = "atlease_one_spcial_character";
  static const one_spcial_character = "one_spcial_character";
  static const at_least_one_capital_latter = "at_least_one_capital_latter";
  static const one_capital_latter = "one_capital_latter";
  static const at_least_one_number = "at_least_one_number";
  static const one_number = "one_number";
  static const minimum_8_characters = "minimum_8_characters";
  static const minimum_one_characters = "minimum_one_characters";
  static const are_sure_delete_notification = "Are you sure you want to delete ?";
  static const question_answer = "question_answer";

  static const total_deduction = "total_deduction";

  static const request_transformation = "request_transformation";
  static const pick_up_location = "pick_up_location";
  static const destination = "destination";
  static const request_details = "request_details";
  static const group_product_title = "group_product_title";
  static const group_descrption = "group_descrption";

  static const active_request = "active_request";
  static const pending_request = "pending_request";

  static const result_not_found = "result_not_found";

  static const request_cost_from_transporter = "request_cost_from_transporter";
  static const you_post_request_has_been_saved_sucessfully =
      'you_post_request_has_been_saved_sucessfully';

  static const you_post_request_has_been_update_sucessfully =
      'you_post_request_has_been_update_sucessfully';

  static const update_address = "update_address";

  static const other_information = "other_information";
  static const country_code = "country_code";
  static const please_accept_terms_condition = "please_accept_terms_condition";
  static const please_select_currency = "please_select_currency";
  static const pending_payment = "pending_payment";
  static const completed_payment = "completed_payment";
  static const enter_as_guest = "enter_as_guest";
  static const enter_pickup_city = "enter_pickup_city";
  static const enter_drop_city = "enter_drop_city";
  static const filter_by = "filter_by";
  static const cant_get_current_location = "cant_get_current_location";
  static const please_make_sure_enable_gps = "please_make_sure_enable_gps";
  static const questions = "questions";
  static const select_your_location = "Select Your Location";
  static const change = "change";
  static const confrim_location = "Confirm Location";
  static const house_flat = "house_flat";
  static const validation_house_falt = "validation_house_falt";
  static const landmark = "landmark";
  static const validation_landmark = "validation_landmark";
  static const postal_code_optional = "postal_code_optional";
  static const postal_code_required = "postal_code_required";
  static const mobile_number = "mobile_number";
  static const update_mobile = "update_mobile";
  static const address_type = "address_type";
  static const office = "office";
  static const country = "country";
  static const enter_state_name = "Enter State Name";
  static const enter_zipcode="Enter Zip Code";
  static const please_enter_zipcode="Please Enter Zip Code";
  static const please_enter_country = "please_select_country";
  static const please_enter_state = "Please Enter State Name";
  static const please_select_city = "please_select_city";
  static const please_select_type_of_address = "please_select_type_of_address";
  static const counter_offer = "counter_offer";
  static const days_left = "days_left";
  static const milestone2 = "milestone2";
  static const on_final_delivery = "on_final_delivery";
  static const would_u_like_offer = "would_u_like_offer";
  static const are_u_sure_accept_request = "are_u_sure_accept_request";
  static const milestone_one = "milestone_one";
  static const on_pickup = "on_pickup";
  static const enter_offer = "enter_offer";
  static const send_counter_offer = "send_counter_offer";
  static const please_enter_counter_offer = "please_enter_counter_offer";
  static const payment_history = "Payment History";
  static const transportation_cost = "transportation_cost";
  static const insurance = "insurance";
  static const total_cost = "total_cost";
  static const tonne = "tonne";
  static const please_write_question = "please_write_question";
  static const open = "open";
  static const please_write_complain = "please_write_complain";
  static const send_saved_request = "send_saved_request";
  static const days = "days";
  static const poor = "poor!";
  static const average = "average!";
  static const good = "good!";

  static const would_u_like_insurance = "would_u_like_insurance";
  static const no_lable = "no_lable";
  static const insurance_details = "insurance_details";
  static const payment_structure = "payment_structure";
  static const kg = "kg";
  static const invite_code = "invite_code";

  static const my_rewards = "my_rewards";
  static const wallet_amount = "wallet_amount";
  static const withdraw = "withdraw";
  static const reward_on = "reward_on";
  static const reward_type = "reward_type";
  static const reward_amount = "reward_amount";
  static const no_reward_found = "no_reward_found";

  static const total_rewards = "total_rewards";
  static const select_payment_option = "select_payment_option";
  static const payment_option_first="payment_option_first";
  static const payment_option_second="payment_option_second";
  static const question_not_found="question_not_found";
  static const saved_request_not_found="saved_request_not_found";
  static const update="Update";
  static const are_u_sure_logout="are_u_sure_logout";
  static const user_goods_value="user_goods_value";
  static const insurance_percent="insurance_percent";
  static const enter_estimated_good_value="enter_estimated_good_value";
  static const enter_estimated_good_value_empty="enter_estimated_good_value_empty";
  static const enter_estimated_good_value_validation="enter_estimated_good_value_validation";
  static const request_transportation="request_transportation";
  static const start="start";
  static const end="end";
  static const  payment_done="payment_done";
  static const payment_fail="payment_fail";
  static const star1="star1";
  static const star2="star2";
  static const star3="star3";
  static const star4="star4";
  static const star5="star5";
  static const task_started = 'task_started';
  static const upcoming="upcoming";
  static const arrived="arrived";
  static const pickup="pickup";
  static const transit="transit";
  static const cancelled ="cancelled";
  static const delivered="delivered";

  static const awaiting="awaiting";
  static const bid_accepted="bid_accepted";
  static const bid_rejected="bid_rejected";
  static const wallet="Wallet";
  static const card="card";
  static const filter_by_payment_mode="filter_by_payment_mode";

  static const are_you_sure="Are you sure?";
  static const you_want_exit_from_app="Do you want to exit an App";

  static const expired="Expired";

  static const new_password="new_password";

  static const password_not_matched="password_not_matched";
  static const new_password_not_matched="new_password_not_matched";
  static const select_status="select_status";
  static const enter_new_password="enter_new_password";
  static const enter_empty_conf_password="enter_empty_conf_password";
  static const discount_amount="discount_amount";
  static const insurance_charge_willbe="insurance_charge_willbe";
  static const add_product="add_product";
  static const manage_address="manage_address";
  static const or="or";
  static const please_enter_wallet_amount="please_enter_wallet_amount";
  static const please_enter_minimum_amount="please_enter_minimum_amount";

  static const ballance="ballance";
  static const logistic_wallet="logistic_wallet";
  static const billing_detail="billing_detail";
  static const pay_milestone1="pay_milestone1";
  static const pay_milestone2="pay_milestone2";

  static const driver_location="driver_location";
  static const pickup_location="pickup_location";
  static const dropup_location="dropup_location";

  static const add_product_title="add_product_title";
  static const halt="halt";

  static const request_truck="request_truck";

  static const please_enter_your_address="Please enter address";


}
