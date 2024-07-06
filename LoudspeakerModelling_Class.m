classdef LoudspeakerModelling_Class
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    properties
        fs;
        Cms;
        Re;
        RMS;
        Le;
        BL;
        Mms;
        Sd;
        Qms;
        Qes;
        Qts; 
        Vas;
        Mmd;
        Ma;
        rho0;
        c;
        pref;
        Wu;
        Ws;
        Su;
        Ss;
        a1;
        psens;
        E;
        t;
        rho;
        
    end

    methods
        function obj = LoudspeakerModelling_Class(fs, Cms, Re, RMS, Le, BL, Mms, Sd, Qms, Qes, Qts, Vas, E, t, rho)
       obj.Cms = Cms;
       obj.Re = Re;
       obj.Le = Le;
       obj.RMS = RMS;
       obj.BL = BL;
       obj.Mms = Mms;
       obj.Sd = Sd;
       obj.Qms = Qms;
       obj.rho0 = 1.2;
       obj.c = 345;
       obj.pref = 20e-6;
       obj.a1 = sqrt(obj.Sd/pi);
       obj.E = E; %Young's Modulus of the piston of the driver
       obj.rho = rho; %density of the piston
       obj.t = t;

       if Vas == 0
           obj.Vas = obj.rho0 * obj.c^2 * (obj.Sd)^2 * obj.Cms * 10^-8;
       else
       obj.Vas = Vas;
       end

       if fs == 0
           obj.fs = 1 / (2 * pi * sqrt(obj.Mms * obj.Cms));

       else
           obj.fs = fs;
       end

       if Qes == 0
           obj.Qes = (obj.Re/obj.BL^2) * (sqrt((obj.Mms/obj.Cms)));
       else
           obj.Qes = Qes;
       end

       if Qts == 0
           obj.Qts =  (obj.Qms * obj.Qes ) / (obj.Qms + obj.Qes);
       else
           obj.Qts = Qts;
       end

       end

        function Tus = highFreqSol(obj)
            obj.Ma = (8 * obj.rho0) / (3 * pi * obj.a1^2);
            
            obj.Mmd = obj.Mms - (2 * obj.Ma * obj.Sd^2);

            obj.Wu = (obj.Mms * obj.Re) / (obj.Mmd * obj.Le);

            obj.Su = 1i*obj.Wu;
            Tus = obj.Wu;

            %Tus = 1/(1+(obj.Su/obj.Wu));
            %Tus = abs(Tus);
        end

        function psensdB = loudspkSens(obj)
            obj.psens = (sqrt(2 * pi * obj.rho0)/obj.c) * obj.fs^(3/2) * sqrt((obj.Vas/(obj.Re * obj.Qes)));
            psensdB = 20 * log10 ( obj.psens/obj.pref);
        end

        function heta = loudspEff(obj)
            heta = (4 * pi^2 * obj.fs^3 * obj.Vas) ./ (obj.c^3 * obj.Qes);
        end

        function fu2 = outputAcPow(obj)
           
            fu2 =  ( sqrt(2) * (obj.c ./ obj.a1))/(2 * pi);
        end

        function f_breakup = firstModeBreakup(obj)
        f_breakup = 0.523 * (obj.t/obj.a1) * (sqrt(obj.E/obj.rho));
       % f_breakup = f_breakup * 10^3;
        end

        function f_lowerCut = lowerCutOff(obj)
        f_lowerCut = obj.fs * (sqrt(((1/(2*obj.Qts^2))-1) + sqrt(((1/(2*obj.Qts^2))-1)^2 + 1)));
        end

      function theilesmall = parameters(obj) 
           obj.Ma = (8 * obj.rho0) / (3 * pi * obj.a1^2);
            
            obj.Mmd = obj.Mms - (2 * obj.Ma * obj.Sd^2);

    theilesmall.fs = obj.fs;
    theilesmall.Cms = obj.Cms;
    theilesmall.Re = obj.Re;
    theilesmall.RMS = obj.RMS;
    theilesmall.Le = obj.Le;
    theilesmall.BL = obj.BL;
    theilesmall.Mms = obj.Mms;
    theilesmall.Sd = obj.Sd;
    theilesmall.Qms = obj.Qms;
    theilesmall.Qes = obj.Qes;
    theilesmall.Qts = obj.Qts; 
    theilesmall.Vas = obj.Vas;
    theilesmall.Mmd = obj.Mmd;
    theilesmall.Ma = obj.Ma;
    theilesmall.rho0 = obj.rho0;
    theilesmall.c = obj.c;
    theilesmall.pref = obj.pref;
    theilesmall.a1 = obj.a1;
    theilesmall.E = obj.E;
    theilesmall.t = obj.t;
    theilesmall.rho = obj.rho;
      end 

    end
end