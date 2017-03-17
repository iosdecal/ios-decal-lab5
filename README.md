# Lab 5 : AVFoundation #
Note: Please bring an iPhone or iPad with a camera along with a lightning USB cable to lab if you are able to!

## Due Date ##
Tuesday, March 21st at 11:59 pm

## Overview ##

![](/README-images/camera-preview.gif)

In today's lab, you'll get some experience with part of AVFoundation by creating a camera for your Snapchat Clone, while also becoming more familiar with handling user permissions and looking up information in Apple Developer Documentation. Since this lab requires a hardware camera, you'll be testing your application on an iOS device (iPhone/iPad), rather than in the simulator. Since not all students will have iOS devices, **please partner up with another student who does not have an iPhone/iPad or USB cable if you have iOS device with you.**

## Getting Started ##

For this lab, we will be requiring everyone to submit via the GitHub submission method on Gradescope. If you are unfamiliar with git, this will be good practice for your final project (in which you will need to use git).

Instead of downloading the lab as a zip, you'll need to create a new repository for your changes. You can do this by tapping on "Fork" in the top right of this page. Then open up your terminal, navigate to the directory you want to put your lab in (i.e. `cd Desktop`), and clone your repository using the following command (replace YOUR-USERNAME with your github username). 
	
	git clone https://github.com/YOUR-USERNAME/ios-decal-lab5

This will create a repository on your computer that you can commit and push your changes to (it's good practice to do this frequently). When you are done with the lab make sure you add all of your files to your repository, and push the changes. You can do this using the following commands in your `ios-decal-lab5` folder (type `cd ios-decal-lab5` into terminal to get into the directory if you are not yet in it)

	git add .
	git commit -m "Finished lab 5"
	git push origin master
	
Once you have done this, you can view the files you pushed at https://github.com/YOUR-USERNAME/ios-decal-lab5. You can then use this repository to submit via Gradescope when you are finished (see the **Submission** section below).

## Getting Started ##

Open the project in Xcode and go into the project navigator. Having finished Project 2 Part 1, you should already be familiar with the code provided. 

For this lab, **you will only be editing ImagePickerViewController.swift and it's corresponding View Controller in Storyboard.**

Although skeleton code is provided, feel free to instead use your finished Project 2 code for this lab (you will need to import the code provided in ImagePickerViewController.swift, and update your storyboard).

## Part 1: Connecting your iOS Device ##

Before writing any code, you'll need to connect your iPhone or iPad to your computer via a USB cable. Once you've done that, tap on the simulators drop down, and select your device name

![](/README-images/README-1.png)

Try building. You'll see an error pop up saying "Signing for "snapChatProject" requires a development team. Select a development team in the project editor." To fix this, you'll need to add a signing account, which you can do using an Apple ID. To set your Team Profile, **Open your project file in Xcode, and click "Add Account" in the Team dropdown (see image)**.

![](/README-images/README-2.png)

Once you've set your Team as your Apple ID, try running your app again on your device. If everything's working, you'll see a blank gray view with some buttons (that don't work yet). 

## Part 2: Connecting Outlets ##
Just so you become more familiar with the which views are which, we left the outlets and actions in **ImagePickerViewController.swift** unconnected to storyboard. **Go ahead and connect these outlets and actions in ImagePickerViewController.swift to Main.storyboard**. Make sure to read the comments above each IBOutlet and IBAction, so that you are sure you are connecting the correct outlets and actions. 
 
Since some of the outlets and actions you'll need to connect are to overlapping UI elements, you may find it helpful to open the **Document Outline**. You can drag from Outlets and Actions in code to UI elements in the Document Outline if you find that easier. If you need to delete any connections you made, tap on your ViewController in the Document Outline or in Storyboard, and open the **Connections Inspector** to see all of your connections and delete any if necessary.
![](/README-images/README-3.png)

If you connected all of the outlets correctly, if you try to take a picture, you'll just get an image of squirrel with a neat little leaf hat. Though it is a very nice image, let's replace this with our own custom camera!

## Part 3: Getting User Permissions and Capturing/Displaying Media from User's Device ##

To view real time data collected from your device's camera, we'll be using [AVCaptureSession](https://developer.apple.com/reference/avfoundation/avcapturesession), which is a class of AVFoundation (which we went over in lecture). To get access to the methods and variables associated with AVCaptureSession **start off by importing AVFoundation by adding an import at the top of your file**

We'll also need the following instances variables (**add them to your ImagePickerViewController class**)
	
	// manages real time capture activity from input devices to create output media (photo/video) 
	let captureSession = AVCaptureSession()
	
	// the device we are capturing media from (i.e. front camera of an iPhone 7)
	var captureDevice : AVCaptureDevice?
	
	// view that will let us preview what is being captured from the captureSession
	var previewLayer : AVCaptureVideoPreviewLayer?
	
	// Object used to capture a single photo from our capture device
	let photoOutput = AVCapturePhotoOutput()


**Before beginning on this lab, please look through Overview of the Apple Documentation for [AVCaptureSession](https://developer.apple.com/reference/avfoundation/avcapturephotooutput)** There's a lot of new classes you'll be dealing with, so it will help you get a better grasp of what is going on in the lab. (You also encouraged to check out [AVCaptureVideoPreviewLayer](https://developer.apple.com/reference/avfoundation/avcapturevideopreviewlayer)).

Though the documentation may confuse you a bit right now, you mainly just need to know that `AVCaptureSessions` are objects that allow us to continuously capture media through our user's device (i.e., capture video through the user's camera), and we can view this data on an AVCaptureVideoPreviewLayer (you can't simply add video to a UIView or UIImageView - you must use this preview layer).


Time to get our hands dirty - copy and paste this daunting looking piece of code. Notice the "TODO" sections that you'll need to edit later on.
	
    /// Creates a new capture session, and starts updating it using the user's
    /// input device
    ///
    /// - Parameter devicePostion: location of user's camera - you'll need to figure out how to use this
    func captureNewSession(devicePostion: AVCaptureDevicePosition?) {
        
        // specifies that we want high quality video captured from the device
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        if let deviceDiscoverySession = AVCaptureDeviceDiscoverySession(deviceTypes: [AVCaptureDeviceType.builtInWideAngleCamera], 
						mediaType: AVMediaTypeVideo, position: AVCaptureDevicePosition.unspecified) {
            
            // Iterate through available devices until we find one that works
            for device in deviceDiscoverySession.devices {
                
                // only use device if it supports video
                if (device.hasMediaType(AVMediaTypeVideo)) {
                    if (device.position == AVCaptureDevicePosition.front) {
                        
                        captureDevice = device
                        if captureDevice != nil {
                            // Now we can begin capturing the session using the user's device!
                            do {
                                // TODO: uncomment this line, and add a parameter to `addInput`
                                // try captureSession.addInput()
				
				if captureSession.canAddOutput(photoOutput) {
                                    captureSession.addOutput(photoOutput)
                                }
                            }
                            catch {
                                print(error.localizedDescription)
                            }
                            
                            if let previewLayer = previewLayer { /* TODO: replace this line by creating preview layer from session */
                                view.layer.addSublayer(previewLayer)
                                previewLayer.frame = view.layer.frame
                                // TODO: start running your 
				phosession
                            }
                        }
                    }
                }
            }
        }
    }
    
**Before you try fixing this method, add a function call to `captureNewSession(devicePostion: nil)` to your `viewDidLoad()` method, and  try running your app on your device.** You'll be greeted by the following error:  

> This app has crashed because it attempted to access privacy-sensitive data without a usage description. The app's Info.plist must contain an SOME-DESCRIPTION-KEY-NAME key with a string value explaining to the user how the app uses this data.

All this means is that we need to provide a message to our users asking for permission to use their camera. Let's take a detour from our code to do that now.

### Getting User Permission for Camera Access ##

To request permission to use the user's camera, you'll need to do the following (see the image below for clarification):
 - Navigate to your Project File
 - Click "snapChatProject" from the Targets list
 - Open the "Info" tab (this is linked to that Info.plist file you've probably seen in past projects)
 - Under the section "Custom iOS Target Properties", add a new property with the key given to you in the console crash output
 - Set the value to be whatever you want to be displayed to the user when they try to use your app (typically an explanation of what you are using their camera for)
 
![](/README-images/README-4.png)
    
Now, try running your app again. If all is well, your app should run, except this time you should see an alert asking for permission to use your device's camera. 

### Capturing/Displaying Media from User's Device ##
Navigate back to the `captureNewSession` method you added to your Image Picker View Controller. Right now, this function iterates through all of the devices available on the user's device (microphone, front facing camera, rear facing camera, etc.) While iterating through, it checks if any of the devices supports video. Once it finds one, it will set that device as our captureDevice (that we initialized up above). 

However, just setting the captureDevice won't do us any good. It's your job to **connect this device to our `captureSession`, so that we can start a session using our device's camera.** Once you've done that, **setup the `previewLayer` so that it will display what is being captured during the `captureSession` on the `captureDevice`, and then begin your session capture using `captureSession`** These three  tasks can be done in one line each.

If you were successfull, you should be able to see yourself on your device.

### Part 3: Creating a UIImage from User's Capture Data ##
Next, we'll want to create a single UIImage from this data we recieve from the user's camera, so we can send it as a Snap (as you did in Project 2 Part 1).
	    
To get the photo from the user's camera, we'll be using our `photoOutput` variable we defined previously. Mainly, we will just be using the variable for its method `capturePhoto`.

This is a bit tricky, so here are the steps you need to do this:

- Navigate over to `@IBAction func takePhoto(_ sender: UIButton)`. This IBAction is connected to the "camera button" in our view. Here we will want to "capture the photo" using our `photoOutput` variable. To do this, we will use the AVCapturePhotoOutput method `capturePhoto`. Check out the documentation for this method here: [`capturePhoto` API Reference](https://developer.apple.com/reference/avfoundation/avcapturephotooutput/1648765-capturephoto)
- From the reference link for `capturePhoto`, you can see that the method takes in two parameters, `settings` and a `delegate`. The settings refers to what settings should be used when taking the photo (i.e. whether or not flash should be enabled, if the photo should be in high resolution, etc.  
 - First, to define the settings, create an instance of `AVCapturePhotoSettings`. You can just pass this instance into `capturePhoto` without editing it, but feel free to customize the settings if you wish to (some things you may want to check out / change are `isAutoStillImageStabilizationEnabled` and `isHighResolutionPhotoEnabled`. Note that these are not required for completing the lab)
 - To set the delegate, we need to make a delegate object implementing the `AVCapturePhotoCaptureDelegate` protocol. We will be doing this by making this class that delegate. **Therefore, we need to make this class implement the `AVCapturePhotoCaptureDelegate`. You can do this in the same way you've done for tableViews and collectionViews.** There is one delegate method you must implement, which can be found on the [`AVCapturePhotoCaptureDelegate`](https://developer.apple.com/reference/avfoundation/avcapturephotocapturedelegate) in order to use the `capturePhoto` method. We have partially filled this in for you below: 

	   /// Provides the delegate a captured image in a processed format (such as JPEG).
	   func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
	      if let photoSampleBuffer = photoSampleBuffer {
	         // First, get the photo data using the parameters above
		    let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation( // FILL ME IN )

		    // Then use this data to create a UIImage, and set it equal to `selectedImage`
		    selectedImage = // FILL ME IN

		    // This method updates the UI so the send button appears (no need to edit it)
		    toggleUI(isInPreviewMode: true)
	       }
	   }


- now that you've create the settings and the delegate for `capturePhoto`, you can add the following line of code to `takePhoto`

	  photoOutput.capturePhoto(with: settingsForMonitoring, delegate: self)

By this point, you should be able to take and send photos! 

### Part 4 (OPTIONAL BUT ALSO NOT THAT BAD): Supporting front and back camera ## 
Right now, we can only take pictures using the front camera. To add support for the back camera, look throught that function we created at the beginning of the lab, `captureNewSession(devicePostion: AVCaptureDevicePosition?)`. 

If we wanted to instead use the back camera, we could manually edit the line in `captureNewSession` 

    if (device.position == AVCaptureDevicePosition.front) 

to use the positon ".back" instead. It's your job now to add functionality for toggling between these two cameras (front and back). You'll want to use the `devicePosition` parameter provided, as well as edit the `flipCamera` IBAction to initiate the camera switch.

**HINT:** You may get run into a problem with having multiple inputs on your session (this is because you are not allowed to film with both the front and back camera at the same time). To make sure you are only using one device, make sure to remove all inputs on your `captureSession` by iterating through them (you can use `captureSession.inputs` to get them all), and then calling `captureSession.removeInput(input)`. Then make sure to stop running your `captureSession` by calling `stopRunning()`. This should be done before you iterate through devices in `captureNewSession`.

## Grading ##
Once you have finished, please submit your files to [Gradescope](https://gradescope.com/courses/5482). You will need to submit files EVEN if you are being checked off, since Gradescope does not support submission-less grading at the moment. We have enabled group submission for this assignment, so make sure to include your partner's name if you only worked on one computer.

To submit, please upload your code to either GitHub or Bitbucket, and use the "Github" or "Bitbucket" submission feature on Gradescope (we've experienced the fewest amount of bugs with students who have submitted this way). Please check out the [slides in Lecture 3](http://iosdecal.com/Lectures/Lecture3.pdf) for step-by-step submission instructions if you're confused about how to do this (or ask a TA!)

Checkoff Form for  Akilesh's Lab - 

Checkoff Form for Paige's Lab - https://goo.gl/forms/OqOShJa2FmdCbLoi1

If you are unable to submit via GitHub you can submit your lab as a zip folder (**Note: there will a very good chance we will need to e-mail you asking you to re-submit due to Gradescope zip submission bugs**). To do this please open your ios-decal-lab3 folder, and compress the contents inside (not the folder itself). This should generate a file, **Archive.zip**, that you can submit to Gradescope.
