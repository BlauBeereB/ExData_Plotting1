# Note: The data file 'called household_power_consumption.txt' 
# needs to be in a subfolder called 'exdata'.

# Clear any old variables:
rm(list = ls())

# Set name for directory with data files:
dataDir <- "exdata"

# Set names for original and new data file:
origFileName <- 'household_power_consumption.txt'
editFileName <- 'household_power_consumption.r'

# Load previously saved data set or 
# create edited data set with relevant data:
if (file.exists(editFileName)) {
    # Load previously saved data set:
    load(editFileName)
    print('Edited data set has been loaded from file.')
} else {
    # Read in the data set:
    origDataPath <- paste0(dataDir, '/', origFileName) 
    origData <- read.table(origDataPath, 
                           header = TRUE, 
                           sep = ';', 
                           na.strings = '?', 
                           stringsAsFactors = FALSE,
                           colClasses = c('character',
                                           'character',
                                           'numeric',
                                           'numeric', 
                                           'numeric',
                                           'numeric',
                                           'numeric',
                                           'numeric',
                                           'numeric'))
    
    # Inspect the original data set:
    #print(head(origData))
    #print(str(origData))
    
    # Only keep data from 1/2/2007 and 2/2/2007:
    editData <- subset(origData, Date == '1/2/2007' | 
                                Date == '2/2/2007')
    
    # Delete variables that are not needed anymore:
    remove(origDataPath)
    remove(origData)
    
    # Save edited data set:
    save(editData, file=editFileName)
    
    print('Edited data set has been loaded from file.')
}

# Delete variables that are not needed anymore:
remove(origFileName)
remove(editFileName)

# Inspect the edited data set:
#print(head(editData))
#print(str(editData))
print(summary(editData$Global_active_power))

# Specify png graphics device:
png(filename='plot1.png', 
    width = 480,
    height = 480)

# Make histogram:
hist(editData$Global_active_power, 
     col='red', 
     xlab='Global Active Power (kilowatts)',
     main='Global Active Power')

# Finish plot:
dev.off()
print('Plot has been made and saved.')
