struct PKComplexVar
    real::Number
    imaginary::Number
    modulus::Number
    arg::Number
    PKComplexVar(r, i) = new(r, i, (r^2 + i^2)^0.5, (r == 0) ? 0 : tan(i/r))
end

function asString(var::PKComplexVar, option::Integer=0)
    outstr_::String = ""
    if option == 0
        if var.real != 0 || var.imaginary == 0
            outstr_ = outstr_ * "$(var.real)"
        end
        if var.imaginary != 0
            if var.imaginary > 0
                outstr_ = outstr_ * "+"
            end
            outstr_ = outstr_ * "$(var.imaginary)i"
        end
    elseif option == 1
        if var.imaginary == 0
            outstr_ = outstr_ * "1"
        else
            outstr_ = outstr_ * "$(var.imaginary)*exp("
            outstr_ = outstr_ * "$(var.arg)i)"
        end
    elseif option == 2
        if var.imaginary == 0
            outstr_ = outstr_ * "1"
        else
            outstr_ = outstr_ * "$(var.real)*cos($(var.arg))"
            if var.imaginary > 0
                outstr_ = outstr_ * "+"
            end
            outstr_ = outstr_ * "$(var.imaginary)i*sin($(var.arg))"
        end
    end

    return outstr_
end

function Base.:conj(var::PKComplexVar)
   return PKComplexVar(var.real, -var.imaginary)
end 

function Base.:+(first::PKComplexVar, second::PKComplexVar)
    return PKComplexVar(first.real + second.real, first.imaginary + second.imaginary)
end

function Base.:-(first::PKComplexVar, second::PKComplexVar)
    return PKComplexVar(first.real - second.real, first.imaginary - second.imaginary)
end

function Base.:*(first::PKComplexVar, second::PKComplexVar)
    real_ = (first.real*second.real) - (first.imaginary*second.imaginary)
    imag_ = (first.real*second.imaginary) + (first.imaginary*second.real)
    return PKComplexVar(real_, imag_)
end

function Base.:*(first::PKComplexVar, second::Number)
    real_ = 0
    imag_ = 0
    if first.real != 0
        real_ = first.real*second
    end
    if first.imaginary != 0
        imag_ = first.imaginary*second
    end
    return PKComplexVar(real_, imag_)
end

function Base.:*(first::Number, second::PKComplexVar)
    return second * first
end