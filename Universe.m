classdef Universe

    properties
        bodies;
        time;
    end

    methods
        %Constructor
        function obj = Universe(bodies, time)
            obj.bodies = bodies;
            obj.time = time;
        end
        function f = getGForce(body)
            disp(length(this.bodies));
            for i = 1:length(this.bodies)
                disp(i);
            end
            f = 1;
        end
    end
        
    
end




