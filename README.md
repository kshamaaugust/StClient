# stclient
Security Troops Client

## Flutter setup on local:
	export PATH="$PATH:/Library/WebServer/Documents/flutter/flutter/bin"

## Open Simulator:
	open -a Simulator

## make your flutter folder:
	flutter create myApp

## To see all details:
	flutter doctor

## To run flutter app:
	flutter run

## after implement in yaml file:
	flutter pub get

## after import package in amy file:
	flutter packages upgrade

## Upgrade Flutter:
	flutter upgrade
	flutter pub upgrade

## modify .yaml file for using API:
	http: any
	shared_preferences: any  

## After update yaml file run command: 
	flutter pub get

## for use localstorage update yaml file: 
	dependencies:
		localstorage: ^3.0.0

## for use flutterSEcureStorage update yaml file: 
	dependencies:
		flutter_secure_storage: ^3.3.3

## /var/www/apps/time/ForTimeStint/android/app/build.gradle :
	 minSdkVersion 18

## For provide path update in yaml file:
	dependencies:
		path_provider: ^1.6.18

## For provide image picker while upload image:
	dependencies:
		image_picker: ^0.6.6+5

## For change appname while create built:
## Go for path:  /var/www/apps/time/ForTimeStint/android/app/main/AndroidManifest.xml
	<application
		android:label="appname"

## For DropDownFormField, update in yaml:
	dependencies:
		dropdown_formfield: ^0.1.3

## For datetime, update in yaml:
	dependencies:
		datetime_picker_formfield: ^1.0.0

## Add these user permission to AndroidManifest.xml for latitude and longtitude:
	<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
	<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

## For geolocator update in yaml file:
	dependencies:
		geolocator: ^5.1.3
