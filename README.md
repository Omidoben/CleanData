# CleanData Package: Comprehensive Cleaning for Unemployment Datasets
CleanData is an enhanced R package that provides a solution for cleaning unemployment datasets. Building on the foundation of myPackage, this updated version incorporates extensive features, including detailed documentation, a complete package description, unit tests, and the ability to load and preprocess the required data files seamlessly.

### Example Usage
Here’s how you can use cleanData to clean your unemployment data: 

#### Load the package
library(cleanData)

##### Load and clean the unemployment dataset
Filter on cantons 

clean_unemp(unemp, level_of_interest = "Canton", col_of_interest = active_population)
