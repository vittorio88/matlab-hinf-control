function [ nOriginPoles ] = countpolesatorigin( tf )
%COUNTPOLESATORIGIN Will count the origin poles of a tf or zpk
%   Iterate the through poles vector until null poles are not present

myzpk=zpk(tf);

if isempty(myzpk.p{1})
    nOriginPoles=0 ;
end

if ~isempty(myzpk.p{1})
    for iOriginPole=1: 1: length(myzpk.p{1})
        % if is last
        if length(myzpk.p{1})==iOriginPole
            % if last pole is null
            if myzpk.p{1}(iOriginPole) == 0
                nOriginPoles=iOriginPole; % should be 1
                return
            end
            %if first and last and not 0
            if (myzpk.p{1}(iOriginPole) ~= 0) && (iOriginPole == 1)
                nOriginPoles=0 ;
                return
            end
        end
        
        
        % if new pole is not null and prev pole was null, prev pole index
        % is pole count
        if (myzpk.p{1}(iOriginPole) ~= 0) && (myzpk.p{1}(iOriginPole - 1) == 0)
            nOriginPoles = iOriginPole - 1;
            return
        end
        
        
    end
    error('pole count not found')
end


end

