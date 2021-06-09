function Vindex = WFChoose(FF)

S = size(FF,1);

Vindex = 1;
for k = 1:S
    r = randi(S);
    plot(FF(r,:));
    cmd = input(['is this waveform (' num2str(r) ') valid? '],'s');
    if(strcmp(cmd,'y'))
        Vindex = r;
        break;
    else
        continue;
    end
end
