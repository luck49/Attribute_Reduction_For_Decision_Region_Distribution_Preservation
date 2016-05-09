function [ reduction ] = Main( decision_table )
%MAIN 基于可辨识矩阵的算法实现
%   1. 编写区分标准,GetDistinctionThoughCriterion(decision_table)函数,生成distinct_matrix;
%   2. 借助distinct_matrix进行可辨识矩阵的生成,GetMatrix(distinct_matrix);
%   3. 对可辨识矩阵的约简,删除不必要的子集超集关系,GetReducedMatrix(matrix);
%   4. 对约简后的矩阵进行规则提取,然后存入reduction中,GetReduction()
% decision_table=GetReducedDecisionTable(decision_table);%对条件属性决策属性值同时一样的对象进行删除
[decision_table,distinct_value_matrix]=GetDistinctionThroughCriterion(decision_table);%获取区分信息
distinct_matrix=GetMatrix(decision_table,distinct_value_matrix);%借助distinct_matrix进行可辨识矩阵的生成
distinct_matrix=GetReducedMatrix(distinct_matrix);%对可辨识矩阵的约简,删除不必要的子集超集关系
num_attr=size(decision_table,2);%获取属性数目
reduction=GetReduction(distinct_matrix,num_attr-1);%对约简后的矩阵进行规则提取,然后存入reduction中
end

