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

# Combine date and time into a new temporary variable:
DateTimeTmp <- paste(editData$Date, editData$Time)
#print(head(DateTimeTmp))

# Convert combined date and time format:
DateTimeTmp <- strptime(DateTimeTmp, format='%e/%m/%Y %H:%M:%S')
#print(head(DateTimeTmp))

# Add combined date and time as column to data frame:
editData$DTCombo <- DateTimeTmp

# Remove temporary variable:
remove(DateTimeTmp)

# Change local settings for time to English:
Sys.setlocale('LC_TIME', 'English')

# Specify png graphics device:
png(filename='plot2.png', 
    width = 480,
    height = 480)

# Make plot:
plot(editData$DTCombo,
     editData$Global_active_power, 
     type='l',
     xlab='',
     ylab='Global Active Power (kilowatts)',
     main='')

# Finish plot:
dev.off()
print('Plot has been made and saved.')

# Change local settings for time back to default:
Sys.setlocale('LC_TIME', '')

