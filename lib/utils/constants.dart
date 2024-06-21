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
