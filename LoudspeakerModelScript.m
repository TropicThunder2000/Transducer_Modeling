%% Loudspeaker Model Theile Small Parameters

% Enter 0 if you don't have the value for that particular Parameter

Cms = 0.00016; %Enter the Cms in m/N

Re = 7.4;

RMS = 250; %watts and newton m/s

Le = 5.25e-3;

Qms = 5.15;

Qes = 0;

Qts = 0.43;

BL = 21.1;

Mms=0.132; % Enter in kg

Sd = 0.003664; %m^2

Vas = 0.03; %m^3

Qtc = 0.707;

fs = 34.3;

% Piston material is fiberglass

E = 70*10^9;%Give the young's modulus of the piston in GPA(Giga Pascals)
rho = 1500;% Density of the fiberglass (kg/m^3)
t = 0.0005; % Thickness of the piston in meters

rho0 = 1.2;
c = 345;
pref = 20e-6;
    
%% High Frequency Solution, Loudspeaker Efficiency, Loudspeaker Sensitivity and Output Acoustic Power

Lm = LoudspeakerModelling_Class(fs, Cms, Re, RMS, Le, BL, Mms, Sd, Qms, Qes, Qts, Vas, E, t, rho);

HighFreqSol = Lm.highFreqSol

LoudspeakerSens = Lm.loudspkSens

LoudspeakerEfficiency = Lm.loudspEff

OutputAcousticPower = Lm.outputAcPow

FirstModeBreakup = Lm.firstModeBreakup

LowerCutOff = Lm.lowerCutOff

TheilesmallParams = Lm.parameters

%% Plot
%%