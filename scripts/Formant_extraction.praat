#################################################################################
#
# This script extracts F1, F2, F3, and duration from all phonemes in a Sound file at 12.5; 25; 37.5; 50; 67.5; 75 and 87.5% of the duration of the sound.
# It assumes phonemes are on Tier 3 and words are on Tier 2.
# It outputs this information to C:\Users\mkingma\Dropbox\Diftongearring lange i\Metingen
#
# To run this script, open a Sound and TextGrid in Praat and have them selected.
#
# 
# Latest amends were made by Martijn Kingma at 01/03/2023
# m.kingma@fryske-akademy.nl
##################################################################################

writeInfoLine: "Extracting formants..., did you change the ceiling yet?"

# Extract the names of the Praat objects
thisSound$ = selected$("Sound")
thisTextGrid$ = selected$("TextGrid")

# Extract the number of intervals in the phoneme tier
select TextGrid 'thisTextGrid$'
numberOfPhonemes = Get number of intervals: 3  
appendInfoLine: "There are ", numberOfPhonemes, " intervals."

# Create the Pitch Object
 select Sound 'thisSound$'
 To Pitch... 0.01 100 600

# Create the Formant Object
select Sound 'thisSound$'
To Formant (burg)... 0 5 5500 0.025 50

# Create the output file and write the first line.
outputPath$ = "C:\Users\Martijn\Dropbox\Meetings\20230102_Issue laten zien\formants.csv"
writeFileLine: "'outputPath$'", "file,timepoint,word,phoneme,duration,F0,F1,F2,F3,F0,F1,F2,F3,F0,F1,F2,F3,F0,F1,F2,F3,F0,F1,F2,F3,F0,F1,F2,F3,F0,F1,F2,F3"

# Loop through each interval on the phoneme tier.
for thisInterval from 1 to numberOfPhonemes
    #appendInfoLine: thisInterval

    # Get the label of the interval
    select TextGrid 'thisTextGrid$'
    thisPhoneme$ = Get label of interval: 3, thisInterval
    #appendInfoLine: thisPhoneme$
      
    # Find the points of measurement.
    thisPhonemeStartTime = Get start point: 3, thisInterval
    thisPhonemeEndTime   = Get end point:   3, thisInterval
    duration = thisPhonemeEndTime - thisPhonemeStartTime
    twelve = thisPhonemeStartTime + duration*0.125
    twentyfive = thisPhonemeStartTime + duration*0.25
    thirtyseven = thisPhonemeStartTime + duration*0.375
    fifty = thisPhonemeStartTime + duration/2
    sixtyseven = thisPhonemeStartTime + duration*0.675
    seventyfive = thisPhonemeStartTime + duration*0.75
    eightyseven = thisPhonemeStartTime + duration*0.875
    
    # Get the word interval and then the label
    thisWordInterval = Get interval at time: 2, fifty
    thisWord$ = Get label of interval: 2, thisWordInterval

    # Extract F0 measurements
    select Pitch 'thisSound$'
    f012 = Get value at time... twelve Hertz Linear
    f025 = Get value at time... twentyfive Hertz Linear
    f037 = Get value at time... thirtyseven Hertz Linear
    f050 = Get value at time... fifty Hertz Linear
    f067 = Get value at time... sixtyseven Hertz Linear
    f075 = Get value at time... seventyfive Hertz Linear
    f087 = Get value at time... eightyseven Hertz Linear
      
    # Extract formant measurements
    select Formant 'thisSound$'
    f112 = Get value at time... 1 twelve Hertz Linear
    f212 = Get value at time... 2 twelve Hertz Linear
    f312 = Get value at time... 3 twelve Hertz Linear
    f125 = Get value at time... 1 twentyfive Hertz Linear
    f225 = Get value at time... 2 twentyfive Hertz Linear
    f325 = Get value at time... 3 twentyfive Hertz Linear
    f137 = Get value at time... 1 thirtyseven Hertz Linear
    f237 = Get value at time... 2 thirtyseven Hertz Linear
    f337 = Get value at time... 3 thirtyseven Hertz Linear
    f150 = Get value at time... 1 fifty Hertz Linear
    f250 = Get value at time... 2 fifty Hertz Linear
    f350 = Get value at time... 3 fifty Hertz Linear
    f167 = Get value at time... 1 sixtyseven Hertz Linear
    f267 = Get value at time... 2 sixtyseven Hertz Linear
    f367 = Get value at time... 3 sixtyseven Hertz Linear
    f175 = Get value at time... 1 seventyfive Hertz Linear
    f275 = Get value at time... 2 seventyfive Hertz Linear
    f375 = Get value at time... 3 seventyfive Hertz Linear
    f187 = Get value at time... 1 eightyseven Hertz Linear
    f287 = Get value at time... 2 eightyseven Hertz Linear
    f387 = Get value at time... 3 eightyseven Hertz Linear

    # Save to a spreadsheet
    appendFileLine: "'outputPath$'", 
                      ...thisSound$, ",",
                      ...fifty, ",",
                      ...thisWord$, ",",
                      ...thisPhoneme$, ",",
                      ...duration, ",",
                      ...f012, ",",
                      ...f112, ",",
                      ...f212, ",", 
                      ...f312, ",", 
                      ...f025, ",",
                      ...f125, ",", 
                      ...f225, ",", 
                      ...f325, ",",
                      ...f037, ",",
                      ...f137, ",", 
                      ...f237, ",", 
                      ...f337, ",",
                      ...f050, ",",
                      ...f150, ",", 
                      ...f250, ",", 
                      ...f350, ",",
                      ...f067, ",",
                      ...f167, ",", 
                      ...f267, ",", 
                      ...f367, ",",
                      ...f075, ",",
                      ...f175, ",", 
                      ...f275, ",", 
                      ...f375, ",",
                      ...f087, ",",
                      ...f187, ",", 
                      ...f287, ",", 
                      ...f387
endfor

appendInfoLine: newline$, newline$, "Whoo-hoo! It didn't crash!"