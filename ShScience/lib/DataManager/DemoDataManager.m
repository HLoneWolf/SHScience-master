//
//  DataManager.m
//  NHAutoCompleteTextBox
//
//  Created by Shahan on 14/12/2014.
//  Copyright (c) 2014 Shahan. All rights reserved.
//

#import "DemoDataManager.h"

@implementation DemoDataManager

@synthesize dataSource;

-(id)fetchDataSynchronously
{
    // Run Asynchronous request to fetch results    
     dataSource = [NSMutableArray new];

    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Afghanistan", @"CountryName", @"Kabul", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Albania", @"CountryName", @"Tirane", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Algeria", @"CountryName", @"Algiers", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Andorra", @"CountryName", @"Andorra la Vella", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Angola", @"CountryName", @"Luanda", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Antigua and Barbuda", @"CountryName", @"Saint John's", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Argentina", @"CountryName", @"Buenos Aires", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Armenia", @"CountryName", @"Yerevan", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Australia", @"CountryName", @"Canberra", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Austria", @"CountryName", @"Vienna", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Azerbaijan", @"CountryName", @"Baku", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Bahrain", @"CountryName", @"Manama", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Bangladesh", @"CountryName", @"Dhaka", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Barbados", @"CountryName", @"Bridgetown", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Belarus", @"CountryName", @"Minsk", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Belgium", @"CountryName", @"Brussels", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Belize", @"CountryName", @"Belmopan", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Benin", @"CountryName", @"Porto-Novo", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Bhutan", @"CountryName", @"Thimphu", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Bolivia", @"CountryName", @"La Paz", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Bosnia and Herzegovina", @"CountryName", @"Sarajevo", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Botswana", @"CountryName", @"Gaborone", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Brazil", @"CountryName", @"Brasilia", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Brunei", @"CountryName", @"Bandar Seri Begawan", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Bulgaria", @"CountryName", @"Sofia", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Burkina Faso", @"CountryName", @"Ouagadougou", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Burma", @"CountryName", @"Rangoon", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Burundi", @"CountryName", @"Bujumbura", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Cambodia", @"CountryName", @"Phnom Penh", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Cameroon", @"CountryName", @"Yaounde", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Canada", @"CountryName", @"Ottawa", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Cape Verde", @"CountryName", @"Praia", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Central African Republic", @"CountryName", @"Bangui", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Chad", @"CountryName", @"N'Djamena", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Chile", @"CountryName", @"Santiago", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"China", @"CountryName", @"Beijing", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Colombia", @"CountryName", @"Bogota", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Comoros", @"CountryName", @"Moroni", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Costa Rica", @"CountryName", @"San Jose", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Cote d'Ivoire", @"CountryName", @"Yamoussoukro", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Croatia", @"CountryName", @"Zagreb", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Cuba", @"CountryName", @"Havana", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Cyprus", @"CountryName", @"Nicosia", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Czech Republic", @"CountryName", @"Prague", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Democratic Republic of the Congo", @"CountryName", @"Kinshasa", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Denmark", @"CountryName", @"Copenhagen", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Djibouti", @"CountryName", @"Djibouti", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Dominica", @"CountryName", @"Roseau", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Dominican Republic", @"CountryName", @"Santo Domingo", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"East Timor", @"CountryName", @"Dili", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Ecuador", @"CountryName", @"Quito", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Egypt", @"CountryName", @"Cairo", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"El Salvador", @"CountryName", @"San Salvador", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Equatorial Guinea", @"CountryName", @"Malabo", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Eritrea", @"CountryName", @"Asmara", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Estonia", @"CountryName", @"Tallinn", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Ethiopia", @"CountryName", @"Addis Ababa", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Federated States of Micronesia", @"CountryName", @"Palikir", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Fiji", @"CountryName", @"Suva", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Finland", @"CountryName", @"Helsinki", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"France", @"CountryName", @"Paris", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Gabon", @"CountryName", @"Libreville", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Georgia", @"CountryName", @"Tbilisi", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Germany", @"CountryName", @"Berlin", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Ghana", @"CountryName", @"Accra", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Greece", @"CountryName", @"Athens", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Grenada", @"CountryName", @"Saint George's", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Guatemala", @"CountryName", @"Guatemala City", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Guinea", @"CountryName", @"Conakry", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Guinea-Bissau", @"CountryName", @"Bissau", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Guyana", @"CountryName", @"Georgetown", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Haiti", @"CountryName", @"Port-au-Prince", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Honduras", @"CountryName", @"Tegucigalpa", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Hungary", @"CountryName", @"Budapest", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Iceland", @"CountryName", @"Reykjavik", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"India", @"CountryName", @"New Delhi", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Indonesia", @"CountryName", @"Jakarta", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Iran", @"CountryName", @"Tehran", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Iraq", @"CountryName", @"Baghdad", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Ireland", @"CountryName", @"Dublin", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Israel", @"CountryName", @"Jerusalem", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Italy", @"CountryName", @"Rome", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Jamaica", @"CountryName", @"Kingston", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Japan", @"CountryName", @"Tokyo", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Jordan", @"CountryName", @"Amman", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Kazakhstan", @"CountryName", @"Astana", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Kenya", @"CountryName", @"Nairobi", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Kiribati", @"CountryName", @"Tarawa", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Kuwait", @"CountryName", @"Kuwait City", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Kyrgyzstan", @"CountryName", @"Bishtek", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Laos", @"CountryName", @"Vientiane", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Latvia", @"CountryName", @"Riga", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Lebanon", @"CountryName", @"Beirut", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Lesotho", @"CountryName", @"Maseru", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Liberia", @"CountryName", @"Monrovia", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Libya", @"CountryName", @"Tripoli", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Liechtenstein", @"CountryName", @"Vaduz", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Lithuania", @"CountryName", @"Vilnius", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Luxembourg", @"CountryName", @"Luxembourg", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Macedonia", @"CountryName", @"Skopje", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Madagascar", @"CountryName", @"Antananarivo", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Malawi", @"CountryName", @"Lilongwe", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Malaysia", @"CountryName", @"Kuala Lumpur", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Maldives", @"CountryName", @"Male", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Mali", @"CountryName", @"Bamako", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Malta", @"CountryName", @"Valletta", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Marshall Islands", @"CountryName", @"Majuro", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Mauritania", @"CountryName", @"Nouakchott", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Mauritius", @"CountryName", @"Port Louis", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Mexico", @"CountryName", @"Mexico City", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Moldova", @"CountryName", @"Chisinau", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Monaco", @"CountryName", @"Monaco", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Mongolia", @"CountryName", @"Ulaanbaatar", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Morocco", @"CountryName", @"Rabat", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Mozambique", @"CountryName", @"Maputo", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Namibia", @"CountryName", @"Windhoek", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Nauru", @"CountryName", @"Yaren District", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Nepal", @"CountryName", @"Kathmandu", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Netherlands", @"CountryName", @"Amsterdam", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"New Zealand", @"CountryName", @"Wellington", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Nicaragua", @"CountryName", @"Managua", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Niger", @"CountryName", @"Niamey", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Nigeria", @"CountryName", @"Abuja", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"North Korea", @"CountryName", @"Pyongyang", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Norway", @"CountryName", @"Oslo", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Oman", @"CountryName", @"Muscat", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Pakistan", @"CountryName", @"Islamabad", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Palau", @"CountryName", @"Koror", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Panama", @"CountryName", @"Panama City", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Papua New Guinea", @"CountryName", @"Port Moresby", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Paraguay", @"CountryName", @"Asuncion", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Peru", @"CountryName", @"Lima", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Philippines", @"CountryName", @"Manila", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Poland", @"CountryName", @"Warsaw", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Portugal", @"CountryName", @"Lisbon", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Qatar", @"CountryName", @"Doha", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Republic of the Congo", @"CountryName", @"Brazzaville", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Romania", @"CountryName", @"Bucharest", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Russia", @"CountryName", @"Moscow", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Rwanda", @"CountryName", @"Kigali", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Saint Kitts and Nevis", @"CountryName", @"Basseterre", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Saint Lucia", @"CountryName", @"Castries", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Saint Vincent and the Grenadines", @"CountryName", @"Kingstown", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Samoa", @"CountryName", @"Apia", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"San Marino", @"CountryName", @"San Marino", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Sao Tome and Principe", @"CountryName", @"Sao Tome", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Saudi Arabia", @"CountryName", @"Riyadh", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Senegal", @"CountryName", @"Dakar", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Serbia and Montenegro", @"CountryName", @"Belgrade", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Seychelles", @"CountryName", @"Victoria", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Sierra Leone", @"CountryName", @"Freetown", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Singapore", @"CountryName", @"Singapore", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Slovakia", @"CountryName", @"Bratislava", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Slovenia", @"CountryName", @"Ljubljana", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Solomon Islands", @"CountryName", @"Honiara", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Somalia", @"CountryName", @"Mogadishu", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"South Africa", @"CountryName", @"Pretoria", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"South Korea", @"CountryName", @"Seoul", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Spain", @"CountryName", @"Madrid", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Sri Lanka", @"CountryName", @"Colombo", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Sudan", @"CountryName", @"Khartoum", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Suriname", @"CountryName", @"Paramaribo", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Swaziland", @"CountryName", @"Mbabana", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Sweden", @"CountryName", @"Stockholm", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Switzerland", @"CountryName", @"Bern", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Syria", @"CountryName", @"Damascus", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Taiwan", @"CountryName", @"Taipei", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Tajikistan", @"CountryName", @"Dushanbe", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Tanzania", @"CountryName", @"Dar es Salaam", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Thailand", @"CountryName", @"Bangkok", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"The Bahamas", @"CountryName", @"Nassau", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"The Gambia", @"CountryName", @"Banjul", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Togo", @"CountryName", @"Lome", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Tonga", @"CountryName", @"Nuku'alofa", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Trinidad and Tobago", @"CountryName", @"Port-of-Spain", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Tunisia", @"CountryName", @"Tunis", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Turkey", @"CountryName", @"Ankara", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Turkmenistan", @"CountryName", @"Ashgabat", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Tuvalu", @"CountryName", @"Funafuti", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Uganda", @"CountryName", @"Kampala", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Ukraine", @"CountryName", @"Kiev", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"United Arab Emirates", @"CountryName", @"Abu Dhabi", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"United Kingdom", @"CountryName", @"London", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"United States", @"CountryName", @"Washington D.C.", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Uruguay", @"CountryName", @"Montevideo", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Uzbekistan", @"CountryName", @"Tashkent", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Vanuatu", @"CountryName", @"Port-Vila", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Vatican City", @"CountryName", @"Vatican City", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Venezuela", @"CountryName", @"Caracas", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Vietnam", @"CountryName", @"Hanoi", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Yemen", @"CountryName", @"Sanaa", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Zambia", @"CountryName", @"Lusaka", @"Capital", nil]];
    [dataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Zimbabwe", @"CountryName", @"Harare", @"Capital", nil]];
     return dataSource;
}

@end
