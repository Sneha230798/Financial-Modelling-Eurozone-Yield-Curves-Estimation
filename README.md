# Financial Modelling: Eurozone Yield Curves Estimation

## Introduction

In the realm of finance, accurate modeling of interest rates and discount factors is crucial for effective investment strategies and risk management. This project focuses on estimating discount factors and interest rate yield curves for sovereign and corporate bonds in the Eurozone, leveraging daily data from 2010 to 2023.

Utilizing a comprehensive dataset that includes bond prices, days to maturity, coupon payments, and credit default swaps (CDS), this analysis employs spline regression to generate precise yield curves for individual countries and the Eurozone as a whole. The outcomes of this project aim to enhance the understanding of interest rate dynamics within the Euro area, providing valuable insights for investors and policymakers alike.

## Data Sources

The data for this analysis has been sourced from **Refinitiv Datastreams**. For more information regarding Datastreams, please refer to the following link: [Refinitiv Datastreams](#) *(insert link here)*.

The dataset includes:

1. **Daily Bond Prices** for Sovereign Bonds from the following Eurozone countries:
   - Germany
   - France
   - Italy
   - Austria
   - Belgium
   - Croatia
   - Cyprus
   - Finland
   - Ireland
   - Netherlands
   - Portugal
   - Slovakia
   - Slovenia
   - Spain

2. **Daily Sovereign CDS Prices** for the above countries.

3. **Daily Corporate Bonds and CDS Prices** for major corporations within these countries.

From the data provided in Datastreams, the **Days to Maturity** and **Coupon Payments** for these bonds have been calculated and utilized in further analysis.

## Usage

This project employs **Jupyter Notebook** to create the Days to Maturity (DTM) and Coupon files from the raw data. Once these files are prepared, the project utilizes **MATLAB** to estimate the discount rates using spline regression. The resulting discount factors are then converted into interest rates and plotted over time to estimate the yield curves.

The visualizations are provided in the **Visualizations** folder for further analysis and interpretation.
