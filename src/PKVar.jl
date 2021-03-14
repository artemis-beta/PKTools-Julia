struct PKVar
    value::Number
    error::Number
end

Base.:<(first::PKVar, second::PKVar) = first.value < second.value;
Base.:<(first::PKVar, second::Number)  = first.value < second;
Base.:<(first::Number, second::PKVar) = first < second.value;
Base.:<=(first::PKVar, second::PKVar) = first < second;
Base.:<=(first::Number, second::PKVar) = first <= second.value;
Base.:<=(first::PKVar, second::Number) = first.value <= second;
Base.:(==)(first::PKVar, second::PKVar) = first.value == second.value && first.error == second.error;

function Base.:^(first::PKVar, second::Number)
    if first.value == 0 && second < 1
        return PKVar(0, 1E-310)
    end

    error_ = first.error*second*first.value^(second-1)
    value_ = first.value^second

    return PKVar(value_, error_)
end

function Sqrt(var::PKVar) 
    return var^0.5
end

function Base.:+(first::PKVar, second::PKVar)
    value_ = first.value + second.value
    error_ = (first.error^2 + second.error^2)^0.5
    return PKVar(value_, error_)
end

function Base.:-(var::PKVar)
    return PKVar(-var.value, var.error)
end

function Base.:-(first::PKVar, second::PKVar)
    return first + -second
end

function Base.:*(first::PKVar, second::PKVar)
    value_ = first.value * second.value
    error_1_ = (second.value * first.error)^2
    error_2_ = (first.value * second.error)^2
    return PKVar(value_, (error_1_ + error_2_)^0.5)
end

function Base.:*(first::PKVar, second::Number)
    return PKVar(first.value * second, first.error * second)
end

function Base.:*(first::Number, second::PKVar)
    return second * first
end

function Base.:/(first::PKVar, second::PKVar)
    value_ = first.value / second.value
    error_1_ = (first.error/second.value)^2
    error_2_ = first.value^-4*(first.value*second.error)^2
    return PKVar(value_, (error_1_ + error_2_)^0.5)
end

function Base.:/(first::PKVar, second::Number)
    return PKVar(first.value / second, first.error / second)
end

function Base.:inv(var::PKVar)
    return PKVar(var.value^-1, var.value^-2*var.error)
end

function Base.:/(first::Number, second::PKVar)
    return first * second^-1
end
