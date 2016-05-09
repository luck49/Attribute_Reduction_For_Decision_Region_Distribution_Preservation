function [ decision_table ] = GetReducedDecisionTable( decision_table )
%GETREDUCEDDECISIONTABLE 对决策表进行约简
%   删除相同项
i=1;
while i<=size(decision_table,1)
    j=i+1;
    while j<=size(decision_table,1)
        if isequal(decision_table(i,:),decision_table(j,:))
            decision_table(j,:)=[];
            continue;
        end
        j=j+1;
    end
    i=i+1;
end
end

