# Pitch Perfect

## Tasks

### Record Sounds View
- [x] Tapping the microphone button will start an audio recording session
- [x] Tapping the button will disable the record button, display a “recording” label, and present a stop button
- [x] When the stop button is clicked, the app should complete its recording and then push the second scene (described below under “Play Sounds View”) onto the navigation stack
- [x] The title in the navigation bar should be “Record”

### Play Sounds View
- [x] The play sounds view has four buttons to play the recorded sound file and a button to stop the playback.
- [x] Chipmunk image → High-pitched sound
- [x] Darth Vader image →  Low-pitched sound
- [x] Snail image → Slow sound
- [x] Rabbit image → Fast sound
- [x] The play sounds view will have been pushed onto the navigation stack. At the top left of the screen, the navigation bar’s left button says “Record”. Clicking this button will pop the play sounds view off the stack and return the user to the record sounds view (which is the default behavior of the navigation bar).
- [x] At this point, the play sounds view should be in its original state. The microphone button should be enabled and the stop button should be hidden.

## Code Improvements

### Record Sounds View
- [x] In the class RecordedAudio, you have currently defined two class variables called title and filePathUrl. The correct way to initialize these is using an initializer, sometimes also called a constructor.  Add an initializer to this class to initialize these properties.
- [x] Then in RecordSoundsViewController, in the function audioRecorderDidFinishRecording, around line 66, call the initializer for RecordedAudio.

### Play Sounds View
- [x] There are a few places where your project contains ‘legacy code’ - code which was at one point functional but has been commented out. For instance around line 19, you create an if statement with a file path to a movie\_quote.mp3. It’s better to remove all experimental and unnecessary commented code for the final release of your app.
- [x] We found a bug in your app. Here is how to replicate it. Record a message for about 10 seconds. Then play it with the chipmunk effect. Soon after the audio starts playing, click the rabbit button to play it really fast. You will find that the chipmunk and the fast effect will overlap. To fix this bug you will need to stop and reset the audioEngine from within the actions playSlowAudio and playFastAudio

### Storyboard
- [x] Always design UI assuming it will be used by someone who knows nothing about this app. This means you should always provide meaningful info on screen that will guide the user. For example your landing page provides no information on how to use the application except a microphone icon. Adding just small message below the icon like “Tap to Record” would give a lot of help in using the application.
- [x] Ideally this message would either disappear when recording is in progress or will say something like “recording in progress”. Also, make sure to update this message when the user comes back to the record screen from the play sounds screen.
