# foia-decrease
Does Open Data Decrease FOIA requests?

![Total FOIA requests](/total.png?raw=true "Total FOIA Requests")

Omits police, administrative hearings, health, and finance since these all have some data problems right now. The decrease over this period is not statistically significant.

![Dept of Buildings FOIA requests](/buildings.png?raw=true "Dept of Buildings FOIA Requests")

Department of Buildings is the ony Department with a clear decrease in FOIA requests. In the early period, most of the requests in the early period were about permits or building violations, which are now on the Data Portal.

![Non Dept of Buildings FOIA requests](/not_buildings.png?raw=true "Non Dept of Buildings FOIA Requests")

Department of Buildings FOIA requests make up a little less than half of the the total FOIA requests. Omitting this department, the overall number of FOIA requests is clearly increasing.

## Key Questions
- Open Data only seems to strongly substitute for FOIA requests in the building department. How were the FOIA requests for this department different than other departments.
- For efficiencies, the number of requests is not as interesting as effort spent responding to FOIA. What does that look like over time? 

## Notes
To make these images, run the the R script `chi_foia.R`. You need to be connected to the internet as we get the data from the http://data.cityofchicago.org SODA API.

- The police foia data ends in 2013
- The health foia data ends in 2013 and has a bizarre spike in 2012
- Most Administrative Hearings FOIA requests are for case files and often request multiple case files. At the beginning of 2014, Administrative Hearings started listing each case file as a separate line in the FOIA log to reflect the true volume more accurately.

## Thanks
Thanks to Johnathan Levy and Tom Schenk, Jr. for helping me track down some of the weirdnesses in this data.
