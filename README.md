# XibDaemon

## Sample Gif:

<p align="center"><img src="https://github.com/riamf/XibDaemon/blob/master/images/XibDeamon.gif" /></p>

## Description

It is a simple Mac OS X application to generate iOS swift code from *.xib files.

## How to use

After designing all UI items in xib the last thing that needs to be done is to write some code that will mirror the UI. 
This is waste of time and can (should be) automated.
There used to be some Xcode plugins, but now there is no possibility to write them and enable them to do code generation for us.

So here is a simple application that with simple Drag&Drop will automatically generate whole source from designed xib file.

- Design your UI in xib file in your iOS project.
- Run the Deamon app.
- Drag&Drop designed xib from your Xcode ProjectNavigator or from directory both ways are ok.
- ...and that is it, Deamon will present generated code that you can copy and paste to your project.
- The only thing left is to connect all the outlets from your project with generated ones.
- If you want to generate new file then press the BIG reset button in Deamon app.


## License
The MIT License (MIT)
