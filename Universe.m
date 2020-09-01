classdef Universe

    properties
        bodies;
        timestep;
    end

    methods
        %Constructor
        function obj = Universe(bodies, timestep)
            obj.bodies   = bodies;
            obj.timestep = timestep;
        end
        
    end
        
    
end




