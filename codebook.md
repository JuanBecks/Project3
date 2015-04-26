Data Dictionary

Subject 2
	Identifies subject
	0 - 30

Activity 
	Identifies activity
		Standing
		Sitting
		Laying
		Walking
		Walk Downstairs
		Walking Upstairs

Domain.Signal
	Identifies characteristic of signal
		t = time domain signal
		f = Fast Fourier Transform (FFT) on time domain signal

Body/Gravity
	Identifies different type of signal
		Body = body signal
		Gravity = gravity signal
		BodyBody

Signal.Source
	Specifies source
		Acc = accelerometer
		Gyro = gyroscope

Jerk/Mag
	Derived signals		
		Jerk = jerk signal
		Mag = magnitude of these three-dimensional signals were calculated using 
		the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag)
		JerkMag

Mean.of.Mean.Value
	A mean of all mean values
		Numeric

Mean.of.Standard.Deviation
	A mean of all standard deviation values