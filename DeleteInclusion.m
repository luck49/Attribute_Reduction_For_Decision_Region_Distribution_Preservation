function [first_attr_set,second_attr_set] = DeleteInclusion(first_attr_set,second_attr_set)
%删除项之间的相互包含关系
    if all(first_attr_set==0) || all(second_attr_set==0),return ;end;
    flag=0;%代表first_attr_set和second_attr_set的取值情况，0代表相等，1代表first包含second,2代表first被second包含,3代表互不包含
    num_attr=size(first_attr_set,2);
    for p=1:num_attr
        if first_attr_set(p)==second_attr_set(p),continue;end
        if flag==0%如果为初始化状态
            if first_attr_set(p)>second_attr_set(p)
                flag=1;
            elseif first_attr_set(p)<second_attr_set(p)
                flag=2;
            end
        elseif ( flag==1 && first_attr_set(p)<second_attr_set(p) ) || ( flag==2 && first_attr_set(p)>second_attr_set(p) )
            flag=3;
        end
    end
    if flag==1%如果为first包含second状态
        first_attr_set=zeros(1,num_attr);
    elseif flag==0 || flag==2%如果为second包含first状态或者second与first相等的情况
        second_attr_set=zeros(1,num_attr);
    end
end
