function [ distinct_matrix ] = GetReducedMatrix( distinct_matrix )
%GETREDUCEDMATRIX 对可辨识矩阵进行约简，删除子集超集关系
num_object=size(distinct_matrix,1);
for i=1:num_object
    for j=i+1:num_object
        %如果当前为空
        if all(distinct_matrix{i,j}==0),continue;end
        for x=i:num_object
            for y=x+1:num_object
                if(x==i)&&(y<=j),continue;end
                if ~all(distinct_matrix{i,j}==0)
                    [distinct_matrix{i,j},distinct_matrix{x,y}]=DeleteInclusion(distinct_matrix{i,j},distinct_matrix{x,y});
                end
            end
        end
    end
end
end
