import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../controller/signup_controller.dart';
import 'constants.dart';
import 'const_color.dart';

Widget buildInputLabel(String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: kInputLabelStyle,
      ),
    ],
  );
}

Widget buildPasswordTextField({
  required FocusNode focusNode,
  required TextEditingController controller,
  required String hintext,
  required String? Function(String?) validator,
  required bool showError,
  required SignUpController controllerInstance,
}) {
  return Obx(() => buildCustomTextField(
    focusNode: focusNode,
    controller: controller,
    hintext: hintext,
    obscureText: !controllerInstance.isPasswordVisible.value,
    validator: validator,
    showError: showError,
    suffixIcon: IconButton(
      icon: Icon(
        controllerInstance.isPasswordVisible.value
            ? Icons.visibility
            : Icons.visibility_off,
        color: kPrimaryColor,
      ),
      onPressed: controllerInstance.togglePasswordVisibility,
    ),
  ));
}

Widget buildCustomTextField({
  required FocusNode focusNode,
  TextInputType? keyboardType,
  Function(String)? onChanged,
  final Widget? suffixIcon,
  required String hintext,
  final bool? obscureText,
  required final TextEditingController controller,
  String? Function(String?)? validator,
  required bool showError,
}) {
  String? errorText = showError ? validator?.call(controller.text) : null;
  Color borderColor = focusNode.hasFocus ? kPrimaryColor : Colors.grey;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
          color: focusNode.hasFocus ? Color(0xffDDEFF0) : Colors.white,
          border: Border.all(
            color: borderColor,
            width: focusNode.hasFocus ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: focusNode.hasFocus ? Color(0xffBFE0E2) : Colors.white,
              spreadRadius: 4,
            ),
          ],
        ),
        child: TextField(
          style: GoogleFonts.exo(
            textStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
          focusNode: focusNode,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText ?? false,
          onChanged: onChanged,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintext,
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            border: InputBorder.none,
          ),
        ),
      ),
      if (showError && errorText != null)
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 4),
          child: Text(
            errorText,
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),
    ],
  );
}

Widget buildDateOfBirthField(BuildContext context, SignUpController controller,
    {required FocusNode focusNode}) {
  String formattedDate = controller.selectedDate == null
      ? 'Select'
      : DateFormat('dd/MM/yyyy').format(controller.selectedDate!);
  Color borderColor = focusNode.hasFocus ? kPrimaryColor : Colors.grey;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () {
          _selectDate(context, controller);
        },
        child: AbsorbPointer(
          child: Container(
            decoration: BoxDecoration(
                color: focusNode.hasFocus ? Color(0xffDDEFF0) : Colors.white,
                border: Border.all(
                    color: borderColor, width: focusNode.hasFocus ? 2 : 1),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      blurStyle: BlurStyle.outer,
                      color:
                      focusNode.hasFocus ? Color(0xffBFE0E2) : Colors.white,
                      spreadRadius: 4)
                ]),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: TextField(
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: 'Select',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                suffix: GestureDetector(
                  onTap: () {
                    _selectDate(context, controller);
                  },
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/calendar.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              controller: TextEditingController(text: formattedDate),
              readOnly: true,
              style: GoogleFonts.exo(
                textStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      ),
      if (controller.showValidationErrors && controller.dobError != null)
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 4),
          child: Text(
            controller.dobError!,
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),
    ],
  );
}

Future<void> _selectDate(
    BuildContext context, SignUpController controller) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: controller.selectedDate ?? DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
  if (picked != null && picked != controller.selectedDate) {
    controller.setSelectedDate(picked);
  }
}

Widget buildMultilineTextField({
  required FocusNode focusNode,
  Function(String)? onChanged,
  required TextEditingController controller,
  String? Function(String?)? validator,
  required bool showError,
}) {
  String? errorText = showError ? validator?.call(controller.text) : null;
  Color borderColor = focusNode.hasFocus ? kPrimaryColor : Colors.grey;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 100.0,
          maxHeight: 200.0,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: focusNode.hasFocus ? Color(0xffDDEFF0) : Colors.white,
              border: Border.all(
                  color: borderColor, width: focusNode.hasFocus ? 2 : 1),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    blurStyle: BlurStyle.outer,
                    color:
                    focusNode.hasFocus ? Color(0xffBFE0E2) : Colors.white,
                    spreadRadius: 4)
              ]),
          child: TextField(
            focusNode: focusNode,
            controller: controller,
            maxLines: null,
            style: GoogleFonts.exo(
              textStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),

            // Ensure text color is black
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: "Address Line 1\nAddress Line 2\nAddress Line 3",
              contentPadding:
              EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      if (showError && errorText != null)
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 4),
          child: Text(
            errorText,
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),
    ],
  );
}

Widget buildIntlPhoneField(SignUpController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      IntlPhoneField(
        style: GoogleFonts.exo(textStyle: TextStyle(color: Colors.black)),
        dropdownIconPosition: IconPosition.trailing,
        initialCountryCode: "IN",
        focusNode: controller.phoneFocusNode,
        decoration: InputDecoration(
            filled: true,
            hintText: "Enter your Phone Number",
            fillColor: controller.phoneFocusNode.hasFocus
                ? Color(0xffDDEFF0)
                : Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: controller.phoneFocusNode.hasFocus ? 2 : 1,
                color: controller.phoneFocusNode.hasFocus
                    ? kPrimaryColor
                    : Colors.grey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: controller.phoneFocusNode.hasFocus ? 2 : 1,
                color: controller.phoneFocusNode.hasFocus
                    ? kPrimaryColor
                    : Colors.grey,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: controller.phoneFocusNode.hasFocus ? 2 : 1,
                color: controller.phoneFocusNode.hasFocus
                    ? kPrimaryColor
                    : Colors.grey,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: controller.phoneFocusNode.hasFocus ? 2 : 1,
                color: controller.phoneFocusNode.hasFocus
                    ? kPrimaryColor
                    : Colors.grey,
              ),
            ),
            counterText: ""
        ),
        flagsButtonPadding: EdgeInsets.symmetric(horizontal: 12),
        languageCode: "en",
        onChanged: (phone) => controller.setPhone(phone.completeNumber),
        onCountryChanged: (country) {
          print('Country changed to: ' + country.name);
        },
      ),
    ],
  );
}

Widget buildCountryDropdown(SignUpController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
            color: controller.countryFocusNode.hasFocus
                ? Color(0xffDDEFF0)
                : Colors.white,
            border: Border.all(
                color: controller.countryFocusNode.hasFocus
                    ? kPrimaryColor
                    : Colors.grey,
                width: controller.countryFocusNode.hasFocus ? 2 : 1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  blurStyle: BlurStyle.outer,
                  color: controller.countryFocusNode.hasFocus
                      ? Color(0xffBFE0E2)
                      : Colors.white,
                  spreadRadius: 4)
            ]),
        child: DropdownButtonFormField<String>(
          iconSize: 0,
          icon: Image.asset("assets/arrow.png"),
          style: GoogleFonts.exo(
            textStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
          decoration: InputDecoration(
            enabled: false,
            contentPadding: EdgeInsets.all(16),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.black54),
            hintText: 'Select Country',
          ),
          focusNode: controller.countryFocusNode,
          value: controller.selectedCountry,
          items: countriesData.keys.map((String country) {
            return DropdownMenuItem<String>(
              value: country,
              child: Text(
                country,
                style: GoogleFonts.exo(
                    textStyle: TextStyle(
                        color: Colors.black)), // Ensure text color is blac,
              ),
            );
          }).toList(),
          onChanged: controller.setCountry,
        ),
      ),
      // Error message condition based on form submission
      if (controller.showValidationErrors && controller.selectedCountry == null)
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8),
          child: Text(
            'Please select a country',
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),
    ],
  );
}

Widget buildStateDropdown(SignUpController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
            color: controller.stateFocusNode.hasFocus
                ? Color(0xffDDEFF0)
                : Colors.white,
            border: Border.all(
                color: controller.stateFocusNode.hasFocus
                    ? kPrimaryColor
                    : Colors.grey,
                width: controller.stateFocusNode.hasFocus ? 2 : 1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  blurStyle: BlurStyle.outer,
                  color: controller.stateFocusNode.hasFocus
                      ? Color(0xffBFE0E2)
                      : Colors.white,
                  spreadRadius: 4)
            ]),
        child: DropdownButtonFormField<String>(
          iconSize: 0,
          icon: Image.asset("assets/arrow.png"),
          style: GoogleFonts.exo(
            textStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
          decoration: const InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              border: InputBorder.none,
              hintText: 'Select State',
              hintStyle: TextStyle(color: Colors.black54)),
          focusNode: controller.stateFocusNode,
          value: controller.selectedState,
          items: controller.selectedCountry != null
              ? countriesData[controller.selectedCountry!]!
              .keys
              .map((String state) {
            return DropdownMenuItem<String>(
              value: state,
              child: Text(
                state,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w400),
              ),
            );
          }).toList()
              : [],
          onChanged: (value) {
            controller.setState(value);
            // Reset city selection when state changes
            controller.setCity(null);
          },
        ),
      ),
      if (controller.showValidationErrors &&
          controller.selectedCountry != null &&
          controller.selectedState == null)
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8),
          child: Text(
            'Please select a state',
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),
    ],
  );
}

Widget buildCityDropdown(SignUpController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
            color: controller.cityFocusNode.hasFocus
                ? Color(0xffDDEFF0)
                : Colors.white,
            border: Border.all(
                color: controller.cityFocusNode.hasFocus
                    ? kPrimaryColor
                    : Colors.grey,
                width: controller.cityFocusNode.hasFocus ? 2 : 1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  blurStyle: BlurStyle.outer,
                  color: controller.cityFocusNode.hasFocus
                      ? Color(0xffBFE0E2)
                      : Colors.white,
                  spreadRadius: 4)
            ]),
        child: DropdownButtonFormField<String>(
          iconSize: 0,
          icon: Image.asset("assets/arrow.png"),
          style: GoogleFonts.exo(
            textStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
          decoration: InputDecoration(
            hintText: 'Select City',
            hintStyle: TextStyle(color: Colors.black54),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            border: InputBorder.none,
          ),
          value: controller.selectedCity,
          focusNode: controller.cityFocusNode,
          items: controller.selectedCountry != null &&
              controller.selectedState != null
              ? countriesData[controller.selectedCountry!]![
          controller.selectedState!]
              ?.map((String city) {
            return DropdownMenuItem<String>(
              value: city,
              child: Text(
                city,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w400),
              ),
            );
          }).toList() ??
              []
              : [],
          onChanged: (value) {
            controller.setCity(value);
          },
        ),
      ),
      if (controller.showValidationErrors &&
          controller.selectedCountry != null &&
          controller.selectedState != null &&
          controller.selectedCity == null)
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8),
          child: Text(
            'Please select a city',
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),
    ],
  );
}

Widget buildGenderRadioButtons({
  required SignUpController controller,
  String? Function(String?)? validator,
  required bool showError,
}) {
  String? errorText =
  showError ? validator?.call(controller.selectedGender) : null;

  return GetBuilder<SignUpController>(
    builder: (controller) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            buildRadioButton('Male', 'male', controller),
            buildRadioButton('Female', 'female', controller),
            buildRadioButton('Prefer not to say', 'preferNotToSay', controller),
          ],
        ),
        if (controller.showValidationErrors && showError && errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              errorText,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    ),
  );
}

Widget buildRadioButton(
    String title, String value, SignUpController controller) {
  return Row(
    children: [
      Radio(
        value: value,
        groupValue: controller.selectedGender,
        activeColor: kPrimaryColor,
        onChanged: (newValue) {
          controller.setGender(newValue); // Update selectedGender
        },
      ),
      Text(
        title,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
    ],
  );
}

final Map<String, Map<String, List<String>>> countriesData = {
  'India': {
    'Gujarat': ['Ahmedabad', 'Surat', 'Vadodara', 'Rajkot', 'Gandhinagar'],
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur', 'Nashik', 'Aurangabad'],
    'Delhi': ['New Delhi', 'Noida', 'Gurgaon'],
    'Karnataka': ['Bangalore', 'Mysore', 'Hubli', 'Mangalore', 'Belgaum'],
    'Tamil Nadu': [
      'Chennai',
      'Coimbatore',
      'Madurai',
      'Tiruchirappalli',
      'Salem'
    ],
    'Kerala': [
      'Thiruvananthapuram',
      'Kochi',
      'Kozhikode',
      'Thrissur',
      'Malappuram'
    ],
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
    'New York': ['New York City', 'Buffalo', 'Rochester', 'Albany', 'Syracuse'],
    'Texas': ['Houston', 'Dallas', 'Austin', 'San Antonio', 'Fort Worth'],
    'Florida': ['Miami', 'Orlando', 'Tampa', 'Jacksonville', 'Fort Lauderdale'],
    'Illinois': ['Chicago', 'Springfield', 'Peoria', 'Rockford', 'Naperville'],
    'Ohio': ['Columbus', 'Cleveland', 'Cincinnati', 'Toledo', 'Akron'],
    'Pennsylvania': [
      'Philadelphia',
      'Pittsburgh',
      'Allentown',
      'Erie',
      'Reading'
    ],
    'Michigan': [
      'Detroit',
      'Grand Rapids',
      'Warren',
      'Sterling Heights',
      'Lansing'
    ],
    'Georgia': ['Atlanta', 'Augusta', 'Columbus', 'Savannah', 'Athens'],
    'North Carolina': [
      'Charlotte',
      'Raleigh',
      'Greensboro',
      'Durham',
      'Winston-Salem'
    ],
    'Washington': ['Seattle', 'Spokane', 'Tacoma', 'Vancouver', 'Bellevue'],
    'Arizona': ['Phoenix', 'Tucson', 'Mesa', 'Chandler', 'Scottsdale'],
    'Colorado': [
      'Denver',
      'Colorado Springs',
      'Aurora',
      'Fort Collins',
      'Lakewood'
    ],
    'Massachusetts': [
      'Boston',
      'Worcester',
      'Springfield',
      'Lowell',
      'Cambridge'
    ],
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
    'Alberta': [
      'Calgary',
      'Edmonton',
      'Red Deer',
      'Lethbridge',
      'Medicine Hat'
    ],
    'Manitoba': [
      'Winnipeg',
      'Brandon',
      'Steinbach',
      'Thompson',
      'Portage la Prairie'
    ],
    'Saskatchewan': [
      'Saskatoon',
      'Regina',
      'Prince Albert',
      'Moose Jaw',
      'Swift Current'
    ],
    'Nova Scotia': ['Halifax', 'Dartmouth', 'Sydney', 'Truro', 'New Glasgow'],
    'New Brunswick': [
      'Saint John',
      'Moncton',
      'Fredericton',
      'Dieppe',
      'Miramichi'
    ],
    'Newfoundland and Labrador': [
      'St. John\'s',
      'Mount Pearl',
      'Corner Brook',
      'Conception Bay South',
      'Grand Falls-Windsor'
    ],
    'Prince Edward Island': [
      'Charlottetown',
      'Summerside',
      'Stratford',
      'Cornwall',
      'Montague'
    ],
    'Northwest Territories': [
      'Yellowknife',
      'Hay River',
      'Inuvik',
      'Fort Smith',
      'Behchoko'
    ],
    'Nunavut': [
      'Iqaluit',
      'Rankin Inlet',
      'Arviat',
      'Baker Lake',
      'Cambridge Bay'
    ],
    'Yukon': [
      'Whitehorse',
      'Dawson City',
      'Watson Lake',
      'Haines Junction',
      'Carcross'
    ],
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
    'Western Australia': [
      'Perth',
      'Mandurah',
      'Bunbury',
      'Geraldton',
      'Kalgoorlie'
    ],
    'South Australia': [
      'Adelaide',
      'Mount Gambier',
      'Whyalla',
      'Murray Bridge',
      'Port Lincoln'
    ],
    'Tasmania': ['Hobart', 'Launceston', 'Devonport', 'Burnie', 'Kingston'],
    'Australian Capital Territory': ['Canberra'],
    'Northern Territory': [
      'Darwin',
      'Alice Springs',
      'Palmerston',
      'Katherine',
      'Tennant Creek'
    ],
  },
  'United Kingdom': {
    'England': ['London', 'Manchester', 'Birmingham', 'Liverpool', 'Bristol'],
    'Scotland': ['Glasgow', 'Edinburgh', 'Aberdeen', 'Dundee', 'Inverness'],
    'Wales': ['Cardiff', 'Swansea', 'Newport', 'Wrexham', 'Barry'],
    'Northern Ireland': [
      'Belfast',
      'Derry',
      'Lisburn',
      'Newtownabbey',
      'Bangor'
    ],
    'Channel Islands': ['Jersey', 'Guernsey', 'Alderney', 'Sark'],
    'Isle of Man': ['Douglas', 'Peel', 'Ramsey', 'Castletown'],
    'Gibraltar': ['Gibraltar'],
    'British Overseas Territories': [
      'Bermuda',
      'Cayman Islands',
      'Falkland Islands',
      'Gibraltar'
    ],
    'British Crown Dependencies': ['Isle of Man', 'Jersey', 'Guernsey'],
    'England and Wales': [
      'London',
      'Cardiff',
      'Birmingham',
      'Liverpool',
      'Bristol'
    ],
    'Scotland and Northern Ireland': [
      'Glasgow',
      'Edinburgh',
      'Belfast',
      'Dundee',
      'Inverness'
    ],
    'Channel Islands': ['Jersey', 'Guernsey', 'Alderney', 'Sark'],
    'British Crown Dependencies': ['Isle of Man', 'Jersey', 'Guernsey'],
  },
  // Add more countries and their states/cities here
};
