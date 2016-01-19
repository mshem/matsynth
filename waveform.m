% Authors: Michael Shemesh, Matt Cooper, Andrew Parks
% 4/20
function [ Y ] = waveform(ADSR,shape,frequency, volume)
% This function creates a set of data representing a sound wave
% volume should be a % of the max volume. 1 is full volume.
% duration in seconds is the length of the sound. we assume a sample rate
% of 44100
duration=length(ADSR)/44100;
X=0:1/44100:duration;
switch shape % shape is the type of wave
    case 'sin'
        Y=sin(2*pi*frequency*X)*volume; % here is where well add ADSR envelope by multiplying volume by the envelope
    case 'square'
        period=(1/frequency);
        time=period*44100;  % need to make array of ones and negative ones
        s=0:1:time/2;
        s0=s*0-1;   % -1
        s1=s*0+1;        % 1
        s=[s0 s1]; % combine the two halves
        Y=repmat(s,1,floor(frequency*duration))*volume;  % replicate this cycle 
    case 'saw'
        period=(1/frequency);
        time=floor(period*44100); % the time of 1 period
        s=-time:1:time; % go from -1 to 1 over the time of 1 period
        rise=s*(1/time);
        Y=repmat(rise,1,floor(frequency*duration))*volume;    
    case 'triangle'
        period=(1/frequency);
        time=period*44100;
        s=-(time/2):1:time/2;
        rise=s*(1/time);
        fall=rise*-1;
        s=[rise fall];
        Y=repmat(s,1,floor(frequency*duration))*volume;
    otherwise
        Y=zeros(1,length(X));    % silence
end
        % Add the ADSR envelope by .* the two arrays
        Y=Y(1:min(length(Y), length(ADSR))).*ADSR(1:min(length(ADSR), length(Y)));
end

