libname Terror '~/Terror';

/*
 * Inputting Data
 */

data gtd;
infile '~/Terror/gtdraw.csv' DSD FIRSTOBS = 2 MISSOVER;
input
	eventid iyear imonth iday approxdate $ extended	resolution $ country country_txt $
	region region_txt $	provstate $ city $ latitude longitude specificity vicinity
	location $ summary $ crit1 crit2 crit3 doubtterr alternative alternative_txt $
	multiple success suicide attacktype1 attacktype1_txt $ attacktype2 attacktype2_txt $
	attacktype3 attacktype3_txt $ targtype1	targtype1_txt $ targsubtype1 targsubtype1_txt $
	corp1 $	target1 $ natlty1 natlty1_txt $ targtype2 targtype2_txt $ targsubtype2
	targsubtype2_txt $ corp2 $ target2 $ natlty2 natlty2_txt $ targtype3 targtype3_txt $
	targsubtype3 targsubtype3_txt $ corp3 $ target3 $ natlty3 natlty3_txt $ gname $
	gsubname $ gname2 $ gsubname2 $ gname3 $ gsubname3 $ motive $ guncertain1
	guncertain2	guncertain3	individual nperps nperpcap claimed claimmode claimmode_txt $
	claim2 claimmode2 claimmode2_txt $ claim3 claimmode3 claimmode3_txt $ compclaim
	weaptype1 weaptype1_txt $ weapsubtype1 weapsubtype1_txt $ weaptype2 weaptype2_txt $
	weapsubtype2 weapsubtype2_txt $ weaptype3 weaptype3_txt $ weapsubtype3 weapsubtype3_txt $
	weaptype4 weaptype4_txt $ weapsubtype4 weapsubtype4_txt $ weapdetail $ nkill nkillus
	nkillter nwound	nwoundus nwoundte property propextent propextent_txt $ propvalue
	propcomment $ ishostkid nhostkid nhostkidus nhours ndays divert $ kidhijcountry $
	ransom ransomamt ransomamtus ransompaid ransompaidus ransomnote hostkidoutcome
	hostkidoutcome_txt $ nreleased addnotes $ scite1 $ scite2 $ scite3 $ dbsource $
	INT_LOG	INT_IDEO INT_MISC INT_ANY related $
;
run;

data cpost;
infile '~/Terror/cpostraw.csv' DSD FIRSTOBS = 2 MISSOVER;
length
	location_names $35.
	attack_date $15.
;
input
	attack_id location_names $ campaign_name $ verified $ attack_date 
	number_killed number_wounded
;
run;


/*
 * These tables have been created to validate the data.
 */
title 'Figure 3: Printing Invalid Data: GTD (First 10 Invalid Data Points)';
proc print data = gtd (OBS = 10) NOOBS;
var eventid iday imonth iyear nkill nwound;
where
iday < 1 OR iday > 31
OR imonth < 1 OR imonth > 12 
OR iyear < 1970 OR iyear > 2018
OR nkill < 0 OR nwound < 0;
run;

title 'Figure 4: Frequency Table for Validation GTD';
proc freq data = gtd NLEVELS;
tables region success attacktype1 suicide targtype1 weaptype1 property ransom;
run;

/*
 * The following table does not print out because it is empty
 */
title 'Printing Invalid Data: CPOST (First 10 Invalid Data Points)';
proc print data = cpost (OBS = 10) NOOBS;
where
number_killed < 0 OR number_wounded < 0;
run;


/*
 * The following formats have been created for variables in the GTD Dataset.
 */
proc format;
value cty
4 = 'Afghanistan' 5 = 'Albania' 6 = 'Algeria' 7 = 'Andorra' 8 = 'Angola' 10 = 'Antigua and Barbuda'
11 = 'Argentina' 12 = 'Armenia' 14 = 'Australia' 15 = 'Austria' 16 = 'Azerbaijan'
17 = 'Bahamas' 18 = 'Bahrain' 19 = 'Bangladesh' 20 = 'Barbados' 21 = 'Belgium'
22 = 'Belize' 23 = 'Benin' 24 = 'Bermuda' 25 = 'Bhutan' 26 = 'Bolivia' 28 = 'Bosnia-Herzegovina'
29 = 'Botswana' 30 = 'Brazil' 31 = 'Brunei' 32 = 'Bulgaria' 33 = 'Burkina Faso' 34 = 'Burundi'
35 = 'Belarus' 36 = 'Cambodia' 37 = 'Cameroon' 38 = 'Canada' 40 = 'Cayman Islands' 
41 = 'Central African Republic' 42 = 'Chad' 43 = 'Chile' 44 = 'China' 45 = 'Colombia' 
46 = 'Comoros' 47 = 'Republic of the Congo' 49 = 'Costa Rica' 50 = 'Croatia' 51 = 'Cuba'
53 = 'Cyprus' 54 = 'Czech Republic' 55 = 'Denmark' 56 = 'Djibouti' 57 = 'Dominica'
58 = 'Dominican Republic' 59 = 'Ecuador' 60 = 'Egypt' 61 = 'El Salvador' 62 = 'Equatorial Guinea'
63 = 'Eritrea' 64 = 'Estonia' 65 = 'Ethiopia' 66 = 'Falkland Islands' 67 = 'Fiji' 68 = 'Finland'
69 = 'France' 70 = 'French Guiana' 71 = 'French Polynesia' 72 = 'Gabon' 73 = 'Gambia'
74 = 'Georgia' 75 = 'Germany' 76 = 'Ghana' 77 = 'Gibraltar' 78 = 'Greece' 79 = 'Greenland'
80 = 'Grenada' 81 = 'Guadeloupe' 83 = 'Guatemala' 84 = 'Guinea' 85 = 'Guinea-Bissau'
86 = 'Guyana' 87 = 'Haiti' 88 = 'Honduras' 89 = 'Hong Kong' 90 = 'Hungary' 91 = 'Iceland'
92 = 'India' 93 = 'Indonesia' 94 = 'Iran' 95 = 'Iraq' 96 = 'Ireland' 97 = 'Israel' 98 = 'Italy'
99 = 'Ivory Coast' 100 = 'Jamaica' 101 = 'Japan' 102 = 'Jordan' 103 = 'Kazakhstan' 104 = 'Kenya'
106 = 'Kuwait' 107 = 'Kyrgyzstan' 108 = 'Laos' 109 = 'Latvia' 110 = 'Lebanon' 111 = 'Lesotho'
112 = 'Liberia' 113 = 'Libya' 114 = 'Liechtenstein' 115 = 'Lithuania' 116 = 'Luxembourg'
117 = 'Macau' 118 = 'Macedonia' 119 = 'Madagascar' 120 = 'Malawi' 121 = 'Malaysia'
122 = 'Maldives' 123 = 'Mali' 124 = 'Malta' 125 = 'Isle of Man' 128 = 'Mauritania'
129 = 'Mauritius' 130 = 'Mexico' 132 = 'Moldova' 134 = 'Mongolia' 136 = 'Morocco'
137 = 'Mozambique' 138 = 'Myanmar' 139 = 'Namibia' 141 = 'Nepal' 142 = 'Netherlands'
143 = 'New Caledonia' 144 = 'New Zealand' 145 = 'Nicaragua' 146 = 'Niger' 147 = 'Nigeria'
149 = 'North Korea' 151 = 'Norway' 152 = 'Oman' 153 = 'Pakistan' 155 = 'West Bank and Gaza Strip'
156 = 'Panama' 157 = 'Papua New Guinea' 158 = 'Paraguay' 159 = 'Peru' 160 = 'Philippines'
161 = 'Poland' 162 = 'Portugal' 163 = 'Puerto Rico' 164 = 'Qatar' 166 = 'Romania'
167 = 'Russia' 168 = 'Rwanda' 173 = 'Saudi Arabia' 174 = 'Senegal' 175 = 'Serbia-Montenegro'
176 = 'Seychelles' 177 = 'Sierra Leone' 178 = 'Singapore' 179 = 'Slovak Republic'
180 = 'Slovenia' 181 = 'Solomon Islands' 182 = 'Somalia' 183 = 'South Africa'
184 = 'South Korea' 185 = 'Spain' 186 = 'Sri Lanka' 189 = 'St. Kitts and Nevis'
190 = 'St. Lucia' 192 = 'St. Martin' 195 = 'Sudan' 196 = 'Suriname' 197 = 'Swaziland'
198 = 'Sweden' 199 = 'Switzerland' 200 = 'Syria' 201 = 'Taiwan' 202 = 'Tajikistan'
203 = 'Tanzania' 204 = 'Togo' 205 = 'Thailand' 206 = 'Tonga' 207 = 'Trinidad and Tobago'
208 = 'Tunisia' 209 = 'Turkey' 210 = 'Turkmenistan' 213 = 'Uganda' 214 = 'Ukraine'
215 = 'United Arab Emirates' 216 = 'Great Britain' 217 = 'United States' 218 = 'Uruguay'
219 = 'Uzbekistan' 220 = 'Vanuatu' 221 = 'Vatican City' 222 = 'Venezuela' 223 = 'Vietnam'
226 = 'Wallis and Futuna' 228 = 'Yemen' 229 = 'Democratic Republic of the Congo'
230 = 'Zambia' 231 = 'Zimbabwe' 233 = 'Northern Ireland' 235 = 'Yugoslavia' 236 = 'Czechoslovakia'
238 = 'Corsica' 334 = 'Asian' 347 = 'East Timor' 349 = 'Western Sahara' 351 = 'Commonwealth of Independent States'
359 = 'Soviet Union' 362 = 'West Germany (FRG)' 377 = 'North Yemen' 403 = 'Rhodesia'
406 = 'South Yemen' 422 = 'International' 428 = 'South Vietnam' 499 = 'East Germany (GDR)'
520 = 'Sinhalese' 532 = 'New Hebrides' 603 = 'United Kingdom' 604 = 'Zaire'
605 = 'Peoples Republic of the Congo' 999 = 'Multinational' 1001 = 'Serbia' 1002 = 'Montenegro'
1003 = 'Kosovo' 1004 = 'South Sudan'
;
run;

proc format;
value tar
1 = 'Business'
2 = 'Government'
3 = 'Police'
4 = 'Military'
5 = 'Abortion Related'
6 = 'Airports & Aircraft'
7 = 'Government (Diplomatic)'
8 = 'Educational Institution'
9 = 'Food or Water Supply'
10 = 'Journalists & Media'
11 = 'Martime (Includes Ports and Martime Facacilites'
12 = 'NGO'
13 = 'Other'
14 = 'Private Citizens & Property'
15 = 'Religious Figures/Institutions'
16 = 'Telecommunication'
17 = 'Terrorists/Non-state Militias'
18 = 'Tourists'
19 = 'Transportation (Other than Aviation)'
20 = 'Unknown'
21 = 'Utilities'
22 = 'Violent Political Parties'
;
run;

proc format;
value wpn
1 = 'Biological'
2 = 'Chemical'
3 = 'Radiological'
4 = 'Nuclear'
5 = 'Firearms'
6 = 'Explosives/Bombs/Dynamite'
7 = 'Fake Weapons'
8 = 'Incendiary'
9 = 'Melee'
10 = 'Vechile'
11 = 'Sabotage Equipment'
12 = 'Other'
13 = 'Unknown'
;
run; 

proc format;
value atk
1 = 'Assassination'
2 = 'Armed Assault'
3 = 'Bombing/Explosion'
4 = 'Hijacking'
5 = 'Hostage Taking (Barricade Incident)'
6 = 'Hostage Taking (Kidnapping)'
7 = 'Facility/Infrastructure Attack'
8 = 'Unarmed Assault'
9 = 'Unknown'
;
run;

proc format;
value bina
1 = 'Yes'
0 = 'No'
;
run;

proc format;
value binb
1 = 'Yes'
0 = 'No'
-9, . = 'Unknown'

;

proc format;
value reg
1 = 'North America'
2 = 'Central America & Caribbean'
3 = 'South America'
4 = 'East Asia'
5 = 'Southeast Asia'
6 = 'South Asia'
7 = 'Central Asia'
8 = 'Western Europe'
9 = 'Eastern Europe'
10 = 'Middle East & North Africa'
11 = 'Sub-Saharan Africa'
12 = 'Australasia & Oceania'
;
run;

proc format;
value unk
-99 = 'Unknown'
. = 'Unknown'
;
run;

/*
 * The following data step cleans the GTD dataset and keeps the information deemed important
 * for this project.
 */
data gtdcleaned;
set gtd;

if iday NE 0;
if imonth NE 0;
if iyear NE 0;

Date = mdy(imonth,iday,iyear);

format
	date yymmdd10.
	country cty.
	success bina.
	suicide bina.
	attacktype1 atk.
	region reg.
	targtype1 tar.
	weaptype1 wpn.
	property binb.
	ransom binb.
	nperps unk.
;
label
	country = 'Incident Location: Country'
	region = 'Incident Location: Region'
	success = 'Successful Attack?'
	suicide = 'Suicide Attack?'
	attacktype1 = 'Type of Attack'
	nperps = 'Number of Perpetrators' 
	targtype1 = 'Target/Victim Type'
	weaptype1 = 'Weapon Type'
	nkill = 'Total Number of Deaths'
	nwound = 'Total Number of Wounded'
	property = 'Property Damage'
	ransom = 'Ransom Demanded'
;
keep
	date
	country
	region
	success
	attacktype1
	suicide
	targtype1
	nperps
	weaptype1
	nkill
	nwound
	property
	ransom
;
run;

/*
 * The following data step cleans the CPOST dataset and keeps the information deemed important
 * for this project.
 */
data cpostcleaned;
set cpost;
drop
	attack_id
	campaign_name
	verified
;
label 
	location_names = 'Incident Location: Country'
	attack_date = 'Date'
	number_killed = 'Total Number of Deaths'
	number_wounded = 'Total Number of Wounded'
;
run
;

title 'Figure 5: Contents of Cleaned GTD Dataset';
proc contents data = gtdcleaned;
run;

title 'Figure 6: Contents of Cleaned CPOST Dataset';
proc contents data = cpostcleaned;
run;

title 'Figure 1: Sample Results from GTD Dataset';
proc print data = gtdcleaned (OBS = 10) LABEL NOOBS;
var 
	date
	country
	region
	success
	attacktype1
	suicide
	targtype1
	nperps
	weaptype1
	nkill
	nwound
	property
	ransom
;
run;

title 'Figure 2: Sample Results from CPOST Dataset';
proc print data = cpostcleaned (OBS = 10) LABEL NOOBS;
var
	attack_date
	location_names
	number_killed
	number_wounded
;
run;

title 'Figure 7: Descriptive Statistics from GTD Dataset';
proc means data = gtdcleaned MIN MAX MEDIAN MEAN MAXDEC = 3;
var nkill nwound;
run;

title 'Figure 8: Descriptive Statistics from CPOST Dataset';
proc means data = cpostcleaned MIN MAX MEDIAN MEAN MAXDEC = 3;
var number_killed number_wounded;
run;

/*
 * This format was created to have better organized frequency tables for the number of deaths.
 */
proc format;
value ded
0 = '0'
1-5 = '1 to 5'
6-10 = '6 to 10'
11-50 = '11 to 50'
51-100 = '51 to 100'
101-200 = '101 to 200'
201-300 = '201 to 300'
301-high = 'More than 300'
;
run;


title 'Figure 9: Frequency Table Number of Deaths from GTD Dataset';
proc freq data = gtdcleaned;
format nkill ded.;
tables nkill;
run;

title 'Figure 10: Frequency Table Number of Deaths from CPOST Dataset';
proc freq data = cpostcleaned;
format number_killed ded.;
tables number_killed;
run;