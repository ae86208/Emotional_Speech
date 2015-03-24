# Emotional_Speech
Emotional Speech Analysis

This is a project of my undergraduate thesis.
In order to make this working properly, please read the stuff as follows:

1. Make sure that you have STRAIGHT library correctly installed, due to copyright reasons, the library itself is not provided.

2. If you are using Matlab 2012b and before, please change function audioread into legacy waveread for back compatibility.
This problem will be fixed sooner or later, but I still suggest using the up-to-date version for a number of reasons. (Already fixed, but running time slightly affected.)

3. If you are using this to train your own model, specify the path to your library in line 5 in feature_extration.m.

4. For those who are tired of training, or do not have a copy of STRAIGHT, please start the program from section Plot to see the results directly.

5. *.mat files contain features extracted from the audio library, feel free to use these for your own demands.
Note that those .mat files end with _parallel are almost the same as those with no suffix.

6. Through observation, the distribution of time is a little bit unnatural. I find that it is closely related to word seperation errors due to the energy sensitivity of Angry, especially.
Given full consideration, I decide to check the seperation of each file and save those who return the same number of words. This leads to the fact that datasets shrink dramatically, while the result makes sense.

7. The new .wav files are generated through the most up-to-date amazing tool called TANDEM-STRAIGHT. 
Compared with the old version, it is easier to do speech manipulation and the parameters are more directly related to human cognition.
What matters most, it solves the problem of the SNR that could be sensed appearently before.

8. Any problem with this project, please contact ae86208@gmail.com, thanks.
