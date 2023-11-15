/*
26777 Data Processing Using SAS
Autumn 2022
Data Analysis- Assessment 1


Student Name- Kushal Ahuja
Student ID Number- 14191922

*/
/*
Q1

Create a SAS library reference "practice" that refers to "Datasets - Practice" in your personal folder.

Import the Instagram influencer data into a SAS dataset called insta in your practice library.

Import the power plant data into a SAS dataset called power in your practice library.

Import the NFT sales data into a SAS dataset called nft in your practice library.

Ensure that column names of all imported files are valid SAS7 names.
*/
libname practice "/home/u61015946/Kushal_Personal/Dataset_Practice";
options validvarname=v7;

proc import datafile="/home/u61015946/Kushal_Personal/Dataset_Practice/instagram_global_top_1000.csv" 
		dbms=csv out=practice.insta replace;
run;

proc import datafile="/home/u61015946/Kushal_Personal/Dataset_Practice/global_power_plants.csv" 
		dbms=csv out=practice.power replace;
run;

proc import 
		datafile="/home/u61015946/Kushal_Personal/Dataset_Practice/nft_sales.xlsx" 
		dbms=xlsx out=practice.nft replace;
run;

/*
Q2

Explore the Instagram data that you imported into practice.insta.
[2.1] Show that the Scraped column has been imported as a SAS datetime with format DATETIME.
*/
title The Scraped column has been imported as a SAS date with DATETIME format;

proc contents data=practice.insta;
run;

/*
Generate frequency tables for the country and audience_country variables.
Show that there is only 1 distinct value of country.
Show that 143 influencers (14.4%) have an audience in India.
*/
title 1 distinct value of country;

proc freq data=practice.insta;
	tables country audience_country;
run;

title 143 influencers 14.4% have an audience in India;

proc freq data=practice.insta;
	tables country audience_country;
run;

/*
Create a temporary dataset named india from the Instagram table.
The table india should only include rows for which audience_country is equal to India.
Do not include country or scraped in the output table.
[2.2] Show (in your results) that your dataset contains data for 143 influencers.
*/
data india;
	set practice.insta;
	drop country scraped;
	where audience_country='India';
run;

title Dataset contains data for 143 influencers;

proc contents data=india;
run;

/*
Print the top 5 influencers with an Indian audience.
[2.3] Show that the top influencer in India is Cristiano Ronaldo.
*/
title top 5 influencers with an Indian audience;

proc print data=india(obs=5);
run;

title The Top Influencer in India is Cristiano Ronaldo;

proc print data=india (obs=1);
run;

/*
Q3

Generate a frequency table from the Instagram data,
of the Category variable,
for rows where Category contains Music.
[3.1] Show that 10 influencers are in both the Music and Lifestyle categories.
*/
title Frequency table from the instagram data;

proc freq data=practice.insta;
	tables category;
	where category='Music';
run;

/*Show that 10 influencers are in both the Music and Lifestyle categories.*/
title 10 influencers are in both the Music and Lifestyle categories;

proc print data=practice.insta;
	where category='Music|Lifestyle';
run;

/*
Create a temporary dataset called music from the spotify table,
containing rows where Category contains Music.
Calculate the average Rank and Followers for this table.
[3.2] Show that the average rank is 465 and average followers around 28,595,000.
*/
data music;
	set practice.insta;
	where category contains 'Music';
run;

title Average Rank is 465 and Average Followers are around 28, 595, 000;

proc means data=music;
	var rank followers;
run;

/*
Q4

Using the power plant data,
produce detailed summary statistics of the estimated generation capacity in 2020 [estimated_generation_gwh_2020],
for Australian power plants
[4.1] Show that there are 25 missing values.
*/
title There are 25 missing values for estimated_generation_gwh_2020;

proc univariate data=practice.power;
	var estimated_generation_gwh_2020;
	where country='Australia';
run;

/*
Make a new temporary dataset auspower,
containing Australian power plants,
removing any plants where estimated generation capacity in 2020 is missing,
and drop the start date, country, and country code variables.
Re-run detailed summary statistics on this data.
[4.2] Show that the median generation capacity is 111 GWh.
*/
data auspower;
	set practice.power;
	where estimated_generation_gwh_2020 is not missing and country='Australia';
	drop start_date country country_code;
run;

title Median generation capacity is 111 GWh;

proc univariate data=auspower;
	var estimated_generation_gwh_2020;
run;

/*
From your auspower dataset,
calculate the average capacity in MW and average estimated generation capacity in 2020,
for each kind of primary fuel.
[4.3] Show that the average capacity of Australian solar installations was 60.3 MW.
*/
title Coal average capacity in MW and average estimated generation capacity;
%let fuel = Coal;

proc means data=auspower;
	where primary_fuel="&fuel";
	var capacity_in_MW estimated_generation_gwh_2020;
run;

title Gas average capacity in MW and average estimated generation capacity;
%let fuel = Gas;

proc means data=auspower;
	where primary_fuel="&fuel";
	var capacity_in_MW estimated_generation_gwh_2020;
run;

title Hydro average capacity in MW and average estimated generation capacity;
%let fuel = Hydro;

proc means data=auspower;
	where primary_fuel="&fuel";
	var capacity_in_MW estimated_generation_gwh_2020;
run;

title Oil average capacity in MW and average estimated generation capacity;
%let fuel = Oil;

proc means data=auspower;
	where primary_fuel="&fuel";
	var capacity_in_MW estimated_generation_gwh_2020;
run;

title Solar average capacity in MW and average estimated generation capacity;
%let fuel =Solar;

proc means data=auspower;
	where primary_fuel="&fuel";
	var capacity_in_MW estimated_generation_gwh_2020;
run;

title Waste average capacity in MW and average estimated generation capacity;
%let fuel =Waste;

proc means data=auspower;
	where primary_fuel="&fuel";
	var capacity_in_MW estimated_generation_gwh_2020;
run;

title Wind average capacity in MW and average estimated generation capacity;
%let fuel =Wind;

proc means data=auspower;
	where primary_fuel="&fuel";
	var capacity_in_MW estimated_generation_gwh_2020;
run;

/*Show that the average capacity of Australian solar installations was 60.3 MW. */
title The average capacity of Australian solar installations was 60.3 MW;
%let primary_fuel =Solar;

proc means data=auspower;
	where primary_fuel="&primary_fuel";
	var capacity_in_MW estimated_generation_gwh_2020;
run;

/*
Q5

Print 10 rows of the NFT data,
applying a temporary format to sales to display it in dollars.
[5.1] Show that the total sales for Axie Infinity is $3,328,148,500.
*/
title Total sales for Axie Infinity is $3, 328, 148, 500;

proc print data=practice.nft(obs=10);
	format sales dollar20.0;
run;

/*
Create a new temporary dataset named nft_groups from the NFT data,
applying a permanent format to sales to display it in dollars.

Make a new variable `avg_txn_value` in nft_groups to show the average transaction value
(the total sales divided by the number of transactions),
also formatted as dollars.

Make a new variable `group` in nft_groups, such that:
if the collection name contains 'Ape' then group is 'Apes'
else if the collection name contains 'Cat' then group is 'Cats'
else if the collection name contains 'Punk' then group is 'Punks'
otherwise, the group is 'Other',
using case-insensitive matching.

[5.2] Show that 12 NFTs (4.8%) are in the Cats group
*/
data nft_groups;
	set practice.nft;
	format sales dollar15.0;
	avg_txn_value=sum(sales)/txns;
	format avg_txn_value dollar20.0;
	length group $20.0;
	collections=upcase(collections);

	if find(collections, 'Ape', 'i') ge 1 then
		group='Apes';
	else if find(collections, 'Cat', 'i') ge 1 then
		group='Cats';
	else if find (collections, 'Punk', 'i')ge 1 then
		group='Punks';
	else
		group='Other';
run;

title 12 NFTs (4.8)% are in the cats group;

proc freq data=nft_groups;
	tables group;
run;

/*
[5.3] Show that the average transaction value for Mooncats is $3,002.
*/
title The average transaction value for Mooncats is $3, 002;

proc print data=nft_groups;
	where collections='MOONCATS';
	var avg_txn_value collections;
run;

/*
Sort your nft_groups dataset by average transaction value
into a new dataset nft_txn_value.
[5.4] Show that the Deafbeef NFT has the highest average transaction value.
*/
data nft_txn_value;
	set nft_groups;
run;

proc sort data=nft_groups out=nft_txn_value_sorted;
	by descending avg_txn_value;
run;

title the Deafbeef NFT has the highest average transaction value;

proc print data=nft_txn_value;
	where avg_txn_value > 40000;
run;

/*
Define a macro variable analysis_group.
Use your macro variable to:
 * Print the top 10 NFTs in the Apes group, according to average transaction value.
 * Put a title on your output: "Top Apes NFTs by average transaction size"
Repeat this analysis for the Punks group by changing the value of analysis_group.
[5.5] Show that CryptoPunks has the highest average transaction value in the Punks group.
 */

%let analysis_group = Apes;
title Top Apes NFTs by average transaction size;

proc print data=nft_txn_value_sorted (obs=10);
	where group="&analysis_group";
run;

%let analysis_group = Punks ;
title Top Punks NFTs by average transaction size;

proc print data=nft_txn_value_sorted (obs=10);
	where group="&analysis_group";
run;

%let analysis_group = Punks ;
title CryptoPunks has the highest average transaction value in the Punks group;

proc print data=nft_txn_value_sorted (obs=1);
	where group="&analysis_group";
run;