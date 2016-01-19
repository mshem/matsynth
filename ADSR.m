% Authors: Michael Shemesh, Matt Cooper, Andrew Parks
% 4/20

function [A] = ADSR(attack,decay,sustain,release,duration)
% This function has to create an envelope the length of the waveform
% which is shaped according to the adsr parameters.
% First make the array
% check that the params will fit in the waveform
totalmintime=attack+decay+release;
if totalmintime > duration
    % if the attack, decay, and release together are longer than the wave,
    % shrink them
    attack=(attack/totalmintime)*duration;
    decay=(decay/totalmintime)*duration;
    release=(release/totalmintime)*duration;
end
%This part of the envelope goes from 0 to 1 over the attack time
attackArray = (0:(attack*44100))/(attack*44100);
%The decay part goes from 1 to sustain over the decay time
decayArray = ((decay*44100):-1:0)/(decay*44100)*(1-sustain)+sustain;
%The release array goes from sustain to 0 over the relase time
releaseArray = (((release*44100):-1:0)/(release*44100))*sustain;
%The sustain array is constant for the remaining time
sustainArray = ones(1,floor((duration-totalmintime)*44100))*sustain;
%Combine the arrays
A= [attackArray decayArray sustainArray releaseArray];
end
