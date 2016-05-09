function [ distinct_matrix ] = GetMatrix( decision_table,distinct_value_matrix )
%GETMATRIX 根据已得到的区分标准值distinct_value_matrix构建可辨识矩阵
% disp(decision_table);
% disp(distinct_value_matrix);
num_condition_attr=size(decision_table,2)-1;%条件属性的个数
num_object=size(decision_table,1);%对象（记录）的个数
distinct_matrix=cell(num_object,num_object);
for i=1:num_object
    for j=i+1:num_object
        differ=zeros(1,num_condition_attr);
        if ~isequal(distinct_value_matrix(i,:),distinct_value_matrix(j,:))%如果区分值不一样
            for k=1:num_condition_attr%计算不同的属性
                if decision_table(i,k)~=decision_table(j,k)
                    differ(k)=k;
                end
            end
        end
        distinct_matrix{i,j}=differ;
    end
end
end

