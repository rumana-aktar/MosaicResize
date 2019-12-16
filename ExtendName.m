function Name=ExtendName(Name)

    aa=4283;
    C = strsplit(Name,{'_', '.'});
    
    %xx=str2num(C{2})-aa;
    str=num2str(C{2});
    len=length(str);
    
    if len==1
        whole_number=strcat('00000',str);
    elseif len==2
        whole_number=strcat('0000',str);
    elseif len==3
        whole_number=strcat('000',str);
    elseif len==4
        whole_number=strcat('00',str);   
    elseif len==5
        whole_number=strcat('0',str); 
    else
        whole_number=str;
    end
    Name=sprintf('%s_%s.%s',  C{1},whole_number, C{3});
end


