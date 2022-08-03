# garmin
Software development for Garmin GPSMAP

README
======

Overview
========
QBoard is a simple widget to implement a basic soft keyboard for Garmin devices with a large screen, such s the GPSMAP 66i.

As such, it is just a demonstrator of the approach and something I just wanted to do. I am aware Garmin already have a keyboard for entering text, for example using the InReach App, still it was an interesting challenge.

As a widget or an app, it could be part of a Notepad to make notes when outdoors. Yes, mobile phones do this too and Garmin may also provide the capability one way or another, but it is cool to just do it yourself.

QBoard implements:
- A soft keyboard (QB)
- A text area that breaks lines to fit inside the specified space (QPad)
- A character selection object (QBox)
- Basic navigation of the contents of the QPad (with a future edit capability)

Notes
=====
The architecture of the app is very much Object-Oriented. An alternative approach could have been a collection of classes with static methods (as instantiation is not needed ,strictly speaking) following a functional paradigm. 

Licensing
=========
All the code is subject to the MIT license agreement. Qboard does not directly use anybody else's code, but anyone can use it for whatever purposes subject to the MIT license terms.

Authors
=======
- Lars Andersson from Larssentech Labs. 

It would be interesting for me to know if anyone finds this Widget useful for anything. You can contact me at 'software@larssentech.org'.

Acknowledgements
================
Thanks to Douglas Robertson (Git: [douglasr]) for his 'geeky' work on 'all things ConnectIQ'. Although I have not used his code directly, I gained insight on event handling from his work.

His Git repo is available on: https://github.com/douglasr/connectiq-samples.git

Git Repo for QBoard
===================
https://github.com/Larssentech/garmin.git

[end]

