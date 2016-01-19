function [ R ] = randomWaveform(adsr,shapes,frequencymin,frequencymax,volumemin,volumemax)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
shape=shapes(randi(4),:)
frequency=frequencymin+(frequencymax-frequencymin)*rand(1,1)
volume=volumemin+(volumemax-volumemin)*rand(1,1)


R=waveform(adsr,shape,frequency,volume);
end

