import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const kSecondaryColor = Color(0xFF00A19D);
final ktextcolor = Color(0xFF438E96);
final Color kPrimaryColor = Color(0xFF438E96);
final Color kTextColor = Color(0xFF606060);
const kBackgroundColor = Color(0xFFFCFCFC);
const Color kFocusedBorderColor = Color(0xFF438E96);
const Color kUnfocusedBorderColor = Colors.grey;
const Color kFocusedBackgroundColor = Color(0xFFBFE0E2);
const Color kUnfocusedBackgroundColor = Colors.white;
 OutlineInputBorder kInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: kTextColor),
);

const kErrorTextStyle = TextStyle(
  color: Colors.red,
);

const kHintTextStyle = TextStyle(
  color: Colors.grey,
);

ButtonStyle kButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: kPrimaryColor,
  padding: EdgeInsets.symmetric(vertical: 16.0),
  textStyle: TextStyle(color: Colors.white, fontSize: 18),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  ),
);

const double kMaxMobileWidth = 420.0;
final Map<String, Map<String, List<String>>> countriesData = {
  'India': {
    'Gujarat': ['Ahmedabad', 'Surat', 'Vadodara', 'Rajkot', 'Gandhinagar'],
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur', 'Nashik', 'Aurangabad'],
    'Delhi': ['New Delhi', 'Noida', 'Gurgaon'],
    'Karnataka': ['Bangalore', 'Mysore', 'Hubli', 'Mangalore', 'Belgaum'],
    'Tamil Nadu': ['Chennai', 'Coimbatore', 'Madurai', 'Tiruchirappalli', 'Salem'],
    'Kerala': ['Thiruvananthapuram', 'Kochi', 'Kozhikode', 'Thrissur', 'Malappuram'],
    'West Bengal': ['Kolkata', 'Howrah', 'Durgapur', 'Asansol', 'Siliguri'],
    'Rajasthan': ['Jaipur', 'Jodhpur', 'Udaipur', 'Ajmer', 'Kota'],
    'Uttar Pradesh': ['Lucknow', 'Kanpur', 'Agra', 'Varanasi', 'Allahabad'],
    'Bihar': ['Patna', 'Gaya', 'Bhagalpur', 'Muzaffarpur', 'Purnia'],
    'Assam': ['Guwahati', 'Dibrugarh', 'Jorhat', 'Silchar', 'Nagaon'],
    'Punjab': ['Ludhiana', 'Amritsar', 'Jalandhar', 'Patiala', 'Bathinda'],
    'Madhya Pradesh': ['Indore', 'Bhopal', 'Jabalpur', 'Gwalior', 'Ujjain'],
    'Haryana': ['Faridabad', 'Gurgaon', 'Panipat', 'Ambala', 'Hisar'],
    'Odisha': ['Bhubaneswar', 'Cuttack', 'Rourkela', 'Brahmapur', 'Sambalpur'],
  },
  'United States': {
    'California': [
      'Los Angeles',
      'San Francisco',
      'San Diego',
      'Sacramento',
      'San Jose'
    ],
    'New York': [
      'New York City',
      'Buffalo',
      'Rochester',
      'Albany',
      'Syracuse'
    ],
    'Texas': ['Houston', 'Dallas', 'Austin', 'San Antonio', 'Fort Worth'],
    'Florida': ['Miami', 'Orlando', 'Tampa', 'Jacksonville', 'Fort Lauderdale'],
    'Illinois': ['Chicago', 'Springfield', 'Peoria', 'Rockford', 'Naperville'],
    'Ohio': ['Columbus', 'Cleveland', 'Cincinnati', 'Toledo', 'Akron'],
    'Pennsylvania': ['Philadelphia', 'Pittsburgh', 'Allentown', 'Erie', 'Reading'],
    'Michigan': ['Detroit', 'Grand Rapids', 'Warren', 'Sterling Heights', 'Lansing'],
    'Georgia': ['Atlanta', 'Augusta', 'Columbus', 'Savannah', 'Athens'],
    'North Carolina': ['Charlotte', 'Raleigh', 'Greensboro', 'Durham', 'Winston-Salem'],
    'Washington': ['Seattle', 'Spokane', 'Tacoma', 'Vancouver', 'Bellevue'],
    'Arizona': ['Phoenix', 'Tucson', 'Mesa', 'Chandler', 'Scottsdale'],
    'Colorado': ['Denver', 'Colorado Springs', 'Aurora', 'Fort Collins', 'Lakewood'],
    'Massachusetts': ['Boston', 'Worcester', 'Springfield', 'Lowell', 'Cambridge'],
  },
  'Canada': {
    'Ontario': ['Toronto', 'Ottawa', 'Hamilton', 'London', 'Mississauga'],
    'Quebec': ['Montreal', 'Quebec City', 'Laval', 'Gatineau', 'Longueuil'],
    'British Columbia': [
      'Vancouver',
      'Surrey',
      'Burnaby',
      'Richmond',
      'Kelowna'
    ],
    'Alberta': ['Calgary', 'Edmonton', 'Red Deer', 'Lethbridge', 'Medicine Hat'],
    'Manitoba': ['Winnipeg', 'Brandon', 'Steinbach', 'Thompson', 'Portage la Prairie'],
    'Saskatchewan': ['Saskatoon', 'Regina', 'Prince Albert', 'Moose Jaw', 'Swift Current'],
    'Nova Scotia': ['Halifax', 'Dartmouth', 'Sydney', 'Truro', 'New Glasgow'],
    'New Brunswick': ['Saint John', 'Moncton', 'Fredericton', 'Dieppe', 'Miramichi'],
    'Newfoundland and Labrador': ['St. John\'s', 'Mount Pearl', 'Corner Brook', 'Conception Bay South', 'Grand Falls-Windsor'],
    'Prince Edward Island': ['Charlottetown', 'Summerside', 'Stratford', 'Cornwall', 'Montague'],
    'Northwest Territories': ['Yellowknife', 'Hay River', 'Inuvik', 'Fort Smith', 'Behchoko'],
    'Nunavut': ['Iqaluit', 'Rankin Inlet', 'Arviat', 'Baker Lake', 'Cambridge Bay'],
    'Yukon': ['Whitehorse', 'Dawson City', 'Watson Lake', 'Haines Junction', 'Carcross'],
  },
  'Australia': {
    'New South Wales': [
      'Sydney',
      'Newcastle',
      'Wollongong',
      'Central Coast',
      'Maitland'
    ],
    'Victoria': ['Melbourne', 'Geelong', 'Ballarat', 'Bendigo', 'Shepparton'],
    'Queensland': [
      'Brisbane',
      'Gold Coast',
      'Sunshine Coast',
      'Townsville',
      'Cairns'
    ],
    'Western Australia': ['Perth', 'Mandurah', 'Bunbury', 'Geraldton', 'Kalgoorlie'],
    'South Australia': ['Adelaide', 'Mount Gambier', 'Whyalla', 'Murray Bridge', 'Port Lincoln'],
    'Tasmania': ['Hobart', 'Launceston', 'Devonport', 'Burnie', 'Kingston'],
    'Australian Capital Territory': ['Canberra'],
    'Northern Territory': ['Darwin', 'Alice Springs', 'Palmerston', 'Katherine', 'Tennant Creek'],
  },
  'United Kingdom': {
    'England': ['London', 'Manchester', 'Birmingham', 'Liverpool', 'Bristol'],
    'Scotland': ['Glasgow', 'Edinburgh', 'Aberdeen', 'Dundee', 'Inverness'],
    'Wales': ['Cardiff', 'Swansea', 'Newport', 'Wrexham', 'Barry'],
    'Northern Ireland': ['Belfast', 'Derry', 'Lisburn', 'Newtownabbey', 'Bangor'],
    'Channel Islands': ['Jersey', 'Guernsey', 'Alderney', 'Sark'],
    'Isle of Man': ['Douglas', 'Peel', 'Ramsey', 'Castletown'],
    'Gibraltar': ['Gibraltar'],
    'British Overseas Territories': ['Bermuda', 'Cayman Islands', 'Falkland Islands', 'Gibraltar'],
    'British Crown Dependencies': ['Isle of Man', 'Jersey', 'Guernsey'],
    'England and Wales': ['London', 'Cardiff', 'Birmingham', 'Liverpool', 'Bristol'],
    'Scotland and Northern Ireland': ['Glasgow', 'Edinburgh', 'Belfast', 'Dundee', 'Inverness'],
    'Channel Islands': ['Jersey', 'Guernsey', 'Alderney', 'Sark'],
    'British Crown Dependencies': ['Isle of Man', 'Jersey', 'Guernsey'],
  },
  // Add more countries and their states/cities here
};





final TextStyle kHeadingTextStyle = GoogleFonts.cherrySwash(
  textStyle: TextStyle(
    color: kPrimaryColor,
    fontSize: 40,
    fontWeight: FontWeight.bold,
  ),
);

final TextStyle kInputLabelStyle = GoogleFonts.exo(
  textStyle: TextStyle(
    fontSize: 14,
    color: kPrimaryColor,
    fontWeight: FontWeight.w600,
  ),
);

// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

class AppColor{
  static Color button_color = Color(0xff438E96);
  static Color text_color = Color(0xffffffff);
  static Color subtext_color = Color(0xff3A4750);
  static Color Textfild_color = Color(0xffDDEFF0);
  static Color deactive_Textfild_color = Color(0xc0bbb2b2);
  static Color active_Textfild_color = Color(0xff438E96);
  static Color Error_color = Color(0xffee0202);
  static Color background_color = Color(0xffFCFCFC);
}

// ignore_for_file: camel_case_types, constant_identifier_names

class Google_Singin {
  static const button_name = "Sign In with Google";
  static const button_name2 = "Sign up With Manual";
}

class Sinup_String {
  static const heding = "Sign Up";
  static const subheding = "Please enter your credentials to proceed";
  static const Full_Name = "Full Name";
  static const Enter_Full_Name = "Enter Full Name";
  static const Phone = "Phone";
  static const Enter_Phone_Name = "Enter Phone Number";
  static const Email_address = "Email address";
  static const Enter_Email_address = "Enter Email address";
  static const Password = "Password";
  static const Address = "Address";
  static const Country = "Country";
  static const Postal_Code = "Postal Code";
  static const My_date_of_birth = "My date of birth";
  static const Gender = "Gender";
  static const Male = "Male";
  static const Female = "Female";
  static const Prefer_not_to_say = "Others";
  static const Create_Account = "CREATE ACCOUNT";
  static const State = "State";
  static const City = "City";
}

class Commnications_text{
  static const Group_Chat = "Group Chat";
  static const Enter_The_Message = "Enter Message";
}