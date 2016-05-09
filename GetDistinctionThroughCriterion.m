function [ decision_table,distinct_value_matrix ] = GetDistinctionThroughCriterion( decision_table )
%GETDISTINCTIONTHROUGHCRITERION 此处为正域的区分标准：决策值是否相等
%   返回决策值数组
%   广义决策保持约简
%   生成下面数据结构
%   C_value | num_decision_value | decision_value
%   decision_table=[C_value , decision_value];
num_object=size(decision_table,1);%记录对象个数
num_attr=size(decision_table,2);%记录属性的个数
decision_value=zeros(1,num_object);%存取决策值的矩阵
num_dec_value=0;%记录决策取值个数

for i=1:num_object%计算决策属性取值的个数
    flag=true;%记录当前对象取值是否已经被记录，true为未记录
    for j=1:num_dec_value
        if decision_table(i,num_attr)==decision_value(j)
            flag=false;
            break;
        end
    end
    if flag,num_dec_value=num_dec_value+1;decision_value(num_dec_value)=decision_table(i,num_attr);end
end
value=decision_value(1,1:num_dec_value);
num_cond=num_attr-1;%条件属性数目
decision_value=zeros(num_object,num_dec_value);%存取决策值的矩阵
dec_value_object_num=zeros(num_object,num_dec_value);%存取取该值的数目
num_dec_value=zeros(1,num_object);%存取决策属性取值的数目
cond_value=zeros(num_object,num_attr-1);%存取条件属性的属性值
num_cond_value=0;%记录条件属性值的个数
for i=1:num_object
    flag=true;%记录当前对象条件属性取值是否已经被记录，true为未记录
    for j=1:num_cond_value
        if cond_value(j,:)==decision_table(i,(1:num_cond))%已经被记录
            %更新决策值取值和决策值取值数目
            state=true;%记录当前对象决策属性取值是否已经被记录，true为未记录
            for k=1:num_dec_value(j)
                if decision_value(j,k)==decision_table(i,num_attr)%决策值已经被记录
                    dec_value_object_num(j,k)=dec_value_object_num(j,k)+1;
                    state=false;
                    break;
                end
            end
            if state%如果决策值没有被记录
                num_dec_value(j)=num_dec_value(j)+1;
                decision_value(j,num_dec_value(j))=decision_table(i,num_attr);
                dec_value_object_num(j,num_dec_value(j))=1;%取值对象数加1
            end
            flag=false;
            break;
        end
    end
    if flag%如果当前条件属性值没有被记录下来
        %条件属性相关
        num_cond_value=num_cond_value+1;
        cond_value(num_cond_value,:)=decision_table(i,(1:num_cond));
        %决策属性相关
        num_dec_value(num_cond_value)=1;
        decision_value(num_cond_value,1)=decision_table(i,num_attr);
        dec_value_object_num(num_cond_value,1)=1;%取值对象数加1
    end
end
cond_value(num_cond_value+1:num_object,:)=[];
decision_value(num_cond_value+1:num_object,:)=[];
dec_value_object_num(num_cond_value+1:num_object,:)=[];
for i=1:num_cond_value
    for j=1:size(decision_value,2)
        for k=1:size(value,2)
            if decision_value(i,j)==value(k);
                temp=decision_value(i,j);  
                decision_value(i,j)=decision_value(i,k);
                decision_value(i,k)=temp;
                    
                temp=dec_value_object_num(i,j);
                dec_value_object_num(i,j)=dec_value_object_num(i,k);
                dec_value_object_num(i,k)=temp;
            end
        end
    end
end
%disp(decision_value);
% disp(dec_value_object_num);%分布保持约简区分标志
distinct_value_matrix=dec_value_object_num;
decision_table=[cond_value,zeros(size(cond_value,1),1)];
end