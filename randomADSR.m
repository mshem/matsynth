function [ A ] = randomADSR(attackmin,attackmax,decaymin,decaymax,sustainmin,sustainmax,releasemin,releasemax,durationmin,durationmax)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
attack=attackmin+(attackmax-attackmin)*rand(1,1);
decay=decaymin+(decaymax-decaymin)*rand(1,1);
sustain=sustainmin+(sustainmax-sustainmin)*rand(1,1);
release=releasemin+(releasemax-releasemin)*rand(1,1);
duration=durationmin+(durationmax-durationmin)*rand(1,1);
A= ADSR(attack, decay, sustain, release, duration);

end

